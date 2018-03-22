//
//  ViewController.swift
//  GoogleDistanceProject
//
//  Created by Appinventiv on 3/22/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var subTransitionView = UIView()
    
    @IBOutlet weak var originView: UIView!
    @IBOutlet weak var transitionView: UIView!
    @IBOutlet weak var destinationView: UIView!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.originView.layer.cornerRadius = self.originView.bounds.width/2.0
        self.destinationView.layer.cornerRadius = self.destinationView.bounds.width/2.0
        let frame = transitionView.frame
        self.subTransitionView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 0))
        self.transitionView.addSubview(self.subTransitionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goButtonAction(_ sender: UIButton) {
        animateOnLoad()
        Distance().find(origin: originTextField.text!, destination: destinationTextField.text!){ (distance,time) in
            originLabel.text = originTextField.text!
            destinationLabel.text = destinationTextField.text!
            distanceLabel.text = "Total Distance : "+distance
            timeLabel.text = "Estimated Time : "+time
        }
    }
}

extension ViewController
{
    func animateOnLoad()
    {
        let frame = transitionView.frame
        self.subTransitionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 0)
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn, animations: {
            self.subTransitionView.layer.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            self.subTransitionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        }, completion : nil)
    }

}