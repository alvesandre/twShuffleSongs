//
//  MusicListViewModelTests.swift
//  ShuffleSongsTests
//
//  Created by André Alves on 30/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import XCTest

@testable import ShuffleSongs

class MusicListViewModelTests: XCTestCase {

    var sutSucess: MusicListViewModel?
    var sutError: MusicListViewModel?
    let view = MusicListViewMock()
    
    override func setUp() {
        let navigation = UINavigationController(rootViewController: view)
        sutSucess = MusicListViewModel(view: view, navigationController: navigation, api: APIMockSuccess())
        sutError = MusicListViewModel(view: view, navigationController: navigation, api: APIMockError())
    }

    override func tearDown() {
        sutSucess = nil
        sutError = nil
    }
    
    func testTableViewNumberOfRows() {
        sutSucess?.viewWillAppear()
        let validation = sutSucess?.tableViewNumberOfRows()
       
    
        XCTAssertEqual(view.numberOfCallsShowHud, 2)
        XCTAssertEqual(view.numberOfCallsReloadData, 1)
        XCTAssertEqual(validation, 1)
    }
    
    func testTableViewNumberOfRowsError() {
        sutError?.viewWillAppear()
        let validation = sutError?.tableViewNumberOfRows()
        XCTAssertEqual(view.numberOfCallsShowHud, 2)
        XCTAssertEqual(view.numberOfCallsReloadData, 0)
        XCTAssertEqual(validation, 0)
        
    }
    
    func testDoShuffleSongs() {
        sutSucess?.doShuffleSongs()
        XCTAssertEqual(view.numberOfCallsReloadData, 1)
    }
    
    func testViewWillAppearSucess() {
        sutSucess?.viewWillAppear()
        XCTAssertEqual(view.numberOfCallsShowHud, 2)
        XCTAssertEqual(view.numberOfCallsReloadData, 1)
    }
    
    func testViewWillAppearError() {
        sutError?.viewWillAppear()
        XCTAssertEqual(view.numberOfCallsShowHud, 2)
        XCTAssertEqual(view.numberOfCallsReloadData, 0)
    }
    

}
