//
//  Extensions.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 19/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?, completionHandler: @escaping (Result<UIImage>)->Void) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            completionHandler(Result.success(cachedImage))
            return
        }
        
        if let url = URL(string: URLString) {
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                guard error == nil else {
                    
                    DispatchQueue.main.async {
                        self.image = placeHolder
                        completionHandler(Result.failure(error!))
                    }
                    return
                }
                DispatchQueue.main.async {
                    
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                            completionHandler(Result.success(downloadedImage))
                        }
                    }
                }
            })
                .resume()
        }
    }
}

    
    

