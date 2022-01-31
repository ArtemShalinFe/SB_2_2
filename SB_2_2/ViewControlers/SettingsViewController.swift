//
//  ViewController.swift
//  SB_2_2
//
//  Created by Артем ШАЛИН on 10.01.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var areaColor: UIView!
    
    @IBOutlet var labelRedValue: UILabel!
    @IBOutlet var sliderRedValue: UISlider!
    @IBOutlet var textFieldRedValue: UITextField!
    
    @IBOutlet var labelGreenValue: UILabel!
    @IBOutlet var sliderGreenValue: UISlider!
    @IBOutlet var textFieldGreenValue: UITextField!
    
    @IBOutlet var labelBlueValue: UILabel!
    @IBOutlet var sliderBlueValue: UISlider!
    @IBOutlet var textFieldBlueValue: UITextField!
  
    // MARK: - Public Properties
    var currentColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        areaColor.layer.cornerRadius = 15
        setCurrentValues(from: currentColor)
        
        updateAreaBackgroundColor()
    }

    // MARK: - IB Actions
    @IBAction func buttonDonePressed(_ sender: Any) {
        view.endEditing(true)
        guard let newBackgroundColor = areaColor.backgroundColor else { return }
        delegate.setNewBackgroundColor(with: newBackgroundColor)
        dismiss(animated: true)
    }
    
    @IBAction func slidersValueChanged(_ sender: UISlider) {
        
        switch sender {
        case sliderRedValue:
            updateValue(for: labelRedValue, from: sliderRedValue.value)
            updateValue(for: textFieldRedValue, from: sliderRedValue.value)
        case sliderBlueValue:
            updateValue(for: labelBlueValue, from: sliderBlueValue.value)
            updateValue(for: textFieldBlueValue, from: sliderBlueValue.value)
        default:
            updateValue(for: labelGreenValue, from: sliderGreenValue.value)
            updateValue(for: textFieldGreenValue, from: sliderGreenValue.value)
        }
        
        updateAreaBackgroundColor()
    }
    
    // MARK: - Private Methods
    @objc private func endColorEditing() {
        view.endEditing(true)
    }
    
    private func updateValue(for label: UILabel, from newValue: Float) {
        label.text = stringForm(for: newValue)
    }
    
    private func updateValue(for textField: UITextField, from newValue: Float) {
        textField.text = stringForm(for: newValue)
    }
   
    private func stringForm(for value: Float) -> String {
        return String(format: "%.02f", value)
    }
    
    private func updateAreaBackgroundColor() {
        
        let newColor = CIColor(
            red: CGFloat(sliderRedValue.value),
            green: CGFloat(sliderGreenValue.value),
            blue: CGFloat(sliderBlueValue.value)
        )
        areaColor.backgroundColor = UIColor(ciColor: newColor)
        
    }
    
    private func setCurrentValues(from currentColor: UIColor) {
        
        let colorRGB = CIColor(color: currentColor)
        
        sliderRedValue.value = Float(colorRGB.red)
        slidersValueChanged(sliderRedValue)
        
        sliderBlueValue.value = Float(colorRGB.blue)
        slidersValueChanged(sliderBlueValue)
        
        sliderGreenValue.value = Float(colorRGB.green)
        slidersValueChanged(sliderGreenValue)
        
    }
    
}

// MARK: - Extensions
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }

        if let currentValue = Float(text) {
            switch textField {
            case textFieldRedValue:
                sliderRedValue.setValue(currentValue, animated: true)
                slidersValueChanged(sliderRedValue)
            case textFieldGreenValue:
                sliderGreenValue.setValue(currentValue, animated: true)
                slidersValueChanged(sliderGreenValue)
            default:
                sliderBlueValue.setValue(currentValue, animated: true)
                slidersValueChanged(sliderBlueValue)
            }

            updateAreaBackgroundColor()
            return
       }

        presentAlert(title: "Filling error",
                     message: "This field should contain only decimal numbers")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(self.endColorEditing)
        )
        
        let flexible = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        toolbar.setItems([flexible, doneButton], animated: true)
        
        textField.inputAccessoryView = toolbar
        
    }
    
    private func presentAlert(title: String, message: String) {
        
        let alertaction = UIAlertAction(title: "Ok", style: .default)
        
        let alertCtl = UIAlertController(title: title,
                                         message: message,
                                         preferredStyle: .alert
        )
        
        alertCtl.addAction(alertaction)
        self.present(alertCtl, animated: true)
        
    }
    
}
