//
//  MainWeatherStatusView.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/14/24.
//

import SwiftUI

struct MainWeatherStatusView: View {
    var imageName: String
    var temperature: String
    var isNight: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(.bottom, 10)
            
            Text(temperature)
                .frame(height: 38)
                .font(.system(size: 50, weight: .medium))
                .foregroundColor(.white)
            
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    MainWeatherStatusView(imageName: "sun.max.fill", temperature: "70°", isNight: false)
}
