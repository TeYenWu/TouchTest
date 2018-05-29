//
//  myCustomView.swift
//  TouchTest
//
//  Created by 吳德彥 on 2018/5/24.
//  Copyright © 2018 吳德彥. All rights reserved.
//

import UIKit
typealias touchToLayer = (touchPoint: UITouch, layer: CALayer)

class TouchVizView: UIView {

    var touchToLayerDict: [UITouch:CALayer] = [:]
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("I am TouchVizView receiving the touches")
        touches.forEach { (touch) in
            let circleLayer = CAShapeLayer()
            let touchPoint = touch.location(in: self)
            let radius: CGFloat = touch.majorRadius
            circleLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.0 * radius, height: 2.0 * radius), cornerRadius: radius).cgPath
            circleLayer.position = CGPoint(x: touchPoint.x - radius, y: touchPoint.y - radius)
            circleLayer.fillColor = UIColor.blue.cgColor
            touchToLayerDict[touch] = circleLayer
            self.layer.addSublayer(circleLayer)
        }
    
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { (touch) in
            if let layer = touchToLayerDict[touch]{
                let touchPoint = touch.location(in: self)
                let radius: CGFloat = touch.majorRadius
                layer.position = CGPoint(x: touchPoint.x - radius, y: touchPoint.y - radius)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { (touch) in
            if let layer = touchToLayerDict[touch]{
                layer.removeFromSuperlayer()
                touchToLayerDict.removeValue(forKey: touch)
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { (touch) in
            if let layer = touchToLayerDict[touch]{
                layer.removeFromSuperlayer()
                touchToLayerDict.removeValue(forKey: touch)
            }
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.bounds.contains(point) {
            return self
        }
        return nil
    }
}
