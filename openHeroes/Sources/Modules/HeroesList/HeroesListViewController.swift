//  HeroesListViewController.swift
//  openHeroes
//
//  Created by Simón Aparicio on 08/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

// MARK: (Presenter -> View)
protocol HeroesListView: AnyObject {

    func refreshView()
    func endRefreshingView()
}

class HeroesListViewController: UIViewController {
    
    struct VisualConstants {
        static let rowHeight: CGFloat = 32.0
        private init() { }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Properties
    var presenter: HeroesListPresenter?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView() // TODO: Cell design
        tableView.rowHeight = VisualConstants.rowHeight
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
        presenter?.viewDidLoad()
        configureUI()
    }
    
    @objc func reload() {
        presenter?.viewDidLoad()
    }
    
    func didTapOnCell(at indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath)
    }

}

// MARK: (Presenter -> View)
extension HeroesListViewController: HeroesListView {

    func refreshView() {
        tableView.reloadData()
        endRefreshingView()
    }
    
    func endRefreshingView() {
        refreshControl.endRefreshing()
    }
    
}


// MARK: - UITableView Delegate and Data Source
extension HeroesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter?.numberOfRows(at: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter?.getCellInfo(indexPath: indexPath)?.name
        //presenter?.configure(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        didTapOnCell(at: indexPath)
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
