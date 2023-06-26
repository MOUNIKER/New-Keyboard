//
//  Keyboard.swift
//  CustomKeyboard
//

import UIKit

class Keyboard: UIView {
    
    @IBOutlet var numberButtons: [UIButton]!
    
    weak var delegate: KeyboardDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addXibView()
        shuffleNumberKeypad()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addXibView()
        shuffleNumberKeypad()
    }
    
    private func addXibView() {
        let xibFileName = "Keyboard" // xib extention not included
        
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    @IBAction func numKeyTapped(_ sender: UIButton) {
        delegate?.numKeyTapped(number: sender.tag)
    }
    
    @IBAction func deleteKeyTapped(_ sender: UIButton) {
        delegate?.deleteKeyTapped()
    }
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        delegate?.doneBtnTapped()
    }
    
    private func shuffleNumberKeypad() {
            // Create an array of numbers with shuffeled
        var numbers = Array(0...9).shuffled()
            
            // Assign the shuffled numbers to the buttons
            for (index, button) in numberButtons.enumerated() {
                let number = numbers[index]
                button.setTitle(String(number), for: .normal)
            }
        }
    

    
}

protocol KeyboardDelegate: AnyObject {
    
    func numKeyTapped(number: Int)
    
    func deleteKeyTapped()
    
    func doneBtnTapped()
}


