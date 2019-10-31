//
//  Song.swift
//  ShuffleSongs
//
//  Created by André Alves on 28/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import UIKit

struct Song: Decodable {
    var id: CLong
    var artworkUrl: URL
    var trackName: String
    var artistId: CLong
    var artistName: String
    var primaryGenreName: String
}
