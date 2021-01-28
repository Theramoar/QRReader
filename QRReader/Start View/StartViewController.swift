//
//  ViewController.swift
//  QRReader
//
//  Created by Misha Kuznecov on 27/01/2021.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet private var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 20
        navigationItem.title = "Scanner"
        #warning("gearshape is available only in iOS 14 - check other icons")
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(goToSettings))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.viewfinder"), style: .plain, target: self, action: #selector(gotToScanner))
        
        
    }
    
    @objc private func goToSettings() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func gotToScanner() {
        let vc = ScannerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func startButtonPressed(_ sender: Any) {
        gotToScanner()
    }
}

