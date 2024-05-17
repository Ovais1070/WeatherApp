//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/14/24.
//

import SwiftUI

struct BackgroundView: View {
    var isNight: Bool
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? Color("lightBlack") : Color("lightBlue"), isNight ? .black : .blue]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}


#Preview {
    BackgroundView(isNight: false)
}
