//
//  WeatherData.swift
//  Clima
//
//  Created by Vijendra Vaishya on 13/03/1944 Saka.
//  Copyright © 1944 Saka App Brewery. All rights reserved.
//

import Foundation
struct WeatherData : Codable{
    let name : String
    let main : Main
    let weather : [Weather]
}
struct Main : Codable{
    let temp : Double
}
struct Weather : Codable{
    let id : Int

}

