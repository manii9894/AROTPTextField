# AROTPTextField
A library to turn your simple UITextField into a textfield which accepts one time passwords smoothly.


#### Key Features

 1) `It can be easily implemented in storyboard. Just assign the class to UITextField.`
 2) `Highly customizable.`
 3) `Supports both portrait and landscape orientations.`
 4) `It will automatically resize digit container according to the TextField's frame and total number of digits.`

## Screenshot
![AROTPTextField](https://github.com/manii9894/AROTPTextField/blob/main/ScreenShot/demo.gif)

Installation
==========================

#### Installation with CocoaPods

AROTPTextField is available through [CocoaPods](https://cocoapods.org/pods/AROTPTextField). To install
it, simply add the following line to your Podfile and install the pod:

```ruby
pod 'AROTPTextField'
```

Just drag a UITextField in your view controller and assign it 'AROTPTextField' class. Just make an outlet of it in your view controller class.
In your view controller just import AROTPTextField framework.

```swift
import AROTPTextField

class ViewController: UIViewController {

    // MARK: - OUTLETS
    @IBOutlet weak var OTPTextField: AROTPTextField!
    
}
```

Customization example
```swift
        OTPTextField.otpBackgroundColor = .systemGray6
        OTPTextField.otpFilledBackgroundColor = .systemGray6
        OTPTextField.otpTextColor = .gray
        OTPTextField.otpDefaultBorderColor = .gray 
        OTPTextField.otpDefaultBorderWidth = 0.47
        OTPTextField.otpFilledBorderColor = .gray
        OTPTextField.otpFilledBorderWidth = 0.47
        OTPTextField.otpFont = UIFont.systemFont(ofSize: 22)
        OTPTextField.otpCornerRaduis = 7.55
        OTPTextField.defaultCharacter = "-"
        OTPTextField.otpDelegate = self
        OTPTextField.configure()
```

To get the results from the TextField, extend your ViewController using `AROTPTextFieldDelegate` protocol
``` swift
extension ViewController: AROTPTextFieldDelegate {
    
    func isFinishedEnteringCode(isFinished: Bool) {
        submitButton.isEnabled = isFinished
        submitButton.alpha = isFinished ? 1 : 0.4
    }
    
    func didUserFinishEnter(the code: String) {
        print(code)
    }
    
}
```

LICENSE
---
Distributed under the MIT License.

Contributions
---
Any contribution is more than welcome! You can contribute through pull requests and issues on GitHub.

Author
---
If you wish to contact me, email at: a.rehman9894@gmail.com
