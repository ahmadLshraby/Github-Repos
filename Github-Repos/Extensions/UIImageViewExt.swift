//
//  UIImageViewExt.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import UIKit

extension UIImageView {
    // download image from a given avatarUrl from owner objectfrom the repo model
    func downloadFrom(fromLink link:String?, contentMode mode: UIView.ContentMode) {
        let imageCache: NSCache<AnyObject, AnyObject> = NSCache()
        contentMode = mode
        if link == nil {
            self.image = UIImage(named: "noimage-found")
            return
        }
        if let url = URL(string: link!) {
            // If the image was cached before
            if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
                self.image = imageFromCache
                return
            }
            print("\nstart download: \(url.lastPathComponent)")
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
                guard let data = data, error == nil else {
                    print("\nerror on download \(error?.localizedDescription ?? "")")
                    return
                }
                DispatchQueue.main.async {
                    print("\ndownload completed \(url.lastPathComponent)")
                    // Cache the downloaded image for second use
                    if let imageToCache = UIImage(data: data) {
                        self.image = imageToCache
                        imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
                    }else {
                        self.image = UIImage(named: "noimage-found")
                    }
                }
            }).resume()
        }else {
            self.image = UIImage(named: "noimage-found")
        }
    }
}
