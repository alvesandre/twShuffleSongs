//
//  MusicListViewTests.swift
//  ShuffleSongsTests
//
//  Created by André Alves on 30/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import XCTest

@testable import ShuffleSongs

class MusicListViewTests: XCTestCase {

    var sut: MusicListView?
    let delegateMock = MusicListViewDelegateMock()
    
    override func setUp() {
        sut = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "musicListView") as? MusicListView
        sut?.loadView()
        sut?.delegate = delegateMock
        
    }

    override func tearDown() {
        sut = nil
    }
    
    func testShowHudTrue() {
        sut?.showHud(show: true)
        XCTAssertTrue(sut?.activityIndicator.isAnimating ?? false)
        XCTAssertTrue(sut?.tblVwSongs.isHidden ?? false)
    }
    
    func testShowHudFalse() {
        sut?.showHud(show: false)
        XCTAssertFalse(sut?.activityIndicator.isAnimating ?? true)
        XCTAssertFalse(sut?.tblVwSongs.isHidden ?? true)
    }
    
    func testReloadData() {
        sut?.reloadData()
        XCTAssertEqual(delegateMock.numberOfCallsTableViewNumberOfRows, 0)
        XCTAssertEqual(delegateMock.numberOfCallsConfigureCell, 0)
    }
    
    func testDoShuffle() {
        sut?.doShuffle(self)
        XCTAssertEqual(delegateMock.numberOfCallsDoShuffleSongs, 1)
    }

}
