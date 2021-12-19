//
//  AfficherViewController.swift
//  SheoDayKeychainPres
//
//  Created by Dimitri SMITH on 18/12/2021.
//

import Foundation
import UIKit

class AfficherViewController: UIViewController {
    
    @IBOutlet var nameTextFiels: UITextField!
    @IBOutlet var resultStackView: UIStackView!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resultNomLabel: UILabel!
    @IBOutlet var resultPwdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextFiels.autocorrectionType = .no
        resultStackView.isHidden = true
        resultLabel.isHidden = true
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGes)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func rechercherBtnAct(_ sender: Any) {
        
        guard let nameUser = nameTextFiels.text, !nameUser.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return print("Il faut renseigner un utilisateur !")
        }
        
        // Set Query
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: nameUser,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        
        // Check if user exist in keyChain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            resultLabel.isHidden = true
            
            // Extract the result
            if let existingItem = item as? [String:Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as?  Data,
               let password = String(data: passwordData, encoding: .utf8) {
                resultStackView.isHidden = false
                resultNomLabel.text = username
                resultPwdLabel.text = password
            }
            
        }
        else {
            resultLabel.isHidden = false
            resultLabel.text = "Quelque chose ne va pas "
        }
            dismissKeyboard()
    }
    
    
    
    
    
    
    
    
}
