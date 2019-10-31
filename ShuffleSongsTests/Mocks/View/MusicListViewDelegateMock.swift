//
//  MusicListViewDelegateMock.swift
//  ShuffleSongsTests
//
//  Created by André Alves on 30/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import Foundation

@testable import ShuffleSongs

class MusicListViewDelegateMock: MusicListViewDelegate {
    var numberOfCallsViewWillAppear: Int = 0
    var numberOfCallsDoShuffleSongs: Int = 0
    var numberOfCallsTableViewNumberOfRows: Int = 0
    var numberOfCallsConfigureCell: Int = 0
    
    func viewWillAppear() {
        numberOfCallsViewWillAppear += 1
    }
    
    func doShuffleSongs() {
        numberOfCallsDoShuffleSongs += 1
    }
    
    func tableViewNumberOfRows() -> Int {
        numberOfCallsTableViewNumberOfRows += 1
        return 0
    }
    
    func configureCell(with cell: MusicTableViewCell, at row: Int) -> MusicTableViewCell {
        numberOfCallsConfigureCell += 1
        return MusicTableViewCell()
    }
    
    
}
