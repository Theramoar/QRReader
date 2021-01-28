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
        setupNavigationController()
        
    }
    
    private func setupNavigationController() {
        navigationItem.title = "Scanner"
        navigationItem.prompt = ""
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.navImageFromAsset("settings"), style: .plain, target: self, action: #selector(goToSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.navImageFromAsset("nav-code-scanner"), style: .plain, target: self, action: #selector(gotToScanner))
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.backgroundColor = .systemBackground
            navigationController?.navigationBar.tintColor = .label
        } else {
            navigationController?.navigationBar.backgroundColor = .white
            navigationController?.navigationBar.tintColor = .black
        }
        
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



