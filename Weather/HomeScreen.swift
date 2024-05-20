//
//  HomeScreen.swift
//  Weather
//
//  Created by user242921 on 5/17/24.
//

import SwiftUI

struct HomeScreen: View {
   
    @StateObject var locationManager = LocationManager()
        
        var userLatitude: Double {
            return locationManager.lastLocation?.coordinate.latitude ?? 0
            
        }
        
        var userLongitude: Double {
            return locationManager.lastLocation?.coordinate.longitude ?? 0
        }
    @ObservedObject var viewModel:HomeViewModel
    @State var backName = ""
    @State var tcolor : Color = .black
    @State var weather:Weather?
    
    
    var body: some View {
            NavigationView{
                    ZStack {
                        ScrollView{
                            VStack{
                                Text(weather?.location?.name ?? "no country").foregroundColor(tcolor).font(.largeTitle).bold()
                                Text(String(weather?.current?.tempC ?? 0) + "°").foregroundColor(tcolor).font(.largeTitle).bold()
                                Text(String(weather?.current?.condition?.text ?? "No condition")).foregroundColor(tcolor).font(.title)
                                HStack{
                                    Text("H:" + String( weather?.forecast?.forecastday?.first?.day?.maxtempC ?? 0) + "°").foregroundColor(tcolor).font(.title)
                                    Text("L:" + String(weather?.forecast?.forecastday?.first?.day?.mintempC ?? 0) + "°").foregroundColor(tcolor).font(.title)
                                }
                                let url = "https:" + (weather?.current?.condition?.icon ?? "")
                                AsyncImage(url: URL(string: url)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100).offset(CGSize(width: 1.0, height: -30.0)).padding(.bottom,-30)
                                
                                
                                ///////
                                ///
                                ///
                                
                                
                             /*   List(weather?.forecast?.forecastday ?? []){item in
                                    NavigationLink(destination: DetailsScreen(fday: item)){
                                        DayRow(fday: item, tcolor: tcolor)
                                    }
                                    .listRowBackground(Color.clear)
                                }.frame(width: 400, height: 300)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.clear)
                                */
                            
                                List {
                                    Section(header: Text("3 Day Forecast").foregroundColor(tcolor)){
                                          ForEach(weather?.forecast?.forecastday ?? []) { item in
                                              NavigationLink(destination: DetailsScreen(fday: item,thecolor: tcolor,backname:backName)){
                                                  DayRow(fday: item, tcolor: tcolor)
                                              }
                                              .listRowBackground(Color.clear)
                                                            }
                                      }
                                }.frame(width: 400, height: 300)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.clear)
                                
                                
                                let adaptiveColumn = [
                                    GridItem(.adaptive(minimum: 150))
                                ]
                                let data = [String(weather?.current?.windKph ?? 0.0),String(weather?.current?.humidity ?? 0.0),String(weather?.current?.feelslikeC ?? 0.0),String(weather?.current?.pressureMB ?? 0.0)]
                                
                                var d = ["Visibility","Humidity","Feel like","Pressure"]
                                
                                //var num = 0
                                LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                                    ForEach(d, id: \.self) { item in
                                        
                                        // num = num + 1
                                        VStack{
                                            Text(item).foregroundColor(tcolor)
                                            Divider().frame(height: 20).background(.clear)
                                            //                                    switch (item){
                                            //                                    case "Visibility": Text("Visibility")
                                            //                                    case "Humidity" : Text("Humidity")
                                            //                                    case "Feel like" : Text("Feel like")
                                            //                                    case "Pressure": Text("Pressure")
                                            //                                    default:
                                            //                                        "ppp"
                                            //                                    }
                                            if item == "Visibility"{
                                                Text(String(weather?.current?.windKph ?? 0.0) + "KM").foregroundColor(tcolor)
                                                    .font(.title)
                                            }
                                            if item == "Humidity"{
                                                Text(String(weather?.current?.humidity ?? 0.0) + "%").foregroundColor(tcolor)
                                                    .font(.title)
                                            }
                                            if item == "Feel like"{
                                                Text(String(weather?.current?.feelslikeC ?? 0.0) + "°").foregroundColor(tcolor)
                                                    .font(.title)
                                            }
                                            if item == "Pressure"{
                                                Text(String(weather?.current?.pressureMB ?? 0.0)).foregroundColor(tcolor)
                                                    .font(.title)
                                            }
                                            
                                        }
                                        .frame(width: 150, height: 150, alignment: .center)
                                        .background(.clear)
                                        .cornerRadius(10)
                                        
                                        
                                    }
                                }
                                
                            }
                        }
                    }
                    .background(
                        Image(backName)
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    )
                    .onAppear {
                        print("appear")
                        viewModel.loadWeather{
                            weather = viewModel.weather
                            //print(weather?.current?.condition?.icon ?? "no icon")
                            if weather?.current?.isDay == 0{
                                backName = "day"
                                tcolor = .black
                            }else{
                                backName = "night"
                                tcolor = .white
                            }
                        }
                    
                }
        }
    }
    
        
}

#Preview {
    HomeScreen(viewModel:  HomeViewModel(service: NetworkServices(), manager: LocationManager()))
}
