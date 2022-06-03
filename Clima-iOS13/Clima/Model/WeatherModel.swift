//
//  WeatherModel.swift
//  Clima
//
//  Created by Vijendra Vaishya on 13/03/1944 Saka.
//  Copyright © 1944 Saka App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel{
    let conditionId: Int
    let cityName : String
    let temperature : Double
    
    var temperatureString : String {
        return String(format: "%0.1f", temperature)
    }
    
    var conditionName : String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 800:
            return "cloud.sun"
        case 801...804:
            return "cloud"
        default:
            return "Cloud"
        }
    }

}
