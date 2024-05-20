//
//  HomeViewModel.swift
//  Weather
//
//  Created by user242921 on 5/17/24.
//

import Foundation

class HomeViewModel:ObservableObject{
    var service :NetworkProtocol
    var manager :LocationManager
    
    @Published var lat: Double = 0
        @Published var long: Double = 0
        @Published var weather: Weather?
    
    init(service: NetworkProtocol, manager: LocationManager) {
        self.service = service
        self.manager = manager
    }
    
    
    func loadWeather(completion : @escaping () -> Void){
        if let location = manager.lastLocation {
                   lat = location.coordinate.latitude
                   long = location.coordinate.longitude
               } else {
                   lat = 0
                   long = 0
               }
        service.fetchDataWithLatAndLong(lat:lat , long: long, decodingType: Weather.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    print("sucess vm")
                    self.weather = weather
                    completion()
                case .failure(let error):
                    print("Error fetching weather: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
}
