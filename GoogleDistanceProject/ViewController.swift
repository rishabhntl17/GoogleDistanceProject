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
    var progressCircleView = UIView()
    var progressCircleCenter = CGFloat()
    
    @IBOutlet weak var originView: UIView!
    @IBOutlet weak var transitionView: UIView!
    @IBOutlet weak var destinationView: UIView!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerDetailLabel: UILabel!
    @IBOutlet weak var goButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFramesOnViewLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.originTextField.center.x  -= self.view.bounds.width
        self.destinationTextField.center.x += self.view.bounds.width
        self.goButtonOutlet.center.x += self.view.bounds.width
    }
    
    @IBAction func goButtonAction(_ sender: UIButton) {
        animateOnGoButtonAction()
        Distance().find(origin: originTextField.text!.replacingOccurrences(of: " ", with: "+"), destination: destinationTextField.text!.replacingOccurrences(of: " ", with: "+")){ (distance,time) in
            originLabel.text = originTextField.text!
            destinationLabel.text = destinationTextField.text!
            distanceLabel.text = "Total Distance : "+distance
            timeLabel.text = "Estimated Time : "+time
        }
    }
}

extension ViewController
{
    func setFramesOnViewLoad()
    {
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseIn, animations: {
            self.headerLabel.alpha = 1.0
            self.headerDetailLabel.alpha = 1.0
            self.originTextField.center.x  += self.view.bounds.width
            self.destinationTextField.center.x -= self.view.bounds.width
            self.goButtonOutlet.center.x -= self.view.bounds.width
        }, completion: nil)
        self.originView.layer.cornerRadius = self.originView.bounds.width/2.0
        self.destinationView.layer.cornerRadius = self.destinationView.bounds.width/2.0
        let transitionViewFrame = transitionView.frame
        let originViewFrame = originView.frame
        self.subTransitionView = UIView(frame: CGRect(x: 0 + self.originView.bounds.height/2, y: 0, width: transitionViewFrame.width, height: 0))
        self.transitionView.addSubview(self.subTransitionView)
        self.progressCircleView = UIView(frame: CGRect(x: 0, y: 0, width: originViewFrame.width, height: originViewFrame.height))
        self.progressCircleView.layer.cornerRadius = self.progressCircleView.bounds.width/2.0
        self.progressCircleView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.originView.addSubview(progressCircleView)
        progressCircleCenter = progressCircleView.center.y
    }
    
    func animateOnGoButtonAction()
    {
        let transitionViewFrame = transitionView.frame
        self.subTransitionView.frame = CGRect(x: 0, y: 0, width: transitionViewFrame.width, height: 0)
        self.progressCircleView.center.y = progressCircleCenter
        self.subTransitionView.layer.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.originLabel.alpha = 0.0
        self.destinationLabel.alpha = 0.0
        self.distanceLabel.alpha = 0.0
        self.timeLabel.alpha = 0.0
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn, animations: {
            self.originLabel.alpha = 1.0
            self.destinationLabel.alpha = 1.0
            self.distanceLabel.alpha = 1.0
            self.timeLabel.alpha = 1.0
            self.subTransitionView.layer.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            self.subTransitionView.frame = CGRect(x: 0, y: 0, width: transitionViewFrame.width, height: transitionViewFrame.height)
            self.progressCircleView.frame = CGRect(x: 0, y: self.destinationView.center.y - self.originView.center.y, width: self.progressCircleView.bounds.width, height: self.progressCircleView.bounds.height)
        }, completion : nil)
    }
}
