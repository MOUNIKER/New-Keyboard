//
//  Keyboard.swift
//  CustomKeyboard
//

import UIKit

class Keyboard: UIView {
    
    @IBOutlet var numberButtons: [UIButton]!
    
    @IBOutlet var firstView: [UIView]!
    
    @IBOutlet var secondView: [UIView]!
    
    @IBOutlet weak var secondView1: UIView!
    
    @IBOutlet weak var firstView1: UIView!
    
    @IBOutlet weak var secondView2: UIView!
    
    @IBOutlet weak var firstView2: UIView!
    weak var delegate: KeyboardDelegate?
    
    var array : [UIView] = []
    
 
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
        view.backgroundColor = UIColor.white
        view.frame = self.bounds
        let desiredColor = UIColor.systemTeal

        for view in secondView {
            for view in firstView{
                view.backgroundColor = desiredColor
            }
        }
       
    }
    
    @IBAction func numKeyTapped(_ sender: UIButton) {
        //string to store btn title
        print("button tag \(sender.tag)")
        let  a = sender.titleLabel?.text ?? ""
        let index = Int(a) ?? 0
        delegate?.numKeyTapped(number: index)
        pulseAnimation(index: sender.tag)
        
    }
    
    
    
    @IBAction func deleteKeyTapped(_ sender: UIButton) {
        delegate?.deleteKeyTapped()
    }
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        delegate?.doneBtnTapped()
    }
    
    private func shuffleNumberKeypad() {
        // Create an array of numbers with shuffeled
        let numbers = Array(0...9).shuffled()
        
        // Assign the shuffled numbers to the buttons
        for (index, button) in numberButtons.enumerated() {
            let number = numbers[index]
            button.setTitle(String(number), for: .normal)
            button.tag = index
        }
        
        firstView.forEach({$0.subviews.forEach { imgView in
            if let requiredView = imgView as? UIImageView {
                requiredView.backgroundColor = .systemTeal
                requiredView.layer.cornerRadius = requiredView.frame.size.height/2
                requiredView.layer.masksToBounds = true
            }
        }})
    }
    
    func pulseAnimation(index: Int) {
        
        secondView.forEach({$0.layer.sublayers?.forEach({$0.removeAllAnimations()})})
        print("Second View \(secondView.forEach({print("item \($0.layer.sublayers ?? [])")}))")
        let first = firstView[index]
        let second = secondView[index]
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

protocol KeyboardDelegate: AnyObject {
    
    func numKeyTapped(number: Int)
    
    func deleteKeyTapped()
    
    func doneBtnTapped()
}


