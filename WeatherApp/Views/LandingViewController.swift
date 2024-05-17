//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/10/24.
//

import UIKit
import CoreLocation

class LandingViewController: BaseViewController {
    
    // Outlets
    
    @IBOutlet weak var bg_vu: UIView!
    @IBOutlet weak var weather_img: UIImageView!
    
    
    
    let locationManager = CLLocationManager()
    
    // Constants & Variables
   
    var timer = Timer()
    var currentIndex = 0
    
    var weatherImages = ["sun.max.fill", "cloud.fill", "cloud.rain.fill", "cloud.sun.fill",
                         "cloud.sun.rain.fill", "cloud.sun.bolt.fill", "snowflake", "wind"]
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupAnimation()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    
    
    //MARK: Views and Animations Setup
    
    func setupBackground(){
        bg_vu.addGradiant(colors: [UIColor(red: 98/225, green: 189/225, blue: 249/225, alpha: 1),
                                   UIColor(red: 77/225, green: 166/225, blue: 239/225, alpha: 1),
                                   UIColor(red: 68/225, green: 158/225, blue: 247/225, alpha: 1),])
    }
    
    func setupAnimation(){
        self.timer = Timer.scheduledTimer(timeInterval: 2,
                                 target: self,
                                 selector: #selector(self.changeView),
                                 userInfo: nil,
                                 repeats: true)
    }
    
    
    @objc func changeView(){
        let currentImageName = weatherImages[currentIndex]
        if let image = UIImage(systemName: currentImageName) {
            weather_img.image = image.withRenderingMode(.alwaysOriginal)
        } else {
            print("System symbol name not found: \(currentImageName)")
        }
        
        currentIndex += 1
        currentIndex %= weatherImages.count
    }
    
    
    
    
    
    func move_to_next(coordinates: Coordinates?){
        let vc = WeatherDetailsVC(nibName: "WeatherDetailsVC", bundle: nil)
        vc.coordinates = coordinates
        let viewController = UINavigationController(rootViewController: vc)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
              else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
}


extension LandingViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        print("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        // Do something with the location data
        locationManager.stopUpdatingLocation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            location.fetchCityAndCountry { subLocality, country, error in
                let coordinates = Coordinates(city: "My Location", sublocality: subLocality, lat: location.coordinate.latitude, long: location.coordinate.longitude, is_current: true)
                
                self.move_to_next(coordinates: coordinates)
            }
            
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)")
        // Handle error
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            // Start location updates
            locationManager.startUpdatingLocation()
        } else {
            // Handle denied authorization
           
        }
    }
    
    
    
    
    
}


extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.subLocality , $0?.first?.country, $1) }
    }
}
