//
//  PhoneViewController.swift
//  SkogenCoin
//
//  Created by Dmitry Kuzin on 22/11/2018.
//  Copyright © 2018 Stanislau Sakharchuk. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PhoneViewController: UIViewController {
    
    @IBOutlet weak var phoneField: PhoneNumberTextField!
    @IBOutlet weak var nextButton: UIButton!
    
    fileprivate var layoutService: PhoneLayoutService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        layoutService.startEnterPhone()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    @IBAction func nextButtonDidTap() {
        layoutService.nextAction()
    }
    
}

extension PhoneViewController {
    
    func configure() {
        layoutService = PhoneLayoutService(viewController: self)
    }
    
}
