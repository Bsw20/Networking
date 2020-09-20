//
//  ImageViewController.swift
//  Networking
//
//  Created by Ярослав Карпунькин on 14.09.2020.
//

import UIKit
import Alamofire

class ImageViewController: UIViewController {
    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    private let largeImageUrl = "https://i.imgur.com/3416rvI.jpg"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        completedLabel.isHidden = true
        progressView.isHidden = true
    }
    
    func fetchImage() {
        
        NetworkManager.downloadImage(url: url) { (image) in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
        

    }
    
    func fetchDataWithAlamofire(){
        AlomofireNetworkRequest.downloadImage(url: url) { (image) in
            
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }

    }
    
    func downloadImageWithProgress() {
        AlomofireNetworkRequest.onProgress = { progress in
            self.progressView.isHidden = false
            self.progressView.progress = Float(progress)
        }
        
        AlomofireNetworkRequest.completed = { completed in
            self.completedLabel.isHidden = false
            self.completedLabel.text = completed
        }
        AlomofireNetworkRequest.downloadImageWithProgress(url: url) { (image) in
            self.activityIndicator.stopAnimating()
            self.completedLabel.isHidden = true
            self.progressView.isHidden = true
            self.imageView.image = image
            
        }
    }
    
    
}
