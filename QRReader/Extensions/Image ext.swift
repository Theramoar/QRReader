//
//  Image ext.swift
//  QRReader
//
//  Created by Misha Kuznecov on 28/01/2021.
//

import UIKit

extension UIImage {
    static func navImageFromAsset(_ imageName: String) -> UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(named: imageName)?.withTintColor(.label, renderingMode: .alwaysOriginal)
        } else {
            return UIImage(named: imageName)
        }
    }
}
