//
//  HourRow.swift
//  Weather
//
//  Created by user242921 on 5/20/24.
//

import SwiftUI

struct HourRow: View {
    var hour : Hour
    var tcolor : Color
    var body: some View {
    
    let currentUnixTime = Date().timeIntervalSince1970
    let currentHour = getCurrentHourString(from: currentUnixTime)
        let sentHour = getCurrentHourString(from: Double(hour.timeEpoch ?? 0))

    HStack{
        if currentHour == sentHour && Double(hour.timeEpoch ?? 0) < (currentUnixTime + 3600){
            Text("Now").foregroundColor(tcolor).frame(width:80)
        }else{
            Text(sentHour ?? "").foregroundColor(tcolor).frame(width:80)
        }
        Spacer()
        let url = "https:" + (hour.condition?.icon ?? "")
        AsyncImage(url: URL(string: url)) { image in
                       image
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                   } placeholder: {
                       ProgressView()
                   }
                   .frame(width: 50, height: 50)
        Spacer()
        Text(String(hour.tempC ?? 0.0) + "°").foregroundColor(tcolor)

    }
    .scrollContentBackground(.hidden)
    .background(Color.clear)
  //  .listRowBackground(Color.clear)
}
}

#Preview {
    HourRow(hour: Hour(timeEpoch: 1715990400, time: "2024-05-18 00:00", tempC: 30.0, isDay: 0, condition: Condition(text: "sunny", icon: "//cdn.weatherapi.com/weather/64x64/night/113.png", code: 15)), tcolor: .black)
}


func getCurrentHourString(from unixTime: TimeInterval) -> String? {
    let date = Date(timeIntervalSince1970: unixTime)
    let formatter = DateFormatter()
    formatter.dateFormat = "h a" // Format to get the hour in 12-hour format with AM/PM
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    let hourString = formatter.string(from: date)
    print(hourString)
    return hourString
}
