//
//  MusicTableViewCell.swift
//  ShuffleSongs
//
//  Created by André Alves on 28/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    //MARK:- Static properties
    
    static let identifier: String = "MusicTableViewCell"
    static let nib: UINib = UINib(nibName: MusicTableViewCell.identifier, bundle: .main)

    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var imgVwArtwork: UIImageView!
    @IBOutlet private weak var lblTitleSong: UILabel!
    @IBOutlet private weak var lblArtistAndGenre: UILabel!
    
    
    //MARK:- LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- Configuration
    
    func configure(with imageURL: URL, songName: String, artistName: String, genre: String) {
        if let image = ImageCacher.shared.getImage(by: imageURL) {
            self.imgVwArtwork.image = image
        } else {
            activityIndicator.startAnimating()
            API.shared.getArtwork(with: imageURL) { (image, error) in
                self.activityIndicator.stopAnimating()
                if error == nil, let image = image {
                    ImageCacher.shared.addImage(with: imageURL, and: image)
                    self.imgVwArtwork.image = image
                }
            }
        }
        lblTitleSong.text = songName
        lblArtistAndGenre.text = "\(artistName) (\(genre))"
    }
    
}
