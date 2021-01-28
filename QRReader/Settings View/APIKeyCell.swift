//
//  APIKeyCell.swift
//  QRReader
//
//  Created by Misha Kuznecov on 27/01/2021.
//

import UIKit

class APIKeyCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet private var keyTextField: UITextField!
    private let userData: UserData = .shared
    
    override func awakeFromNib() {
        selectionStyle = .none
        #warning("Add Text font here")
        keyTextField.delegate = self
        keyTextField.text = userData.savedAPIKey
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userData.savedAPIKey = textField.text ?? ""
    }
}
