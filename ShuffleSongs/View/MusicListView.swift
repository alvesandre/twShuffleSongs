//
//  MusicListView.swift
//  ShuffleSongs
//
//  Created by André Alves on 28/10/19.
//  Copyright © 2019 André Alves. All rights reserved.
//

import UIKit

class MusicListView: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tblVwSongs: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Properties
    var delegate: MusicListViewDelegate!

    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
        configureTableView()
        delegate?.viewWillAppear()
    }
    
    //MARK:- StatusBar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- Private Methods
    
    private func configureNavBar() {
        navigationController?.setTitleColor(with: .white)
        navigationController?.setBarTintColor(with: #colorLiteral(red: 0.2600605786, green: 0.1715548337, blue: 0.2348220348, alpha: 1))
    }
    
    private func configureTableView() {
        tblVwSongs.register(MusicTableViewCell.nib, forCellReuseIdentifier: MusicTableViewCell.identifier)
        tblVwSongs.dataSource = self
    }
    
    private func showTableView(show: Bool) {
        tblVwSongs.isHidden = !show
    }
    
    //MARK:- Public Methods
    
    func showHud(show: Bool) {
        show ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        showTableView(show: !show)
    }
    
    func reloadData() {
        tblVwSongs.reloadData()
    }
    
    //MARK:- IBActions
    
    @IBAction func doShuffle(_ sender: Any) {
        delegate?.doShuffleSongs()
    }
    

}

//MARK:- UITableViewDataSource

extension MusicListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.tableViewNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.identifier, for: indexPath) as? MusicTableViewCell, let delegate = delegate else {
            return UITableViewCell()
        }
        return delegate.configureCell(with: cell, at: indexPath.row)
    }
}
