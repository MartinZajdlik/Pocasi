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
         
        ScrollView {
            VStack {
                Text("\(Date.now, format: .dateTime.day().month().year())")
                    .font(.callout)
                    .padding(.bottom, 20)
                
                HStack {
                    VStack (alignment: .leading){
                        Text(weatherResult?.currentConditions.icon ?? "")
                            .font(.system(size: 35))
                            .padding(.bottom, -30)
                        Text("\(Int(weatherResult?.currentConditions.temp ?? 0))°C")
                            .font(.system(size: 65))
                            .fontWeight(.black)
                        Text("Pocitova teplota \(Int(weatherResult?.currentConditions.feelslike ?? 0))°C")
                            .padding(.bottom, 50)
                            .padding(.top, -40)
                            .foregroundColor(.gray)
                        
                    }
                    Spacer()
                    
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .symbolRenderingMode(.multicolor)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .padding(.trailing, 20)
                }
                
                if let day = weatherResult?.days {
                    
                    ForEach(day, id: \.datetimeEpoch) { day in
                        HStack {
                            Text(denTydne(day.datetimeEpoch))
                            Spacer()
                            Text(day.icon)
                            Spacer()
                            Text("\(Int(day.temp))°C")
                        }
                    }
                    
                }
                
            }
            
        }
        .padding(20)
        .navigationTitle(lokalita.name)
        .onAppear{
            stahniData(lat: lokalita.latitude, lon: lokalita.longitude)
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
    
    func denTydne (_ num: Int) -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate( "EEEE" )
        let jsonDate = Date(timeIntervalSince1970: TimeInterval(num))
        let dateString = formatter.string(from: jsonDate).capitalized
        return dateString
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
