//
//  SearchLocationVC.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/16/24.
//

import UIKit
import CoreLocation


protocol CoordinatesDelegate {
    func passCoordinates(coordinates: Coordinates)
}

class SearchLocationVC: BaseViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel: SearchLocationVM
    
    var serachTimer: Timer?
    var delegate: CoordinatesDelegate? = nil
    
    
    init(viewModel: SearchLocationVM) {
        self.viewModel = viewModel
        super.init(nibName: "SearchLocationVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        self.searchBar.delegate = self
        self.searchBar.searchTextField.delegate = self
    }
    
    
    func registerCell(){
        self.tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        self.tableView.register(UINib(nibName: "InvalidCell", bundle: nil), forCellReuseIdentifier: "InvalidCell")
    }
    
    
    func selectLocation(location: LocationsModel){
        let geoCoder = CLGeocoder()
        let cllocation = CLLocation(latitude: location.lat ?? 0, longitude: location.lon ?? 0)
        geoCoder.reverseGeocodeLocation(cllocation) { (placemarks, error) in
            if let error = error {
                print("Error in reverse geocoding: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemarks found")
                return
            }
            
            let address = [
                placemark.subThoroughfare,
                placemark.thoroughfare,
                placemark.locality,
                placemark.subLocality,
                placemark.administrativeArea,
                placemark.postalCode,
                placemark.country
            ].compactMap { $0 }.joined(separator: ", ")
            
            print(address)
            
            let coordinates = Coordinates(
                city: placemark.locality ?? "Unknown",
                sublocality: placemark.subLocality ?? "",
                lat: location.lat ?? 0,
                long: location.lon ?? 0,
                is_current: false
            )
            
            self.viewModel.coordinates = coordinates
            
            self.delegate?.passCoordinates(coordinates: coordinates)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    func is_InvalidLocation() -> Bool{
        if self.viewModel.locations.isEmpty && !(self.searchBar.text ?? "").isEmpty {
            return true
        }
        return false
    }
    
}





extension SearchLocationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if is_InvalidLocation(){
            return 1
        }
        return self.viewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if is_InvalidLocation(){
            let cell: InvalidCell = tableView.dequeueReusableCell(withIdentifier: "InvalidCell", for: indexPath) as! InvalidCell
            cell.selectionStyle = .none
            return cell
        }
        
        let cell: SearchCell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.selectionStyle = .none
        cell.configureCell(value: self.viewModel.locations[indexPath.row].name ?? "")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !is_InvalidLocation() {
            self.selectLocation(location: self.viewModel.locations[indexPath.row])
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if is_InvalidLocation() {
            return tableView.bounds.height
        }
        
        return UITableView.automaticDimension
    }
}



extension SearchLocationVC : UISearchBarDelegate, UITextFieldDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != nil {
            self.viewModel.locations = []
            self.tableView.reloadData()
        }
    }
    
    func getSearchResult(){
        self.viewModel.fetchLocations(stringValue: self.searchBar.text ?? "", completion: { [weak self] (status) in
            switch status {
            case .sucess:
                self?.tableView.reloadData()
            case .failed:
                print("Failed")
            }
        })
    }
    
    
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,with: string)
            if serachTimer != nil{serachTimer?.invalidate()}
            if !updatedText.isEmpty {
                if searchBar.text?.count != 0{
                    self.viewModel.locations = []
                }
                serachTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] timer in
                    self?.getSearchResult()
                }
            }
            else{
                self.viewModel.locations = []
                self.tableView.reloadData()
            }
        }
        return true
    }
    
}
