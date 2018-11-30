//
//  PhoneLayoutService.swift
//  SkogenCoin
//
//  Created by Dmitry Kuzin on 22/11/2018.
//  Copyright © 2018 Stanislau Sakharchuk. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PhoneLayoutService {
    
    // - Init
    fileprivate let viewController: PhoneViewController
    
    // - Lifecycle
    
    init(viewController: PhoneViewController) {
        self.viewController = viewController
        
        configure()
    }
    
}

// MARK: -
// MARK: - Action

extension PhoneLayoutService {
    
    func nextAction() {
        pushCodeViewController(viewController.phoneField.currentPhone)
    }
    
}

// MARK: -
// MARK: - Navigation

extension PhoneLayoutService {
    
    func pushCodeViewController(_ phone: String?) {
        guard let phone = phone else { return }
        let codeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CodeViewController") as! CodeViewController
        codeViewController.phone = phone
        
        viewController.navigationController?.pushViewController(codeViewController, animated: true)
    }
    
}

// MARK: -
// MARK: - Validate fields

extension PhoneLayoutService {
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        viewController.nextButton.isEnabled = validPhone()
    }
    
    func validPhone() -> Bool {
        guard let text = viewController.phoneField.text else { return false }
        return text.count > 3
    }
    
}


// MARK: -
// MARK: - Configure

extension PhoneLayoutService {
    
    func configure() {
        viewController.nextButton.isEnabled = false
        setTextFieldChangedEvents()
    }
    
    func startEnterPhone() {
        viewController.phoneField.becomeFirstResponder()
    }
    
    func setTextFieldChangedEvents() {
        viewController.phoneField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }
    
}

extension PhoneNumberTextField {
    
    var currentPhone: String {
        return text?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "") ?? ""
    }
    
}
