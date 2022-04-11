//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit
import Foundation
    
class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var fTextField: UITextField!
    @IBOutlet weak var cTextField: UITextField!
    
    //ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusTextField()
        updateFarenheitTextField()
    }
    // Keyboard disappears when tapping the screen somewhere else
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        fTextField.resignFirstResponder()
    }
    // DELEGATE METHOD : Review each character typed to decide to keep it (true) or not (false)
    // TODO: Modify code to reject (return false) if it finds any letters in the replacement string
    //  (hint-use Documentation to find a NSCharacterSet collection for letters, and a String method that finds a range using a NSCharacterSet)
    func fTextField(_ fTextField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = fTextField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let replacementTextHasLetters = string.rangeOfCharacter(from: .letters)
        
        if existingTextHasDecimalSeparator != nil || replacementTextHasDecimalSeparator != nil
            || replacementTextHasLetters != nil {
            return false
        } else {
            return true
        }
    }
    
    func cTextField(_ cTextField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = cTextField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let replacementTextHasLetters = string.rangeOfCharacter(from: .letters)
        
        if existingTextHasDecimalSeparator != nil || replacementTextHasDecimalSeparator != nil
            || replacementTextHasLetters != nil {
            return false
        } else {
            return true
        }
    }
    // DELEGATE METHOD : textFieldDidBeginEditing - is called when the user selects the text field
    // Add and modify the method to build expectation for the output by changing the celsiusLabel when the input field is selected
    // modify the celsiusLabel text to be a single question mark
    // modify the celsiusLabel color to be 60% red, 60% green, and 40% blue (refer to the Developer Documentation for UIColor)
   

    @IBAction func cTextFieldDidBeginEditing(_ sender: Any) {
        cTextField.text = "?"
        cTextField.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.4, alpha: 1.0)
    }
    
    @IBAction func fTextFieldDidBeginEditing(_ sender: Any) {
        fTextField.text = "?"
        fTextField.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.4, alpha: 1.0)
    }

    
    // EVENT HANDLER METHOD for FARENHEIT: Called when TextField is Changed (notice the optional binding)
    @IBAction func fahrenheitFieldEditingChanged(_ fTextField: UITextField) {
        if let fText = fTextField.text, let value = Double(fText) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    // EVENT HANDLER METHOD for CELSIUS
    @IBAction func celsiusFieldEditingChanged(_ cTextField: UITextField) {
        if let cText = cTextField.text, let value = Double(cText) {
            celsiusValue = Measurement(value: value, unit: .celsius)
        } else {
            celsiusValue = nil
        }
    }
    //Stored Properties for Fahrenheit and Celsius Temperature Measurement w/Observer
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet { // this property observer will run after the property is assigned a value
            updateCelsiusTextField()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        didSet {
            updateFarenheitTextField()
        }
    }
    // Helper Functions
    func updateCelsiusTextField() {
        if let celsiusValue = celsiusValue {
            cTextField.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            cTextField.text = "???"
        }
    }
    
    func updateFarenheitTextField() {
        if let fahrenheitValue = fahrenheitValue {
            fTextField.text = numberFormatter.string(from: NSNumber(value: fahrenheitValue.value))
        } else {
            fTextField.text = "???"
        }
    }
    // Limits the number of decimal places in the output label to 1
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
}
