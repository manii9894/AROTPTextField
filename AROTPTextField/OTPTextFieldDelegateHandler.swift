//
//  OTPTextFieldImplementation.swift
//
//  Created by Abdul Rehman on 04/07/2022.
//

import UIKit

class OTPTextFieldDelegateHandler: NSObject, UITextFieldDelegate {
    weak var implementationDelegate: OTPTextFieldProtocol?

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < implementationDelegate?.digitalLabelsCount ?? 0 || string == ""
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.isUserInteractionEnabled = false
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isUserInteractionEnabled = true
    }
    
}

protocol OTPTextFieldProtocol: AnyObject {
    var digitalLabelsCount: Int { get }
}
