//
//  SupprimerViewController.swift
//  SheoDayKeychainPres
//
//  Created by Dimitri SMITH on 18/12/2021.
//

import Foundation
import UIKit

class SupprimerController: UIViewController {
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        nameTextField.autocorrectionType = .no
        resultLabel.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dissmissKB))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dissmissKB() {
        view.endEditing(true)
    }
    
    @IBAction func supprimerBtnAct(_ sender: Any) {
        // Check TextField
        guard let username = nameTextField.text, !username.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return print("Il faut renseigner un Utilisateur")
        }
        
        // Set Query
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        
        // Find user and delete
        if SecItemDelete(query as CFDictionary) == noErr {
            resultLabel.text = "L'utilisateur a ete supprimer "
        } else {
            resultLabel.text = "Nous avons un Probleme"
        }
        resultLabel.isHidden = false
        dissmissKB()
    }
    
    
    
}
