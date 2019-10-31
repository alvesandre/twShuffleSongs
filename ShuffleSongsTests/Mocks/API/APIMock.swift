//
//  APIMock.swift
//  ShuffleSongsTests
//
//  Created by André Alves on 30/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import UIKit

@testable import ShuffleSongs

final class APIMockSuccess: API {
    var numberOfCallsGetSongs: Int = 0
    var numberOfCallsGetArtwork: Int = 0
    
    override func getSongs(by artistsIds: [String] = ArtistHelper.getArtistsIds(), completionBlock: @escaping SongCompletionBlock) {
        numberOfCallsGetSongs += 1
        guard let url = URL(string: "https://www.google.com.br") else {return}
        let song = Song(id: 1, artworkUrl: url, trackName: "Track Name", artistId: 1, artistName: "Artist Name", primaryGenreName: "Primary Genre Name")
        completionBlock([song], nil)
    }
    
    override func getArtwork(with artworkURL: URL, completion: @escaping ImageCompletionBlock) {
        numberOfCallsGetArtwork += 1
        completion(#imageLiteral(resourceName: "ic_appname"), nil)
    }
    
}

final class APIMockError: API {
    var numberOfCallsGetSongs: Int = 0
    var numberOfCallsGetArtwork: Int = 0
    
    override func getSongs(by artistsIds: [String] = ArtistHelper.getArtistsIds(), completionBlock: @escaping SongCompletionBlock) {
        numberOfCallsGetSongs += 1
        completionBlock(nil, NSError(domain:"", code:400, userInfo:nil))
    }
    
    override func getArtwork(with artworkURL: URL, completion: @escaping ImageCompletionBlock) {
        numberOfCallsGetArtwork += 1
        completion(nil, NSError(domain:"", code:400, userInfo:nil))
    }
    
}
