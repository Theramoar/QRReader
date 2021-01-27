//
//  APIKeyCell.swift
//  QRReader
//
//  Created by Misha Kuznecov on 27/01/2021.
//

import UIKit

class APIKeyCell: UITableViewCell {
    @IBOutlet private var APIKeyLabel: UILabel!
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
}
