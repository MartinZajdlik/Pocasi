//
//  DetailView.swift
//  Pocasi
//
//  Created by Martin Žajdlík on 06.04.2026.
//

import SwiftUI

struct DetailView: View {
    
    @State private var weatherResult: VisualCrossing?
    
    let lokalita: Lokality
    
    var body: some View {
        
        VStack {
            Text(lokalita.name)
            Text("\(lokalita.latitude), \(lokalita.longitude)")
            Text("\(weatherResult?.currentConditions.temp ?? 0)")
                .onAppear{
                    stahniData(lat: lokalita.latitude, lon: lokalita.longitude)
                }
                    
                
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
                weatherResult = json
                
            }
                
            }
            
        task.resume()
    }
   
        
    }





struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let bs = Lokality(name: "Banska", latitude: 48.4587,longitude: 18.8931)
        DetailView(lokalita: bs)
    }
}


/*
 
 https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Ostro%C5%BEsk%C3%A1%20Lhota?unitGroup=metric&include=days%2Ccurrent&key=UMMRCBHL5E9736JQRB3Q2UA7G&contentType=json
 
 */
