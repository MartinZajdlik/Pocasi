//
//  ContentView.swift
//  Pocasi
//
//  Created by Martin Žajdlík on 31.03.2026.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapView = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.1969, longitude: 17.6242),
        span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7))
    
    let lokality = [
        Lokality(name: "Ostrožská Lhota", latitude: 48.97559, longitude: 17.46751),
        Lokality(name: "Brno", latitude: 49.19506, longitude: 16.60684)
    ]
    
    var body: some View {
        Map(coordinateRegion: $mapView, annotationItems: lokality) {lokalita in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: lokalita.latitude, longitude: lokalita.longitude))
        }
        }
    }



#Preview {
    ContentView()
}
