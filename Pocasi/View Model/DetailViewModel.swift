//
//  DetailViewModel.swift
//  Pocasi
//
//  Created by Martin Žajdlík on 09.04.2026.
//

import MapKit
import SwiftUI
import Combine

class DetailViewModel: ObservableObject {
    @Published var weatherResult: VisualCrossing?
    
    let icon = [
        "snow":"cloud.snow.fill",
        "rain":"cloud.rain.fill",
        "fog":"cloud.fog.fill",
        "wind":"wind",
        "cloudy":"cloud.fill",
        "partly-cloudy-day":"cloud.sun.fill",
        "partly-cloudy-night":"cloud.moon.fill",
        "clear-day":"sun.max.fill",
        "clear-night":"moon.stars.fill"
    ]
    
    var czDescription: String {
        switch weatherResult?.currentConditions.icon {
        case "snow":
            return "Sněžení"
        case "rain":
            return "Déšt"
        case "fog":
            return "Mlha"
        case "wind":
            return "Vítr"
        case "cloudy":
            return "Oblačno"
        case "partly-cloudy-day", "partly-cloudy-night":
            return "Polooblačno"
        default:
            return "Jasno"
        }
    }
    
    func stahniData(lat:Double, lon: Double) {
        
        let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(lat),\(lon)?unitGroup=metric&include=days%2Ccurrent&key=\(APIKey.topSecret)&contentType=json"
     
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Missing data!")
                return
            }
            
            if let json = try? JSONDecoder().decode(VisualCrossing.self, from: data) {
                DispatchQueue.main.async {
                    self.weatherResult = json
                }
                
                
                
            }
                
            }
            
        task.resume()
    }
    
    func denTydne (_ num: Int) -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate( "EEEE" )
        let jsonDate = Date(timeIntervalSince1970: TimeInterval(num))
        let dateString = formatter.string(from: jsonDate).capitalized
        return dateString
    }
    
}
