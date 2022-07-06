//
//  ViewController.swift
//  AROTPTextFieldExamples
//
//  Created by Abdul Rehman on 04/07/2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - OUTLETS
    @IBOutlet weak var defaultTextField: AROTPTextField!
    @IBOutlet weak var withoutBorderTextField: AROTPTextField!
    @IBOutlet weak var clearBgTextField: AROTPTextField!
    
    
    // MARK: - PROPERTIES
    
    
    // MARK: - ACTIONS
    
    
    // MARK: - METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOTPTextFields()
    }
    
    private func setupOTPTextFields() {
        
        defaultTextField.configure()
        setupWithoutBorderTextField()
        setupClearBgTextField()
        
    }
    
    private func setupWithoutBorderTextField() {
        
        withoutBorderTextField.otpDefaultBorderColor = .clear
        withoutBorderTextField.otpDefaultBorderWidth = 0
        withoutBorderTextField.otpFilledBorderColor = .clear
        withoutBorderTextField.otpFilledBorderWidth = 0
        withoutBorderTextField.otpDelegate = self
        withoutBorderTextField.configure()
        
    }
    
    private func setupClearBgTextField() {
        
        clearBgTextField.otpBackgroundColor = .clear
        clearBgTextField.otpFilledBackgroundColor = .clear
        clearBgTextField.otpDefaultBorderColor = .clear
        clearBgTextField.otpDefaultBorderWidth = 0
        clearBgTextField.otpFilledBorderColor = .clear
        clearBgTextField.otpFilledBorderWidth = 0
        clearBgTextField.defaultCharacter = "_"
        clearBgTextField.otpDelegate = self
        clearBgTextField.configure()
        
    }


}

extension ViewController: AROTPTextFieldDelegate {
    
    func isFinishedEnteringCode(isFinished: Bool) {
        
    }
    
    func didUserFinishEnter(the code: String) {
        print(code)
    }
    
}
