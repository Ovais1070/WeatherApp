//
//  NoInternetVC.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/16/24.
//

import UIKit




class NoInternetView: UIView {
    
    // Initialize the image view and labels
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "wifi.exclamationmark") // Example image
        return imageView
    }()

    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No internet connection"
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textAlignment = .center
        return label
    }()

    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please make sure you are connected to the internet"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews
        addSubview(imageView)
        addSubview(mainLabel)
        addSubview(secondaryLabel)

        // Set up constraints for image view
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60)
        ])

        // Set up constraints for main label
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
        ])

        // Set up constraints for secondary label
        NSLayoutConstraint.activate([
            secondaryLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 10),
            secondaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            secondaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
        ])
    }
}
