//
//  EnterCodeViewController.swift
//  QRReader
//
//  Created by Misha Kuznecov on 29/01/2021.
//

import UIKit


class EnterCodeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private var continiueButton: UIButton!
    @IBOutlet private var apiCodeTextField: UITextField!
    private let userData: UserData = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCodeTextField.delegate = self
        
        continiueButton.layer.cornerRadius = 20
        continiueButton.isHidden = true
        
        setupTapGesture()
    }
    
// MARK: - Setup Methods
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
// MARK: - Method, that react on textField change and dissmises the button
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
              let range = Range(range, in: text) else {
            continiueButton.isEnabled = false
            continiueButton.backgroundColor = .gray
            return true
        }
        textField.text?.replaceSubrange(range, with: string)
        
        if let text = textField.text, !text.isEmpty {
            continiueButton.isHidden = false
        } else {
            continiueButton.isHidden = true
        }

        return false
    }
    
// MARK: - User Interaction Methods
    @objc private func viewTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction private func continiueButtonPressed(_ sender: Any) {
        guard let text = apiCodeTextField.text, !text.isEmpty else { return }
        userData.savedAPIKey = text
        let navVC = UINavigationController(rootViewController: StartViewController())
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}
