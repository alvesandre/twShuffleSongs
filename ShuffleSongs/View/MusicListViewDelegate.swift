//
//  MusicListViewDelegate.swift
//  ShuffleSongs
//
//  Created by André Alves on 28/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import UIKit

protocol MusicListViewDelegate: class {
    func viewWillAppear()
    func doShuffleSongs()
    func tableViewNumberOfRows() -> Int
    func configureCell(with cell: MusicTableViewCell, at row: Int) -> MusicTableViewCell
}
