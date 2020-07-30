//
//  BeerImageView.swift
//  Drop Brewery
//
//  Created by Conor Nolan on 30/07/2020.
//  Copyright © 2020 Conor Nolan. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class BeerImageView: UIImageView {
    var task: URLSessionDataTask?
    let spinner = UIActivityIndicatorView(style: .medium)
    
    func loadImage(from url: URL) {
        addActivityIndicator()
        self.image = nil
        task?.cancel()
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = imageFromCache
            removeSpinner()
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let newImage = UIImage(data: data) else {
                print("Failed to load image from URL: \(url)")
                return
            }
            
            imageCache.setObject(newImage, forKey: url.absoluteURL as AnyObject)
            
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }
        task?.resume()
    }
    
    func addActivityIndicator() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.startAnimating()
    }
    
    func removeSpinner() {
        spinner.removeFromSuperview()
    }

}
