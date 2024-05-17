//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/14/24.
//

import SwiftUI

struct DailyWeatherView: View {
    
    var dayOfWeek: String
    var imageName: String
    var min_temp: String
    var max_temp: String
    var onTap: () -> Void
    
    var body: some View {
        HStack {
            Text(dayOfWeek)
                .frame(width: 50, alignment: .leading)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
            Spacer()
            Text("Min: \(min_temp)")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            Text("Max: \(max_temp)")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
           
        }
        .frame(height: 16)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .onTapGesture {
            onTap()
        }
    }
}



