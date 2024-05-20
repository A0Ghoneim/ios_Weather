//
//  DetailsScreen.swift
//  Weather
//
//  Created by user242921 on 5/17/24.
//

import SwiftUI

struct DetailsScreen: View {
    var fday : Forecastday
    var thecolor : Color
    var backname : String
   // var tcolor : Color
    var body: some View {
        
        let currentUnixTime = Date().timeIntervalSince1970
       // let currentHour = getCurrentHour(from: currentUnixTime) ?? 0
        
        List(fday.hour ?? []){
            item in
            //print(item.time ?? "")
            if Double(currentUnixTime) < Double(fday.dateEpoch ?? 0) {
                HourRow(hour: item, tcolor: thecolor)
                    .listRowBackground(Color.clear)
            }else{
                if Double(item.timeEpoch ?? 0) + 3599 >= Double(currentUnixTime)   {
                    HourRow(hour: item, tcolor: thecolor)
                        .listRowBackground(Color.clear)
                }

               
            }
                
              
        }   .scrollContentBackground(.hidden)
            .background(
                Image(backname)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            )
    }
}

#Preview {
    DetailsScreen(fday: Forecastday(date: "2024-05-20", dateEpoch: 1716163200, day: Day(maxtempC: 30.0, mintempC: 7.0, avgtempC: 24.0, condition: Condition(text: "sunny", icon: "//cdn.weatherapi.com/weather/64x64/night/113.png", code: 15)), hour: [Hour(timeEpoch: 1715990400, time: "2024-05-18 00:00", tempC: 30.0, isDay: 0, condition: Condition(text: "sunny", icon: "//cdn.weatherapi.com/weather/64x64/night/113.png", code: 15))]),thecolor: .black,backname: "day")
}

func getCurrentHour(from unixTime: TimeInterval) -> Int? {
    let date = Date(timeIntervalSince1970: unixTime)
    var calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    print(hour)
    return hour
}

