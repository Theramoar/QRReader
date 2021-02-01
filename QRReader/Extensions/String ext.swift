//
//  String ext.swift
//  QRReader
//
//  Created by Misha Kuznecov on 01/02/2021.
//

import Foundation

extension String {
    func withoutUrlEncoding() -> String {
        self.replacingOccurrences(of: "%2F", with: "/")
    }
}
