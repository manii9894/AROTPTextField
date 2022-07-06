//
//  AROTPTextField.swift
//
//  Created by Abdul Rehman on 04/07/2022.
//

import UIKit

public class AROTPTextField: UITextField {
    // MARK: - PROPERTIES
    //
    /// The default character placed in the text field slots
    public var defaultCharacter = ""
    /// The default background color of the text field slots before entering a character
    public var otpBackgroundColor: UIColor = .systemGray6
    /// The default background color of the text field slots after entering a character
    public var otpFilledBackgroundColor: UIColor = .systemGray6
    /// The default corner raduis of the text field slots
    public var otpCornerRaduis: CGFloat = 7.55
    /// The default border color of the text field slots before entering a character
    public var otpDefaultBorderColor: UIColor = .gray
    /// The border color of the text field slots after entering a character
    public var otpFilledBorderColor: UIColor = .gray
    /// The default border width of the text field slots before entering a character
    public var otpDefaultBorderWidth: CGFloat = 0.47
    /// The border width of the text field slots after entering a character
    public var otpFilledBorderWidth: CGFloat = 0.47
    /// The default text color of the text
    public var otpTextColor: UIColor = .gray
    /// The default digit spacing of the text
    public var otpDigitSpacing: CGFloat = 8
    /// The default font size of the text
    public var otpFontSize: CGFloat = 22
    /// The default font of the text
    public var otpFont: UIFont = .systemFont(ofSize: 22)
    /// The delegate of the OTPTextFieldDelegate protocol
    public weak var otpDelegate: AROTPTextFieldDelegate?

    private var implementation = OTPTextFieldDelegateHandler()
    private var isConfigured = false
    private var digitLabels = [UILabel]()
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    // MARK: - METHODS
    //
    /// This func is used to configure the `AROTPTextField`, Usually you need to call this method into `viewDidLoad()`
    /// - Parameter slotCount: the number of OTP slots in the TextField
    public func configure(with slotCount: Int = 4) {
        guard isConfigured == false else { return }
        isConfigured.toggle()
        configureTextField()
        
        let labelsStackView = createLabelsStackView(with: slotCount)
        addSubview(labelsStackView)
        addGestureRecognizer(tapRecognizer)
        let size = getItemViewSize(slot: CGFloat(slotCount))
        NSLayoutConstraint.activate([
            labelsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelsStackView.widthAnchor.constraint(equalToConstant: (size.itemSize * CGFloat(slotCount)) + size.spacing),
            labelsStackView.heightAnchor.constraint(equalToConstant: size.itemSize)
        ])
    }
    
    private func getItemViewSize(slot: CGFloat) -> (itemSize: CGFloat, spacing: CGFloat) {
        
        let expectedItemWidth = frame.height
        let spacing = otpDigitSpacing * (slot - 1)
        let width = (expectedItemWidth * slot) + spacing
        var itemSize = (width - spacing) / slot
        if width > frame.width {
            let availableWidth = frame.width - spacing
            itemSize = availableWidth / slot
        }
        return (itemSize, spacing)
        
    }
    
    /// Use this func if you need to clear the `OTP` text and reset the `AROTPTextField` to the default state
    public func clearOTP() {
        text = nil
        digitLabels.forEach { currentLabel in
            currentLabel.text = defaultCharacter
            currentLabel.layer.borderWidth = otpDefaultBorderWidth
            currentLabel.layer.borderColor = otpDefaultBorderColor.cgColor
            currentLabel.backgroundColor = otpBackgroundColor
        }
    }
}

// MARK: - PRIVATE METHODS
//
private extension AROTPTextField {
    func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        borderStyle = .none
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = implementation
        implementation.implementationDelegate = self
    }
    
    func createLabelsStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = otpDigitSpacing
        for _ in 1 ... count {
            let label = createLabel()
            stackView.addArrangedSubview(label)
            digitLabels.append(label)
        }
        return stackView
    }
    
    func createLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = otpBackgroundColor
        label.layer.cornerRadius = otpCornerRaduis
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = otpTextColor
        label.font = label.font.withSize(otpFontSize)
        label.font = otpFont
        label.isUserInteractionEnabled = true
        label.layer.masksToBounds = true
        label.layer.borderWidth = otpDefaultBorderWidth
        label.layer.borderColor = otpDefaultBorderColor.cgColor
        label.text = defaultCharacter
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    @objc
    func textDidChange() {
        guard let text = self.text, text.count <= digitLabels.count else { return }
        for labelIndex in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[labelIndex]
            if labelIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: labelIndex)
                currentLabel.text = isSecureTextEntry ? "✱" : String(text[index])
                currentLabel.layer.borderWidth = otpFilledBorderWidth
                currentLabel.layer.borderColor = otpFilledBorderColor.cgColor
                currentLabel.backgroundColor = otpFilledBackgroundColor
            } else {
                currentLabel.text = defaultCharacter
                currentLabel.layer.borderWidth = otpDefaultBorderWidth
                currentLabel.layer.borderColor = otpDefaultBorderColor.cgColor
                currentLabel.backgroundColor = otpBackgroundColor
            }
        }
        
        if text.count == digitLabels.count {
            otpDelegate?.didUserFinishEnter(the: text)
            otpDelegate?.isFinishedEnteringCode(isFinished: true)
        } else {
            otpDelegate?.isFinishedEnteringCode(isFinished: false)
        }
    }
}

// MARK: - OTPTextFieldImplementationProtocol Delegate
//
extension AROTPTextField: OTPTextFieldProtocol {
    var digitalLabelsCount: Int {
        digitLabels.count
    }
}
