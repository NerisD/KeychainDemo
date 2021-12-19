//
//  CreerViewController.swift
//  SheoDayKeychainPres
//
//  Created by Dimitri SMITH on 18/12/2021.
//
import Security
import Foundation
import UIKit

class CreerViewController: UIViewController {
    
    @IBOutlet var nameTexField: UITextField!
    @IBOutlet var pwdTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTexField.autocorrectionType = .no
        pwdTextField.autocorrectionType = .no
        resultLabel.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyBoard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dissmissKeyBoard() {
        view.endEditing(true)
    }
    
    @IBAction func saveBtnAct(_ sender: Any) {
        
        // Check Texfields
        guard let username = nameTexField.text, !username.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return print("Vous devez renseigner un Nom")
        }
        guard let pwd = pwdTextField.text, !pwd.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return print("Vous devez renseigner un MdP")
        }
        
        // Set Attributes
        let attributes : [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: pwd.data(using: .utf8) as Any
        ]
        
        // Add User
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            resultLabel.text = "L'utilisateur Ajouté"
        }
        else {
            resultLabel.text = "Problème"
        }
        resultLabel.isHidden = false
        dissmissKeyBoard()
    }
    
    
    
    
    
    
    
}
