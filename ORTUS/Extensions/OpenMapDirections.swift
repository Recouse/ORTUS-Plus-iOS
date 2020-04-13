//
//  OpenMapDirections.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/12/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

// https://gist.github.com/Recouse/ba9e8097d87ac5e803de960f5be573eb

import Foundation
import CoreLocation
import MapKit
import UIKit

enum OpenMapDirections {
    case appleMaps
    case googleMaps
    case waze
    case yandexMaps
    
    public static let apps: [OpenMapDirections] = [
        .appleMaps,
        .googleMaps,
        .yandexMaps
    ]
    
    public static var availableApps: [OpenMapDirections] {
        apps.filter { $0.available }
    }
    
    public var name: String {
        switch self {
        case .appleMaps:
            return "Apple Maps"
        case .googleMaps:
            return "Google Maps"
        case .waze:
            return "Waze"
        case .yandexMaps:
            return "Yandex Maps"
        }
    }
    
    public var title: String {
        switch self {
        case .appleMaps:
            return "Apple Maps"
        case .googleMaps:
            return "Google Maps"
        case .waze:
            return "Waze"
        case .yandexMaps:
            return "Yandex Maps"
        }
    }
    
    public var urlString: String {
        switch self {
        case .appleMaps:
            return "maps://"
        case .googleMaps:
            return "comgooglemaps://"
        case .waze:
            return "waze://"
        case .yandexMaps:
            return "yandexmaps://maps.yandex.com/"
        }
    }
    
    public var url: URL? {
        URL(string: urlString)
    }
    
    public var available: Bool {
        guard let url = self.url else {
            return false
        }
        
        return UIApplication.shared.canOpenURL(url)
    }
    
    public func urlStringOf(address: String) -> String {
        var url = urlString
        
        switch self {
        case .appleMaps:
            url.append("?address=\(address)")
        case .googleMaps:
            url.append("?q=\(address)")
        case .waze:
            url.append("?q=\(address)&navigate=yes")
        case .yandexMaps:
            url.append("?text=\(address)")
        }
        
        return url
    }
    
    public func urlOf(address: String) -> URL? {
        guard let url = urlStringOf(address: address).addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else {
            return nil
        }
        
        return URL(string: url)
    }
    
    public func openDirectionsOf(address: String) {
        guard let url = urlOf(address: address) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    public static func openMapAlertController(
        address: String,
        title: String = "Selection",
        message: String? = "Select Navigation App"
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        
        availableApps.forEach { app in
            alert.addAction(
                UIAlertAction(title: app.name, style: .default, handler: { _ in
                    print(app.name)
                    app.openDirectionsOf(address: address)
                })
            )
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        return alert
    }
}
