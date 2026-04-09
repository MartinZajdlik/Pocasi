//
//  ContentViewModel.swift
//  Pocasi
//
//  Created by Martin Žajdlík on 09.04.2026.
//

import MapKit
import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    var mapView = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.1969, longitude: 17.6242),
        span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7))
    
    let lokality = [
        Lokality(name: "Ostrožská Lhota", latitude: 48.97559, longitude: 17.46751),
        Lokality(name: "Brno", latitude: 49.19506, longitude: 16.60684)
    ]
    
    let iconSize: CGFloat = 30
}
