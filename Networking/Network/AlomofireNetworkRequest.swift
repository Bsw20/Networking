//
//  AlomofireNetworkRequest.swift
//  Networking
//
//  Created by Ярослав Карпунькин on 18.09.2020.
//

import Foundation
import Alamofire

class AlomofireNetworkRequest {
    static func sendRequest(url: String) {
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
