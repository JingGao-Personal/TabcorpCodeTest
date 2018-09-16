//
//  PinAnnotation.swift
//  TabcorpCodeTest
//
//  Created by Jing Gao on 16/9/18.
//  Copyright © 2018 Jing Gao. All rights reserved.
//

import MapKit

class PinAnnotation: NSObject, MKAnnotation {
    
    static let viewIdentifier: String = "AnnotationView"
    
    var id: Int
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(id: Int, coordinate: Coordinate, title: String, subtitle: String) {
        self.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longtitude)
        self.title = title
        self.id = id
        self.subtitle = ""
        super.init()
    }
    
}
