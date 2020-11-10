//  HeroesListViewController.swift
//  openHeroes
//
//  Created by Simón Aparicio on 08/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

// MARK: (Presenter -> View)
protocol HeroesListView: class {
    
    func onFetchHeroesListSuccess()
    func onFetchHeroesListFailure(error: String)
    func showProgress()
    func hideProgress()
    func deselectRowAt(row: Int)
}

class HeroesListViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: HeroesListPresenter?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView() // TODO: Cell design
        tableView.backgroundColor = .systemIndigo
        tableView.rowHeight = 120
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Loading…")
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        presenter?.viewDidLoad()
    }
    
    @objc func reload() {
        presenter?.refresh()
    }

}

// MARK: (Presenter -> View)
extension HeroesListViewController: HeroesListView{
    
    func onFetchHeroesListSuccess() {

        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onFetchHeroesListFailure(error: String) {
        
        self.refreshControl.endRefreshing()
    }
    
    func showProgress() {
        
        // TODO: Show progress in UI
    }
    
    func hideProgress() {
        
        // TODO: Hide progress in UI
    }
    
    func deselectRowAt(row: Int) {
        self.tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
    }
    
}


// MARK: - UITableView Delegate and Data Source
extension HeroesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter?.getCellInfo(indexPath: indexPath)?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter?.didSelectRowAt(index: indexPath.row)
        presenter?.deselectRowAt(index: indexPath.row)
    }
}


// MARK: - Configure UI
extension HeroesListViewController {
    
    func configureUI() {
        
        self.view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true

        self.navigationItem.title = "Heroes List"
    }
}
