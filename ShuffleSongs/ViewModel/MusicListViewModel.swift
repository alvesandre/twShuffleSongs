//
//  MusicListViewModel.swift
//  ShuffleSongs
//
//  Created by André Alves on 28/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import UIKit

public class MusicListViewModel {
    //MARK:- Properties
    
    let navigationController: UINavigationController
    
    //MARK:- Private properties
    
    private let view: MusicListView
    
    private var songs: [Song] = []
    
    private let api: API
    
    //MARK:- Init
    
    init(view: MusicListView, navigationController: UINavigationController, api: API = .shared) {
        self.navigationController = navigationController
        self.view = view
        self.api = api
        navigationController.viewControllers = [view]
    }
    
    //MARK:- Private methods
    private func showAlert(with errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        navigationController.present(alertController, animated: true, completion: nil)
    }
    
    private func shuffleSongs(with songs: [Song]) -> [Song] {
        var songsToShuffle = songs
        var shuffledSongs: [Song] = []
        var lastArtistID: CLong = -1
        //To perform the shuffle, it is checked if there is any "last artist". If so, filters the array of unshuffled songs. After that a random song is removed and added to the shuffle song array.
        while !songsToShuffle.isEmpty  {
            var songsFiltered: [Song] = songsToShuffle
            if lastArtistID != -1 {
                songsFiltered = songsFiltered.filter({$0.artistId != lastArtistID})
            }
            if !songsFiltered.isEmpty {
                let pos = Int.random(in: 0 ..< songsFiltered.count)
                shuffledSongs.append(songsFiltered[pos])
                songsToShuffle.removeAll(where: {$0.id == songsFiltered[pos].id})
                lastArtistID = songsFiltered[pos].artistId
            } else {
                //If you only have songs by this artist to add to the shuffle, you need to replace the last song with the first one where she or the value next to her has a different artist than the last one.
                var newShuffledSongs = shuffledSongs
                for row in 0..<shuffledSongs.count {
                    let currentSong = newShuffledSongs[row]
                    if row == 0 {
                        let sideSong = newShuffledSongs[row + 1]
                        if currentSong.artistId != lastArtistID && sideSong.artistId != lastArtistID {
                            newShuffledSongs[row] = currentSong
                            newShuffledSongs.append(songsToShuffle[0])
                            songsToShuffle.remove(at: 0)
                            break
                        }
                    } else {
                        let sideSongLeft = newShuffledSongs[row - 1]
                        let sideSongRight = newShuffledSongs[row + 1]
                        if currentSong.artistId != lastArtistID && sideSongLeft.artistId != lastArtistID && sideSongRight.artistId != lastArtistID {
                            newShuffledSongs[row] = currentSong
                            newShuffledSongs.append(songsToShuffle[0])
                            songsToShuffle.remove(at: 0)
                            break
                        }
                    }
                }
                shuffledSongs = newShuffledSongs
            }
        }
        return shuffledSongs
    }
}


//MARK:- MusicListViewDelegate

extension MusicListViewModel: MusicListViewDelegate {
    
    //Description: Returns number of rows to tableView based on Songs Array returned by API.
    func tableViewNumberOfRows() -> Int {
        return songs.count
    }
    
    //Description: Returns a cell configured with a Song object.
    //parameters:
    //- cell: A MusicTableViewCell Object to configure and return itself.
    //- row: Number of row to get the correspondent object in Songs Array.
    func configureCell(with cell: MusicTableViewCell, at row: Int) -> MusicTableViewCell {
        let currentSong = songs[row]
        cell.configure(with: currentSong.artworkUrl, songName: currentSong.trackName, artistName: currentSong.artistName, genre: currentSong.primaryGenreName)
        return cell
    }
    
    //Description: Performs actions required to load view
    func viewWillAppear() {
        view.showHud(show: true)
        api.getSongs { (songs, error) in
            self.view.showHud(show: false)
            guard let songs = songs else {
                if let error = error {
                    self.showAlert(with: error.localizedDescription)
                }
                return
            }
            self.songs = songs
            self.view.reloadData()
        }
    }
    
    //Description: Performs shuffling of songs and requests view to reload Table data
    func doShuffleSongs() {
        self.songs = shuffleSongs(with: self.songs)
        view.reloadData()
    }
    
}
