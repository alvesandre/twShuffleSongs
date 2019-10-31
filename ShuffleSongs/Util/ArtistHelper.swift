//
//  ArtistHelper.swift
//  ShuffleSongs
//
//  Created by André Alves on 28/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import Foundation

public class ArtistHelper {
    static let plistName: String = "Artists"
    
    static func getArtistsIds() -> [String] {
        guard let path = Bundle.main.url(forResource: plistName, withExtension: "plist"),
            let dados = NSArray(contentsOf: path) else {
            return []
        }

        return dados.map { dict -> String in
            guard let dict = dict as? [String: String], let id = dict["Id"] else {
                return ""
            }
            return id
        }
    }
}
