//
//  CodeViewController.swift
//  SkogenCoin
//
//  Created by Dmitry Kuzin on 20/11/2018.
//  Copyright © 2018 Stanislau Sakharchuk. All rights reserved.
//

import UIKit
import PinCodeTextField

class CodeViewController: UIViewController {
    
    @IBOutlet weak var firstNumberField: UITextField!
    @IBOutlet weak var secondNumberField: UITextField!
    @IBOutlet weak var thirdNumberField: UITextField!
    @IBOutlet weak var fourNumberField: UITextField!
    
    @IBOutlet weak var codeField: PinCodeTextField!
    
    var phone: String?
    
    fileprivate var layoutService: CodeLayoutService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        layoutService.startEnterCode()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension CodeViewController {
    
    func configure() {
        setupLayoutService()
    }
    
    func setupLayoutService() {
        layoutService = CodeLayoutService(viewController: self, phone: phone)
    }
    
}

