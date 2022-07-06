//
//  AROTPTextFieldDelegate.swift
//
//  Created by Abdul Rehman on 04/07/2022.
//

import UIKit

public protocol AROTPTextFieldDelegate: AnyObject {
    func isFinishedEnteringCode(isFinished: Bool)
    func didUserFinishEnter(the code: String)
}
