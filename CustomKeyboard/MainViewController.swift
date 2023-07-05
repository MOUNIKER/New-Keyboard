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
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
}


