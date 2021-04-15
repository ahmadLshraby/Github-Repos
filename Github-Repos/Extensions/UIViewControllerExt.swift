//
//  UIViewControllerExt.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import UIKit

extension UIViewController {
    
    func shouldPresentLoadingView(_ status: Bool) {
        var fadeView: UIView?
        
        if status == true {
            fadeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            fadeView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            fadeView?.alpha = 0.3
            fadeView?.tag = 99
            
            let spinner = UIActivityIndicatorView()
            spinner.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            if #available(iOS 13.0, *) {
                spinner.style = .large
            } else {
                spinner.style = .whiteLarge
            }
            spinner.center = view.center
            
            view.addSubview(fadeView!)
            fadeView?.addSubview(spinner)
            
            spinner.startAnimating()
            
            fadeView?.fadeTo(alphaValue: 0.3, withDuration: 0.2)
        }else {
            for subview in view.subviews {
                if subview.tag == 99 {
                    UIView.animate(withDuration: 0.2, animations: {
                        subview.alpha = 0.0
                    }) { (finished) in
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    func shouldPresentAlertView(_ status: Bool, title: String?, alertText: String?, actionTitle: String?, errorView: UIView?) {
        var fadeView: UIView?
        
        if status == true {
            fadeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            fadeView?.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            fadeView?.alpha = 0.3
            fadeView?.tag = 100
            
            let alert = UIAlertController(title: title, message: alertText, preferredStyle: .alert)
            alert.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            let action = UIAlertAction(title: actionTitle, style: .default) { [weak self] action in
                self?.shouldPresentAlertView(false, title: nil, alertText: nil, actionTitle: nil, errorView: nil)
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            view.addSubview(fadeView!)
            
            fadeView?.fadeTo(alphaValue: 0.3, withDuration: 0.2)
        }else {
            for subview in view.subviews {
                if subview.tag == 100 {
                    UIView.animate(withDuration: 0.2, animations: {
                        subview.alpha = 0.0
                    }) { (finished) in
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    func changeNavigationBarTitleView(KVO observer: inout NSKeyValueObservation?, largeTitle title: String, smallImageName image: String) {
        observer = self.navigationController?.navigationBar.observe(\.bounds, options: [.new], changeHandler: { (navigationBar, changes) in
            if let height = changes.newValue?.height {
                if height > 44.0 {
                    self.navigationItem.titleView = nil
                    self.title = title
                } else {
                    self.title = nil
                    let logo = UIImage(named: image)
                    let imageView = UIImageView(image:logo)
                    imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                    imageView.contentMode = .scaleAspectFit
                    self.navigationItem.titleView = imageView
                }
            }
        })
    }
    
}
