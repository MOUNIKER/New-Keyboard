//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Siva Mouniker  on 26/06/23.
//

import UIKit

class KeyboardViewController: UIInputViewController {
 
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var numberButtons: [CustomKeyButton]!
    @IBOutlet var firstView: [UIView]!
    @IBOutlet var secondView: [UIView]!
    @IBOutlet var myKeyBoardView: UIView!
    
    var configuration: keyboardConfiguration?
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "NewkeyBoard", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
                view = objects[0] as? UIView
        shuffleNumberKeypad()

        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    @IBAction func numKeyTapped(_ sender: UIButton) {
        let  a = sender.titleLabel?.text ?? ""
    
        (textDocumentProxy as UIKeyInput).insertText("\(a)")
        startPulseAnimation(index: sender.tag)
    }
    
    @IBAction func deleteKeyTapped(_ sender: UIButton) {
            textDocumentProxy.deleteBackward()
    }
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        shuffleNumberKeypad()
        doneBtnTapped()
    }
    
    private func shuffleNumberKeypad() {
        // Create an array of numbers with shuffeled
        let numbers = Array(0...9).shuffled()
        
        // Assign the shuffled numbers to the buttons
        for (index, button) in numberButtons.enumerated() {
            let number = numbers[index]
            button.setTitle(String(number), for: .normal)
            button.tag = index
            button.setTitleColor(keyboardConfiguration.keyboardButtonForegroundColor, for: .normal)
            button.backgroundColor = keyboardConfiguration.keyboardButtonBackgroundColor
        }
    }
    
    
    func startPulseAnimation(index: Int) {
        
        DispatchQueue.main.async {
            self.firstView.forEach({$0.layer.sublayers?.forEach({$0.removeAllAnimations()})})
            let first = self.secondView[index]
            let second = self.firstView[index]
            let pulse = PulseAnimation(numberOfPulse: Float.infinity, radius: 50, postion: first.center)
            pulse.animationDuration = 2
            pulse.backgroundColor = UIColor.systemTeal.cgColor
            second.layer.insertSublayer(pulse, below: second.layer)
            let pulse1 = PulseAnimation(numberOfPulse: Float.infinity, radius: 20, postion: first.center)
            pulse1.animationDuration = 2
            pulse1.backgroundColor = UIColor.white.cgColor
            second.layer.insertSublayer(pulse1, below: second.layer)
        }
        
    }
   
    func doneBtnTapped() {
        dismissKeyboard()
    }
    
}
