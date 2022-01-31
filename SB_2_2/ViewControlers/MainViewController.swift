//
//  MainViewController.swift
//  SB_2_2
//
//  Created by Артем ШАЛИН on 30.01.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewBackgroundColor(with color: UIColor)
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let settingsViewCtl = segue.destination as? SettingsViewController else { return }
        settingsViewCtl.delegate = self
        settingsViewCtl.currentColor = view.backgroundColor
        
    }

}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewBackgroundColor(with color: UIColor) {
        view.backgroundColor = color
    }
}
