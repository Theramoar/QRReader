//
//  SoundCell.swift
//  QRReader
//
//  Created by Misha Kuznecov on 27/01/2021.
//

import UIKit


class SoundCell: UITableViewCell {
    @IBOutlet private var soundSwitch: UISwitch!
    private let userData: UserData = .shared
    
    override func awakeFromNib() {
        selectionStyle = .none
        soundSwitch.isOn = userData.soundEnabled ? true : false
        print(userData.soundEnabled)
        print(soundSwitch.isOn)
    }
    
    
    @IBAction func switchChanged(_ sender: Any) {
        userData.soundEnabled.toggle()
    }
}
