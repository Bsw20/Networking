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
    let number_of_lessons: Int?
    let number_of_tests: Int?
}
