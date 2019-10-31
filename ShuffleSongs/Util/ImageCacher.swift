//
//  ImageCacher.swift
//  ShuffleSongs
//
//  Created by André Alves on 28/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import UIKit

//Descriptiioon: Singleton class to download images and keep it locally

class ImageCacher {
    
    //MARK:- Singletoon
    
    static let shared = ImageCacher()
    
    //MARK:- Propeties
    private var images : [(url: URL, image: UIImage)] = []
    
    
    //MARK:- Functions
    func addImage(with url: URL, and image: UIImage) {
        images.append((url: url, image: image))
    }
    
    func getImage(by url: URL) -> UIImage? {
        return images.first(where: {$0.url.absoluteString == url.absoluteString})?.image
    }
    
}
