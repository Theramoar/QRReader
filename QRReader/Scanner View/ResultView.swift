//
//  ResultView.swift
//  QRReader
//
//  Created by Misha Kuznecov on 27/01/2021.
//

import UIKit

class ResultView: UIView {

    var scanResult: Result? {
        didSet {
            guard let scanResult = scanResult else { return }
            isHidden = false
            switch scanResult {
            case .success:
//                resultLabel.text = "Scan successful!"
                backgroundColor = .blue
            case .alreadyChecked:
//                resultLabel.text = "Already checked in!"
                backgroundColor = .red
            }
        }
    }
    
    init() {
        let frame = CGRect(x: 0, y: 700, width: UIScreen.main.bounds.width, height: 100)
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
