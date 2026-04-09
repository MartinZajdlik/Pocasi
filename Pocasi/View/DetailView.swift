//
//  DetailView.swift
//  Pocasi
//
//  Created by Martin Žajdlík on 06.04.2026.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var detailModel = DetailViewModel()
    
    let lokalita: Lokality
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                Text("\(Date.now, format: .dateTime.day().month().year())")
                    .font(.callout)
                    .padding(.bottom, 20)
                
                HStack {
                    VStack (alignment: .leading){
                        Text(detailModel.czDescription)
                            .font(.system(size: 35))
                            .padding(.bottom, -30)
                        Text("\(Int(detailModel.weatherResult?.currentConditions.temp ?? 0))°C")
                            .font(.system(size: 65))
                            .fontWeight(.black)
                        Text("Pocitova teplota \(Int(detailModel.weatherResult?.currentConditions.feelslike ?? 0))°C")
                            .padding(.bottom, 50)
                            .padding(.top, -40)
                            .foregroundColor(.gray)
                        
                    }
                    Spacer()
                    
                    if let unwrapIkona = detailModel.weatherResult?.currentConditions.icon {
                        Image(systemName: detailModel.icon[unwrapIkona] ?? "exclamationmark.square")
                            .resizable()
                            .symbolRenderingMode(.multicolor)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                            .padding(.trailing, 20)
                    }
                    
                }
                
                if let day = detailModel.weatherResult?.days {
                    
                    ForEach(day, id: \.datetimeEpoch) { day in
                        HStack {
                            Text(detailModel.denTydne(day.datetimeEpoch))
                                .frame(width: 100, alignment: .leading)
                            
                            
                            Spacer()
                            Image(systemName: detailModel.icon[day.icon] ?? "exclamationmark.square")
                                .symbolRenderingMode(.multicolor)
                            Spacer()
                            Text("\(Int(day.temp))°C")
                                .frame(width: 80, alignment: .trailing)
                            
                        }
                        .padding(.bottom, 3)
                        
                        Divider()
                    }
                    
                }
                
            }
            
            .padding(20)
        }
        .navigationTitle(lokalita.name)
        .navigationBarTitleDisplayMode( .large )
        .onAppear{
            detailModel.stahniData(lat: lokalita.latitude, lon: lokalita.longitude)
        }
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
