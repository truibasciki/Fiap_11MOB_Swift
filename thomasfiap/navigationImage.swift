//
//  navigationImage.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 17/08/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem{
    func imageNavigation(){
        var imageView:UIImageView;
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "bora-jogar.png")
        imageView.image = image
        self.titleView = imageView
        
    }

}