//
//  DayRow.swift
//  Weather
//
//  Created by user242921 on 5/20/24.
//

import SwiftUI

struct DayRow: View {
    var fday : Forecastday
    var tcolor : Color
    var body: some View {
      
        let currentUnixTime = Date().timeIntervalSince1970
        let currentDay = getDayOfWeek(from: currentUnixTime)
        let sentDay = getDayOfWeek(from: Double(fday.dateEpoch ?? 0))

        HStack{
            if currentDay == sentDay{
                Text("Today").foregroundColor(tcolor).frame(width:100)
            }else{
                Text(sentDay ?? "").foregroundColor(tcolor).frame(width:100)
            }
            Spacer()
            let url = "https:" + (fday.day?.condition?.icon ?? "")
            AsyncImage(url: URL(string: url)) { image in
                           image
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                       } placeholder: {
                           ProgressView()
                       }
                       .frame(width: 50, height: 50)
            Spacer()
            Text(String(fday.day?.mintempC ?? 0.0) + "°").foregroundColor(tcolor)
            Text(" - ").foregroundColor(tcolor)
            Text(String(fday.day?.maxtempC ?? 0.0) + "°").foregroundColor(tcolor)

        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
      //  .listRowBackground(Color.clear)
    }
}

#Preview {
   
    DayRow( fday: Forecastday(date: "2024-05-20", dateEpoch: 1716163200, day: Day(maxtempC: 30.0, mintempC: 7.0, avgtempC: 24.0, condition: Condition(text: "sunny", icon: "//cdn.weatherapi.com/weather/64x64/night/113.png", code: 15)), hour: [Hour(timeEpoch: 1715990400, time: "2024-05-18 00:00", tempC: 30.0, isDay: 0, condition: Condition(text: "sunny", icon: "//cdn.weatherapi.com/weather/64x64/night/113.png", code: 15))]),tcolor: .black)
    
}
func getDayOfWeek(from unixTime: TimeInterval) -> String? {
    let date = Date(timeIntervalSince1970: unixTime)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE" // EEEE will give us the full name of the day
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent day naming
    return dateFormatter.string(from: date)
}
