//
//  NavigationExtension.swift
//  ShuffleSongs
//
//  Created by André Alves on 28/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setTitleColor(with color: UIColor) {
        let textAttributes = [NSAttributedString.Key.foregroundColor:color]
        self.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setBarTintColor(with color: UIColor) {
        self.navigationBar.barTintColor = color
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
       return topViewController?.preferredStatusBarStyle ?? .default
    }
}

