//
//  WebsiteDescription.swift
//  Networking
//
//  Created by Ярослав Карпунькин on 14.09.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import Foundation

struct WebsiteDescription: Decodable {
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]?
}
