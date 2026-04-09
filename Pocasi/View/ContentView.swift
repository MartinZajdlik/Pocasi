//
//  ContentView.swift
//  Pocasi
//
//  Created by Martin Žajdlík on 31.03.2026.
//
import MapKit
import SwiftUI

struct ContentView: View {
    
    @StateObject private var ContentModel = ContentViewModel()
    
    var body: some View {
        NavigationStack{
            
            Map(coordinateRegion: $ContentModel.mapView, annotationItems: ContentModel.lokality) {lokalita in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: lokalita.latitude, longitude: lokalita.longitude)){
                    NavigationLink{
                        DetailView(lokalita: lokalita)
                    } label:{
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .frame(width: ContentModel.iconSize, height: ContentModel.iconSize)
                                    .foregroundColor(.red)
                                
                                Text(lokalita.name)
                                    .foregroundColor(.primary)
                                    .font(.caption)
                            }
                        }
                    }
                    
                }
            }
            .ignoresSafeArea()
        }
    }
    



#Preview {
    ContentView()
}
