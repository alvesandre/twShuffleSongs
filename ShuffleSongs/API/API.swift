//
//  API.swift
//  ShuffleSongs
//
//  Created by André Alves on 28/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import UIKit

typealias SongCompletionBlock = (_ data: [Song]?, _ error: Error?) -> Void
typealias ImageCompletionBlock = (_ image: UIImage?,_ error: Error?) -> Void

public class API {
    let baseURL: String = "https://us-central1-tw-exercicio-mobile.cloudfunctions.net"
    
    static let shared = API()
    
    // Endpoint: getSongs
    // Description: Get songs of some artists
    // parameters:
    // - artiistsIds: Array of Artist Id to search in API. By default they`ll get by ArtistsHelper
    // - completionBlock: callback for async request. It can return an array of Song object or an Error object
    
    func getSongs(by artistsIds: [String] = ArtistHelper.getArtistsIds(), completionBlock: @escaping SongCompletionBlock) {
        var components = URLComponents(string: baseURL + "/lookup")
        
        components?.queryItems = [
            URLQueryItem(name: "id", value: artistsIds.joined(separator: ",")),
            URLQueryItem(name: "limit", value: "5")
        ]
        
        guard let componentsURL = components, let url = componentsURL.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10000)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil, let dataResponse = data else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
                do {
                    guard let responseJSON = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [String: Any], let results = responseJSON["results"] as? [[String: Any]] else {
                        return
                    }
                    var songs : [Song] = []
                    for result in results {
                        if let data = try? JSONSerialization.data(withJSONObject: result, options: []), let music = try? JSONDecoder().decode(Song.self, from: data) {
                          songs.append(music)
                        }
                    }
                    completionBlock(songs, nil)
                }
                catch {
                    completionBlock(nil, error)
                }
            }
        }
        task.resume()
        
    }
    
    // Endpoint: getArtwork
    // Description: Download artwork of a music album
    // parameters:
    // - artworkURL: URL for artwork of a music album.
    // - completionBlock: callback for async request. It can return an Image object or an Error object
    
    func getArtwork(with artworkURL: URL, completion: @escaping ImageCompletionBlock) {
        let task = URLSession.shared.downloadTask(with: artworkURL) { (url, response, error) in
            DispatchQueue.main.async {
                guard error == nil, let urlResponse = url else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
                do {
                    let data = try Data(contentsOf: urlResponse)
                    let image = UIImage(data: data)
                    completion(image, nil)
                }
                catch {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
}
