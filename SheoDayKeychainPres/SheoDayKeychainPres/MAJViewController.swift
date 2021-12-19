//
//  MAJViewController.swift
//  SheoDayKeychainPres
//
//  Created by Dimitri SMITH on 18/12/2021.
//

import Foundation
import UIKit

class MAJViewController: UIViewController {
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var pwdTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        nameTextField.autocorrectionType = .no
        pwdTextField.autocorrectionType = .no
        resultLabel.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyB))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dissmissKeyB() {
        view.endEditing(false)
    }
    
    
    @IBAction func MAJBtnAct(_ sender: Any) {
        // Check TextField
        guard let username = nameTextField.text, !username.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return print("Il nous faut un utilisateur !")
        }
        
        guard let pwd = pwdTextField.text, !pwd.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return print("Il faut renseigner le nouveau mot de passe")
        }
        
        // Set Query
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        
        // Set Attribute for new PassWord
        let attributes: [String:Any] = [kSecValueData as String: pwd.data(using: .utf8)!]
        
        // Find User to Modify
        if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr {
            resultLabel.text = "Mot de Passe mis a jour"
        } else {
            resultLabel.text = "Nous avons un probleme"
        }
        resultLabel.isHidden = false
        dissmissKeyB()
    }
}
