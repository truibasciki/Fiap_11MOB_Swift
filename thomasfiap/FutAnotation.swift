//
//  FutAnotation.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 27/08/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit
import MapKit

class FutAnotation: NSObject, MKAnnotation {
        
        var coordinate: CLLocationCoordinate2D
        var title: String?
        var subtitle: String?
        var detailURL: NSURL
        var enableInfoButton : Bool
        
        init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, detailURL: NSURL, enableInfoButton : Bool) {
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subtitle
            self.detailURL = detailURL
            self.enableInfoButton = enableInfoButton;
        }
        
        func annotationView() -> MKAnnotationView {
            let view = MKAnnotationView(annotation: self, reuseIdentifier: "CustomAnnotation")
            view.translatesAutoresizingMaskIntoConstraints = false
            view.enabled = true
            view.canShowCallout = true
            view.image = UIImage(named: "bora-jogar.png")
            view.rightCalloutAccessoryView = UIButton(type: UIButtonType.Custom)
            view.centerOffset = CGPointMake(0, -32)
            
            if(self.enableInfoButton){
                let deleteButton = UIButton(type: UIButtonType.System) as UIButton
                deleteButton.frame.size.width = 35
                deleteButton.frame.size.height = 35
                deleteButton.backgroundColor = UIColor.whiteColor()
                deleteButton.setImage(UIImage(named: "bora-jogar.png"), forState: .Normal)
                deleteButton.addTarget(self, action: "infoClicked:", forControlEvents: .TouchUpInside)
                
                view.leftCalloutAccessoryView = deleteButton
            }
            return view
        }
        
        func infoClicked(sender: AnyObject?) {
            
            print("infoClicked")
            
        }
        
    }