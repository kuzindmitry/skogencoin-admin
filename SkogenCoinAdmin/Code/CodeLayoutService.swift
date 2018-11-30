//
//  CodeLayoutService.swift
//  SkogenCoin
//
//  Created by Dmitry Kuzin on 20/11/2018.
//  Copyright © 2018 Stanislau Sakharchuk. All rights reserved.
//

import UIKit
import PinCodeTextField

class CodeLayoutService: NSObject {
    
    // - Init
    fileprivate let viewController: CodeViewController
    
    // - Manager / Service
    fileprivate var databaseManager = ProfileDatabaseManager()
    
    fileprivate var code: String = ""
    
    fileprivate var phone: String
    
    
    // - Lifecycle
    
    init(viewController: CodeViewController, phone: String?) {
        self.viewController = viewController
        self.phone = phone ?? ""
        super.init()
        
        configure()
    }
    
    func startEnterCode() {
        viewController.codeField.becomeFirstResponder()
    }

}

// MARK: -
// MARK: - Action

extension CodeLayoutService {
    
    func validateAction() {
        guard code.count == 4 else { return }
        LoadingView.shared.show()
        
        let requestLoginModel = RequestLoginModel()
        requestLoginModel.phone = phone
        requestLoginModel.password = code
        
        viewController.codeField.resignFirstResponder()
        APIClient.shared.login(requestLoginModel) { (success) in
            LoadingView.shared.dismiss()
            if success {
                self.presentHomeViewController()
            } else {
                self.viewController.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

// MARK: -
// MARK: - Navigation

fileprivate extension CodeLayoutService {
    
    func presentHomeViewController() {
        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        
        tabBarController.modalTransitionStyle = .coverVertical
        tabBarController.modalPresentationStyle = .overCurrentContext
        
        viewController.present(tabBarController, animated: true, completion: nil)
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CodeLayoutService {
    
    func configure() {
        setTextFieldsDelegate()
        viewController.codeField.keyboardType = .numberPad
    }
    
    func setTextFieldsDelegate() {
        viewController.codeField.delegate = self
    }
    
}

extension CodeLayoutService: PinCodeTextFieldDelegate {
    
    func textFieldValueChanged(_ textField: PinCodeTextField) {
        guard let code = textField.text else { return }
        self.code = code
        if code.count == 4 {
            validateAction()
        }
    }
    
    func textFieldShouldEndEditing(_ textField: PinCodeTextField) -> Bool {
        return false
    }
    
}
