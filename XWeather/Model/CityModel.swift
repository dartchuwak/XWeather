//
//  CityModel.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 17.01.2026.
//

import Foundation

struct City: Identifiable, Hashable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
}
