//  AppAppearance.swift
//  openHeroes
//
//  Created by Simón Aparicio on 10/11/2020.
//  Copyright © 2020 iPon.es All rights reserved.
//

import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        
        let appearance = UINavigationBarAppearance()
        
        // Fonts and Colors for navigationbar titles
        appearance.largeTitleTextAttributes = [
            .font: AppAppearance.Font.largeTitle,
            .foregroundColor: AppAppearance.Color.barTitles]
        appearance.titleTextAttributes = [
            .font: AppAppearance.Font.compactTitle,
            .foregroundColor: AppAppearance.Color.barTitles]

        // BackButton
        appearance.setBackIndicatorImage(
            UIImage(systemName: AppAppearance.Icon.barBack), transitionMaskImage:
            UIImage(systemName: AppAppearance.Icon.barBackTrans))
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: AppAppearance.Color.barButton]

        // Transparency
        appearance.configureWithTransparentBackground()

        // Apply appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

    }
    
    struct Color {
        
        static let highlighted = UIColor(named: "highlighted")!
        static let barButton = UIColor(named: "barButton")!
        static let barBackButton = UIColor(named: "barBackButton")!
        static let barTitles = UIColor(named: "barButton")!

        private init() {}
    }

    struct Font {
        
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
        
        private init() {}
    }

    struct Icon {
        
        static let barBack = "rectangle.grid.1x2.fill"
        static let barBackTrans = "rectangle.grid.1x2"

        private init() {}
    }

}
