//
//  WeatherDetailsVC.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/11/24.
//

import UIKit
import SwiftUI

class WeatherDetailsVC: BaseViewController, CoordinatesDelegate {
    
    

    var coordinates: Coordinates?
    var contentView: UIHostingController<WeatherDataViews>!

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if let coordinates = coordinates {
            let weatherDataViews = WeatherDataViews(coordinates: coordinates)
            contentView = UIHostingController(rootView: weatherDataViews)
            addChild(contentView)
            view.addSubview(contentView.view)
            setupConstraint()
            
            contentView.rootView.openMenu = {
                self.openLocationSearch()
            }
            
        } else {
            // Handle the case where coordinates is nil
            print("Coordinates are nil")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    

    fileprivate func setupConstraint() {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
    
    func openLocationSearch(){
        
        let vc = SearchLocationVC(viewModel: SearchLocationVM())
        vc.delegate = self
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func passCoordinates(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
    
}
