//
//  DetailView.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/14/24.
//

import SwiftUI

struct DetailView: View {
    
    var data: Daily?
    var vm = WeatherDataVM()
    
    var body: some View {
        VStack{
            Text("Condition")
                .font(.title)
                .padding(.top, 30)
                .padding(.bottom, 30)
            
            
            Text("Temperature")
                .font(.title3)
            HStack (spacing: 10){
                ForEach(vm.intradayData(daily_data: data!), id: \.id) { data in
                    TitleValueView(data: data)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .padding(.bottom, 20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            
            
            Text("Summary")
            
            
            Text(data?.summary ?? "")
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .padding(.bottom, 20)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            Spacer()
        }
        
    }
}

#Preview {
    DetailView()
}






struct TitleValueView: View {
    
    var data: TitleValueModel
    var body: some View {
        VStack {
            Text(data.value ?? "")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
            Text(data.title ?? "")
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
}
