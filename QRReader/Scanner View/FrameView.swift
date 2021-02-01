//
//  FrameView.swift
//  QRReader
//
//  Created by Misha Kuznecov on 01/02/2021.
//

import UIKit


class FrameView: UIImageView {
    
    init() {
        let image = UIImage(named: "frame")
        super.init(image: image)
    }
    
    func setupConstraints() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: 200).isActive = true
        widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
