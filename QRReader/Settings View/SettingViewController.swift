//
//  SettingViewController.swift
//  QRReader
//
//  Created by Misha Kuznecov on 27/01/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        setupTable()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "APIKeyCell", bundle: nil), forCellReuseIdentifier: "APIKeyCell")
        tableView.register(UINib(nibName: "SoundCell", bundle: nil), forCellReuseIdentifier: "SoundCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.tableFooterView = UIView()
    }
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "APIKeyCell", for: indexPath) as! APIKeyCell
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! SoundCell
        default:
            return UITableViewCell()
        }
    }
}
