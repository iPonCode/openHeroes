//  HeroesListViewCell.swift
//  openHeroes
//
//  Created by Simón Aparicio on 13/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

class HeroesListViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    public static let identifier: String = "HeroesListViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.OpenHeroes.backgroundCell
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(with item: CharacterListEntity) {
        let name = item.name ?? "unknown"
        title.attributedText = NSAttributedString(string: "\(name) - (\(item.id))",
                                                  attributes: [.font: UIFont.OpenHeroes.bodyHightlighted,
                                                               .foregroundColor: UIColor.OpenHeroes.highlighted])
    }

}

