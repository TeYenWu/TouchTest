//
//  ViewController.swift
//  TouchTest
//
//  Created by 吳德彥 on 21/05/2018.
//  Copyright © 2018 吳德彥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   var initialCenterForPan = CGPoint()
   var initialRotationForRotate = CGFloat()
    
    
    @IBOutlet weak var rotateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(self.rotate(_:)))
        rotateView.addGestureRecognizer(rotateGestureRecognizer)
    
        
    }
    
    @IBAction func tap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .ended {
            guard let view = gestureRecognizer.view?.subviews.first, let label = view as? UILabel else {return}
            let location = gestureRecognizer.location(in: gestureRecognizer.view)
            label.text = "\(Int(location.x)), \(Int(location.y))"
        }
    }
    
    @IBAction func pan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil else {return}
        
        
        let targetView = gestureRecognizer.view!
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = gestureRecognizer.translation(in: targetView.superview)
        if gestureRecognizer.state == .began {
            // Save the view's original position.
            initialCenterForPan = targetView.center
        }
        
        
        // Update the position for the .began, .changed, and .ended states
        if gestureRecognizer.state != .cancelled && gestureRecognizer.state != .ended {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(x: initialCenterForPan.x + translation.x, y: initialCenterForPan.y + translation.y)
            targetView.center = newCenter
        }
        else {
            // On cancellation, return the piece to its original location.
            targetView.center = initialCenterForPan
        }
    }
    
    @objc func rotate(_ gestureRecognizer: UIRotationGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            gestureRecognizer.view?.transform = gestureRecognizer.view!.transform.rotated(by: gestureRecognizer.rotation)
            gestureRecognizer.rotation = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("I am ViewController receiving the touches")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

