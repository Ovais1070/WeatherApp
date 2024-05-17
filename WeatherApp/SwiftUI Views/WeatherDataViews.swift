//
//  WeatherDataViews.swift
//  WeatherApp
//
//  Created by Ovais Khan on 5/11/24.
//

import SwiftUI


struct WeatherDataViews: View {
    
    @StateObject var vm = WeatherDataVM()
    @State private var isNight = false
    @State private var showAdditionalText = false
    @State private var bottomPosition: CGFloat = 0
    @State private var isSheetPresented = false
    
    var coordinates: Coordinates?
    var openMenu: (() -> Void)?
    
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNightIcon(iconCode: self.vm.weather_data?.current?.weather?[0].icon ?? ""))
            
            ScrollView {
                VStack {
                    MainWeatherStatusView(imageName: self.vm.weather_data?
                        .current?.weather?[0].icon?
                        .toWeatherSystemImage() ?? "",
                                          temperature: self.vm.weather_data?
                        .current?.temp?
                        .convertTemp(to: self.vm.temprature_type) ?? "0",
                                          isNight: self.isNight)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
                            ForEach((self.vm.weather_data?.hourly?.prefix(24) ?? []), id: \.self) { data in
                                WeatherDayView(dayOfWeek: convertUnixTimestampToTime(unixTimestamp: data.dt ?? 0, timeZone: self.vm.weather_data?.timezone ?? "") ?? "" ,
                                               imageName: data.weather?[0].icon?.toWeatherSystemImage() ?? "",
                                               temperature: data.temp?.convertTemp(to: self.vm.temprature_type) ?? "")
                            }
                        }
                    }
                    .padding(20)
                    
                    //MARK: Daily List View
                    TitleTextView(title: "\(self.vm.weather_data?.daily?.count ?? 0) days forecast")
                        .frame(height: 20)
                        .padding(.top, 25)
                    
                    VStack(spacing: 25){
                        ForEach((self.vm.weather_data?.daily ?? []), id: \.self) { data in
                            let min_temp = data.temp?.min?.convertTemp_Int(to: self.vm.temprature_type)
                            let max_temp = data.temp?.max?.convertTemp_Int(to: self.vm.temprature_type)
                            
                            DailyWeatherView(dayOfWeek: getDayOfWeek(from: data.dt ?? 0, in: self.vm.weather_data?.timezone ?? "") ?? "", imageName: data.weather?[0].icon?.toWeatherSystemImage() ?? "", min_temp: "\(min_temp ?? 0)", max_temp: "\(max_temp ?? 0)") {
                                isSheetPresented.toggle()
                                self.vm.dailyDetail = data
                            }
                            Divider()
                        }
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        DetailView(data: self.vm.dailyDetail)
                            .presentationDetents([.height(.infinity)])
                            .presentationDragIndicator(.visible)
                            .background(.black)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                    
                    //Grid View
                    LazyVGrid(columns: self.vm.columns) {
                        ForEach(self.vm.setupGridDataSource(), id: \.id) { item in
                            GridCells(data: item)
                        }
                    }
                    
                    Spacer()
                }
                .onAppear{
                    fetchWeatherData()
                }
            }
            .refreshable {
                print("refresh data")
                fetchWeatherData()
            }
            .padding(.top, 100)
            
            // Sticky header for CityTextView
            VStack(spacing: 0){
                
                CityTextView(cityName: coordinates?.city ?? "")
                    .frame(height: 20)
                
                if showAdditionalText {
                    SubLocationTextView(subName: "\(self.vm.weather_data?.current?.temp?.convertTemp(to: self.vm.temprature_type) ?? "0") | \(coordinates?.sublocality ?? "")" )
                        .frame(height: 20)
                        .padding(.top, 16)
                } else {
                    SubLocationTextView(subName: coordinates?.sublocality ?? "")
                        .frame(height: 20)
                        .padding(.top, 16)
                }
                Spacer()
            }
            .padding(.top, 20)
            
            VStack{
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.openMenu?()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .imageScale(.small)
                    })
                    .frame(width: 20, height: 20)
                    .buttonStyle(.plain)
                    .padding(.top, 16)
                    .padding(.trailing, 20)
                }
                Spacer()
            }
        }
    }
    
    //MARK: Functions
    
    private func convertUnixTimestampToTime(unixTimestamp: TimeInterval, timeZone: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        dateFormatter.dateFormat = "ha"
        
        let date = Date(timeIntervalSince1970: unixTimestamp)
        return dateFormatter.string(from: date)
    }
    
    func getDayOfWeek(from unixTimestamp: TimeInterval, in timeZone: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        dateFormatter.dateFormat = "EEE"
        
        let date = Date(timeIntervalSince1970: unixTimestamp)
        
        let now = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: timeZone) ?? TimeZone.current
        
        if calendar.isDate(date, inSameDayAs: now) {
            return "Today"
        }
        
        return dateFormatter.string(from: date)
    }
    
    private func isNightIcon(iconCode: String) -> Bool {
        guard let lastChar = iconCode.last else {
            return false
        }
        return lastChar == "n"
    }
    
    func handleScroll(_ offset: CGPoint) {
        if offset.y <= (-148.66666666666666) {
            showAdditionalText = true
        } else {
            showAdditionalText = false
        }
    }
    
    private func fetchWeatherData() {
        if let coordinates = self.coordinates {
            vm.fetchWeatherData(coordinates: coordinates) { status in
                switch status {
                case .failed:
                    print("API Failed")
                default:
                    break
                }
            }
        }
    }
}

#Preview {
    WeatherDataViews(coordinates: Coordinates(city: "My Location", sublocality: "Manhattan", lat: 0, long: 0, is_current: true))
}

struct TitleTextView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct GridCells: View {
    var data: GridDataModel?
    
    var body: some View {
        VStack {
            HStack(spacing: 2){
                Image(systemName: data?.imageName ?? "")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    
                Text(data?.type.rawValue ?? "")
                    .frame(height: 20)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white)
            }
            .frame(height: 20)
            
           Text(data?.value ?? "")
                .font(.system(size: 23, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(.ultraThinMaterial)
        .cornerRadius(8)
        .padding()
    }
}

struct WindCell: View {
    var data: GridDataModel?
    
    var body: some View {
        VStack {
            HStack(spacing: 2){
                Image(systemName: data?.imageName ?? "")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    
                Text(data?.type.rawValue ?? "")
                    .frame(height: 20)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white)
            }
            .frame(height: 20)
            
           Text(data?.value ?? "")
                .font(.system(size: 23, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(.ultraThinMaterial)
        .cornerRadius(8)
        .padding()
    }
}
