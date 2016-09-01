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
            let view = MKAnnotationView(annotation: self, reuseIdentifier: "FutAnnotation")
            view.translatesAutoresizingMaskIntoConstraints = false
            view.enabled = true
            view.canShowCallout = true
            
            let pinImage = UIImage(named: "bora-jogar.png")//Imagem do Pin
            let size = CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContext(size)
            pinImage!.drawInRect(CGRectMake(0, 0, size.width, size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            view.image = resizedImage
            view.rightCalloutAccessoryView = UIButton(type: UIButtonType.Custom)
            view.centerOffset = CGPointMake(0, -32)
            
            if(self.enableInfoButton){
                let deleteButton = UIButton(type: UIButtonType.Custom)
                deleteButton.frame.size.width = 35
                deleteButton.frame.size.height = 35
                deleteButton.backgroundColor = UIColor.whiteColor()
                let btnImage = UIImage(named: "bora-jogar.png")//Imagem dentro da annotation
                let sizeImage = CGSize(width: 35, height: 35)
                UIGraphicsBeginImageContext(sizeImage)
                btnImage!.drawInRect(CGRectMake(0, 0, sizeImage.width, sizeImage.height))
                let resizedBtnImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                deleteButton.setImage(resizedBtnImage, forState: .Normal)
                
                view.leftCalloutAccessoryView = deleteButton
            }
            return view
        }
         
        
    }