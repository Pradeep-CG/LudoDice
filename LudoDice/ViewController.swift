//
//  ViewController.swift
//  LudoDice
//
//  Created by Pradeep on 15/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceUpperImgView: UIImageView!
    @IBOutlet weak var diceLowerImgView: UIImageView!
    
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var pressMeBtn: UIButton!
    
    var sum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.totalLbl.isHidden = true
        self.shakeButton()
        
        _ = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(shakeButton), userInfo: nil, repeats: true)

    }
    
    @IBAction func onPressMeBtnClicked(_ sender: Any) {
        
        
        let numberOne = Int.random(in: 1 ... 6)
        let numberTwo = Int.random(in: 1 ... 6)
        
        sum = numberOne + numberTwo
        
        self.totalLbl.text = "\(sum)"
        
        self.diceUpperImgView.image = UIImage(named: "Dice\(numberOne)")!
        self.diceLowerImgView.image = UIImage(named: "Dice\(numberTwo)")!
        
        self.animateDices()
    }
    
    func animateDices() {
        
        self.totalLbl.alpha = 0.0
        self.pressMeBtn.alpha = 0.0
        self.pressMeBtn.isHidden = true
        
        self.totalLbl.alpha = 1.0
        self.totalLbl.isHidden = false
        
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: diceUpperImgView, duration: 0.5, options: transitionOptions, animations: {
            self.diceUpperImgView.alpha = 0.0
            self.diceUpperImgView.isHidden = true
            
        })
        
        UIView.transition(with: diceUpperImgView, duration: 0.5, options: transitionOptions, animations: {
            self.diceUpperImgView.alpha = 1.0
            self.diceUpperImgView.isHidden = false
        })
        
        self.diceLowerImgView.alpha = 0.0
        self.diceUpperImgView.isHidden = true
        UIView.animate(withDuration: 0.6, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.diceLowerImgView.alpha = 1.0
            self.diceUpperImgView.isHidden = false
            
        }, completion:nil)
        
        UIView.animate(withDuration: 2.0, animations: {
            self.totalLbl.alpha = 0.0
            self.totalLbl.isHidden = true
            self.pressMeBtn.alpha = 1.0
            self.pressMeBtn.isHidden = false
            
        }, completion:nil)
    }
    @objc func shakeButton()  {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.pressMeBtn.center.x - 10, y: self.pressMeBtn.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.pressMeBtn.center.x + 10, y: self.pressMeBtn.center.y))

        self.pressMeBtn.layer.add(animation, forKey: "position")
    }
}

