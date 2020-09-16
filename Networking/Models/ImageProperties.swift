//
//  ImageProperties.swift
//  Networking
//
//  Created by Ярослав Карпунькин on 16.09.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import Foundation
import UIKit

struct ImageProperties {
    let key: String
    let data: Data
    
    init?(withImage image: UIImage, forKey key: String){
        self.key = key
        guard let data = image.pngData() else {
            return nil
        }
        
        self.data = data
    }
}
