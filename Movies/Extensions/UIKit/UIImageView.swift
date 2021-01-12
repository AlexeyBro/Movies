//
//  UIImageView.swift
//  Movies
//
//  Created by Alex Bro on 21.12.2020.
//

import UIKit

private enum Cache {
    static let imageCache = NSCache<AnyObject, AnyObject>()
}


extension UIImageView {
    convenience init(image: UIImage? = nil,
                     tintColor: UIColor = .blue,
                     contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.init()
        
        self.image = image
        self.tintColor = tintColor
        self.contentMode = contentMode
    }
    
    func setImage(URLString: String) {
        if let imageFromCache = Cache.imageCache.object(forKey: URLString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        guard let url = URL(string: URLString) else { return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        URLSession.shared.dataTask(with: request) { data, response, error in
            let response = response as? HTTPURLResponse
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data, response?.statusCode == 200 {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data){
                        Cache.imageCache.setObject(imageToCache, forKey: URLString as AnyObject)
                        self.image = imageToCache
                    }
                }
            }
        }.resume()
    }
}

