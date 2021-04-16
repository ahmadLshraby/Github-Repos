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
        contentMode = mode
        if link == nil {
            self.image = UIImage(named: "noimage-found")
            return
        }
        if let url = URL(string: link!) {
            print("\nstart download: \(url.lastPathComponent)")
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
                guard let data = data, error == nil else {
                    print("\nerror on download \(error?.localizedDescription ?? "")")
                    return
                }
                DispatchQueue.main.async {
                    print("\ndownload completed \(url.lastPathComponent)")
                    self.image = UIImage(data: data)
                }
            }).resume()
        }else {
            self.image = UIImage(named: "noimage-found")
        }
    }
}
