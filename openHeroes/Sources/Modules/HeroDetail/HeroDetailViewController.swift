//  HeroDetailViewController.swift
//  openHeroes
//
//  Created by Simón Aparicio on 13/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

// MARK: (Presenter -> View)
protocol HeroDetailView: AnyObject {
    func refreshView()
}

class HeroDetailViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Properties
    var presenter: HeroDetailPresenter?
    
    lazy var rawDataText: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = AppAppearance.Color.backgroundCell
        textView.attributedText = NSAttributedString(string: "Loading (placeholder) …",
                                                     attributes: [.font: AppAppearance.Font.bodyText,
                                                                  .foregroundColor: AppAppearance.Color.bodyText])
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isSelectable = true
        textView.contentMode = .scaleAspectFit
        return textView
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
}

// MARK: (Presenter -> View)
extension HeroDetailViewController: HeroDetailView {

    func refreshView() {
        guard let presenter = presenter else { return }
        let config: (String, String) = presenter.configure()
        self.navigationItem.title = config.0
        rawDataText.text = config.1
    }
}

// MARK: - Configure UI
extension HeroDetailViewController {
    
    func configureUI() {
        view.backgroundColor = AppAppearance.Color.backgroundTable
        self.view.addSubview(rawDataText)

        rawDataText.translatesAutoresizingMaskIntoConstraints = false
        rawDataText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        rawDataText.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        rawDataText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        rawDataText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true;
        rawDataText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rawDataText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        self.navigationItem.title = "Hero Detail"
    }
}
