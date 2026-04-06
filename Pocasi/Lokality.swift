//
//  Lokality.swift
//  Pocasi
//
//  Created by Martin Žajdlík on 31.03.2026.
//

import Foundation

struct Lokality: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}
