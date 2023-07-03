//
//  MainViewController.swift
//  CustomKeyboard
//

import UIKit

class MainViewController: UIViewController {
    
  
    
    @IBOutlet weak var textField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()

    }
    

}



