//
//  ResultView.swift
//  QRReader
//
//  Created by Misha Kuznecov on 27/01/2021.
//

import UIKit

class ResultView: UIView {
    
    var scanMessage: String?
    var scanLabel: UILabel!
    private var timer: Timer?
    
    var scanResult: NetworkAnswer? {
        didSet {
            guard let scanResult = scanResult else { return }
            timer?.invalidate()
            
            switch scanResult {
            case .successfulCheckIn:
                backgroundColor = .green
            case .alreadyCheckedIn:
                backgroundColor = .red
            case .wrongAPIKey:
                backgroundColor = .red
            case .failure:
                backgroundColor = .red
            }
            scanLabel.text = scanMessage ?? scanResult.rawValue
            
            UIView.animate(withDuration: 0.5) {
                self.scanLabel.alpha = 1
                self.alpha = 1
            } completion: { _ in
                let date = Date().addingTimeInterval(3)
                self.timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(self.dismissView), userInfo: nil, repeats: false)
                RunLoop.main.add(self.timer!, forMode: .common)
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    func setupConstraints() {
        setupViewConstraints()
        setupLabelConstraints()
    }
    
    @objc private func viewTapped() {
        timer?.invalidate()
        dismissView()
    }
    
    @objc private func dismissView() {
        UIView.animate(withDuration: 0.5) {
            self.scanLabel.alpha = 0
            self.alpha = 0
            self.timer?.invalidate()
        }
    }
    
    private func setupViewConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: 120).isActive = true
        alpha = 0
    }
    
    private func setupLabelConstraints() {
        scanLabel = UILabel()
        addSubview(scanLabel)
        scanLabel.translatesAutoresizingMaskIntoConstraints = false
        scanLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        scanLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
        scanLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        scanLabel.textAlignment = .center
        scanLabel.numberOfLines = 0
        scanLabel.textColor = .white
        scanLabel.font = .systemFont(ofSize: 15, weight: .heavy)
        scanLabel.alpha = 0
    }
}
