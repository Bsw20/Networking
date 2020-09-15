//
//  MainViewController.swift
//  Networking
//
//  Created by Ярослав Карпунькин on 14.09.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit
enum Actions: String, CaseIterable {
    case downloadImage = "Download Image"
    case get = "GET"
    case post = "POST"
    case ourCourses = "Our Courses"
    case uploadImage = "Upload Image"
    
}

class MainViewController: UICollectionViewController {
    private let url = "https://jsonplaceholder.typicode.com/posts"
    let actions = Actions.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadView() {
        super.loadView()
        
        self.title = "Controls"
    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label.text = actions[indexPath.row].rawValue
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        switch action {
        case .downloadImage:
            print("download")
            performSegue(withIdentifier: "ShowImage", sender: self)

        case .get:
            NetworkManager.getRequest(url: url)
            print("get")
        case .post:
            NetworkManager.postRequest(url: url)
            print("Post")
        case .ourCourses:
            performSegue(withIdentifier: "OurCourses", sender: self)
        case .uploadImage:   
            print("Upload Image")
        default:
            break
        }
    }

}
