//
//  ViewController.swift
//  SB_2_2
//
//  Created by Артем ШАЛИН on 10.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var areaColor: UIView!
    
    @IBOutlet var labelRedValue: UILabel!
    @IBOutlet var sliderRedValue: UISlider!
    
    @IBOutlet var labelGreenValue: UILabel!
    @IBOutlet var sliderGreenValue: UISlider!
    
    @IBOutlet var labelBlueValue: UILabel!
    @IBOutlet var sliderBlueValue: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        areaColor.layer.cornerRadius = 20
        
        updateAreaBackgroundColor()
    }

    @IBAction func changeRedValue() {
        labelRedValue.text = String(format: "%.03f", sliderRedValue.value)
        updateAreaBackgroundColor()
    }
    
    @IBAction func changeGreenValue() {
        labelGreenValue.text = String(format: "%.03f", sliderGreenValue.value)
        updateAreaBackgroundColor()
    }
    
    @IBAction func changeBlueValue() {
        labelBlueValue.text = String(format: "%.03f", sliderBlueValue.value)
        updateAreaBackgroundColor()
    }
        
    func updateAreaBackgroundColor() {
        
        let newColor = CIColor(red: CGFloat(sliderRedValue.value),
            green: CGFloat(sliderGreenValue.value),
            blue: CGFloat(sliderBlueValue.value)
        )
        areaColor.backgroundColor = UIColor(ciColor: newColor)
        
    }
    
}
