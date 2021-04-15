//
//  UIViewExt.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import UIKit

extension UIView{
    
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
}
