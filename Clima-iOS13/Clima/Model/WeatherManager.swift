//
//  WeatherManager.swift
//  Clima
//
//  Created by Vijendra Vaishya on 13/03/1944 Saka.
//  Copyright © 1944 Saka App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager : WeatherManager, _ weather: WeatherModel)
    func didFailWithError(error : Error)
}
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d210640fb563180459dbc1d9ec0b9fdb&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performReguest(with : urlString  )
        
    }
    func fetchWeather(latitude: CLLocationDegrees,longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performReguest(with : urlString  )
        
    }
    func performReguest(with urlString : String){
        //1. Create a URL
        if let url = URL(string: urlString){
            //2. Create a URL session
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data,response,error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
            
        }
    }
    func parseJSON(_ weatherData : Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do{
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
