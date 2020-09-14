//
//  Course.swift
//  Networking
//
//  Created by Ярослав Карпунькин on 14.09.2020.
//

import Foundation

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
