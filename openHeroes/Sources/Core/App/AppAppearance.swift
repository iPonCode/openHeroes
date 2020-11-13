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
        
        // Navigationbar titles
        appearance.largeTitleTextAttributes = [
            .font: UIFont.OpenHeroes.largeTitle,
            .foregroundColor: UIColor.OpenHeroes.barTitles]
        appearance.titleTextAttributes = [
            .font: UIFont.OpenHeroes.compactTitle,
            .foregroundColor: UIColor.OpenHeroes.barTitles]
        appearance.configureWithTransparentBackground()

        // BackButton
        appearance.setBackIndicatorImage(
            UIImage(systemName: SFSymbol.OpenHeroes.barBack), transitionMaskImage:
            UIImage(systemName: SFSymbol.OpenHeroes.barBackTrans))
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.OpenHeroes.barButton]

        // Apply appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
