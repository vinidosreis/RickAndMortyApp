//
//  RMTabBarController.swift
//  RickAndMorty
//
//  Created by Vinicius dos Reis Morgado Brancalliao on 07/03/23.
//

import UIKit

final class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpControllers()
    }
    
    private func setUpControllers() {
        let characterVC = RMCharacterViewController()
        let locationVC = RMLocationViewController()
        let episodeVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()
        let characterNC = UINavigationController(rootViewController: characterVC)
        let locationNC = UINavigationController(rootViewController: locationVC)
        let episodeNC = UINavigationController(rootViewController: episodeVC)
        let settingsNC = UINavigationController(rootViewController: settingsVC)
        
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        characterNC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        locationNC.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        episodeNC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        settingsNC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)


        
        for nav in [characterNC, locationNC, episodeNC, settingsNC] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([characterNC, locationNC, episodeNC, settingsNC], animated: true)
    }

}
