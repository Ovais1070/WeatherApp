//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/16/24.
//

import UIKit
import Combine

class BaseViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    private var noInternetView: NoInternetView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager),  name: .flagsChanged, object: nil)
        
        updateUserInterface()
    }
    
    
    func updateUserInterface() {
        switch Network.reachability.status {
        case .unreachable:
            self.openNoInternetView()
        case .wwan, .wifi:
            removeNoInternetView()
       
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    
   
    
    
    
    func openNoInternetView(){
        let noInternetView = NoInternetView()
        noInternetView.layer.backgroundColor = UIColor.black.cgColor
        noInternetView.layer.name = "no_internet_view"
        self.noInternetView = noInternetView
        view.addSubview(noInternetView)
        
        // Set up constraints for NoInternetView to be full screen
        NSLayoutConstraint.activate([
            noInternetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noInternetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noInternetView.topAnchor.constraint(equalTo: view.topAnchor),
            noInternetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func removeNoInternetView() {
            // Remove the NoInternetView from its superview
            noInternetView?.removeFromSuperview()
            noInternetView = nil
        }
    
}
