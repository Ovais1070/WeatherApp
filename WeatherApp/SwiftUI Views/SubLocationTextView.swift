//
//  SubLocationTextView.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/14/24.
//

import SwiftUI

struct SubLocationTextView: View {
    
    var subName: String
    
    var body: some View {
        Text(subName.uppercased())
            .font(.system(size: 18, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}



#Preview {
    SubLocationTextView(subName: "")
}
