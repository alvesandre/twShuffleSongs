//
//  MusicListViewMock.swift
//  ShuffleSongsTests
//
//  Created by André Alves on 30/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import Foundation

@testable import ShuffleSongs

final class MusicListViewMock: MusicListView {
    var numberOfCallsShowHud: Int = 0
    var numberOfCallsReloadData: Int = 0
    
    override func showHud(show: Bool) {
        numberOfCallsShowHud += 1
    }
    
    override func reloadData() {
        numberOfCallsReloadData += 1
    }
}
