//
//  WeatherApp.swift
//  Weather
//
//  Created by user242921 on 5/17/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    init() {
           UITableView.appearance().backgroundColor = .clear
           UITableViewCell.appearance().backgroundColor = .clear
       }
    var body: some Scene {
        WindowGroup {
            HomeScreen(viewModel:  HomeViewModel(service: NetworkServices(), manager: LocationManager()))
        }
    }
}
