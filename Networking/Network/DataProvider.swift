//
//  DataProvider.swift
//  Networking
//
//  Created by Ярослав Карпунькин on 17.09.2020.
//

import UIKit

class DataProvider: NSObject {
    //variables
    var downloadTask: URLSessionDownloadTask!
    var fileLocation: ((URL) -> ())?
    var onProgress: ((Double) -> ())?
    
    private lazy var bgsession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "Bsw20.Networking")
//        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func startDownload() {
        let url = "https://speed.hetzner.de/100MB.bin"
        if let url = URL(string: url) {
            downloadTask = bgsession.downloadTask(with: url)
            downloadTask.earliestBeginDate = Date().addingTimeInterval(3)
            downloadTask.countOfBytesClientExpectsToSend = 512
            downloadTask.countOfBytesClientExpectsToReceive = 100 * 1024 * 1024
            downloadTask.resume()
            
        }
        
    }
    
    func stopDowload() {
        downloadTask.cancel()
    }
}

extension DataProvider: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let completionHandler = appDelegate.bgSessionCompletionHandler
            else { return }
            
            appDelegate.bgSessionCompletionHandler = nil
            completionHandler()
        }
    }
}

extension DataProvider: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Downloading finished: \(location.absoluteString)")
        
        DispatchQueue.main.async {
            self.fileLocation?(location)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else  { return }
        
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        print("Download progress: \(progress * 100)%")
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
    }
    
    
}

extension DataProvider: URLSessionTaskDelegate {
    
    //восстановление соединения
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        // Ожидание соединения, обновление интерфейса и прочее
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        //did finish collecting metrics
    }
}

