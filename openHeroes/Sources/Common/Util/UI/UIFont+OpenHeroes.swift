//  UIFont+OpenHeroes.swift
//  openHeroes
//
//  Created by Simón Aparicio on 13/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

extension UIFont {
    
    struct OpenHeroes {
        
        static var largeTitle: UIFont {
            get {
                let fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
                if let descriptor = UIFont.systemFont(ofSize: fontSize, weight: .black)
                    .fontDescriptor.withDesign(.rounded) {
                    return UIFont(descriptor: descriptor, size: fontSize)

                } else {
                    return UIFont.preferredFont(forTextStyle: .largeTitle)
                }
            }
        }
        
        static var compactTitle: UIFont {
            get {
                let fontSize = UIFont.preferredFont(forTextStyle: .title1).pointSize
                if let descriptor = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
                    .fontDescriptor.withDesign(.rounded) {
                    return UIFont(descriptor: descriptor, size: fontSize)

                } else {
                    return UIFont.preferredFont(forTextStyle: .title1)
                }
            }
        }

        static var barButton: UIFont {
            get {
                let fontSize = UIFont.preferredFont(forTextStyle: .title3).pointSize
                if let descriptor = UIFont.systemFont(ofSize: fontSize, weight: .bold)
                    .fontDescriptor.withDesign(.rounded) {
                    return UIFont(descriptor: descriptor, size: fontSize)

                } else {
                    return UIFont.preferredFont(forTextStyle: .headline)
                }
            }
        }
        
        static var bodyText: UIFont {
            get {
                let fontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
                if let descriptor = UIFont.systemFont(ofSize: fontSize, weight: .medium)
                    .fontDescriptor.withDesign(.rounded) {
                    return UIFont(descriptor: descriptor, size: fontSize)

                } else {
                    return UIFont.preferredFont(forTextStyle: .body)
                }
            }
        }
        
        static var bodyHightlighted: UIFont {
            get {
                let fontSize = UIFont.preferredFont(forTextStyle: .subheadline).pointSize
                if let descriptor = UIFont.systemFont(ofSize: fontSize, weight: .medium)
                    .fontDescriptor.withDesign(.rounded) {
                    return UIFont(descriptor: descriptor, size: fontSize)

                } else {
                    return UIFont.preferredFont(forTextStyle: .subheadline)
                }
            }
        }

    }
}

