//
//  SPButton.swift
//  StateProgressButtonControl
//
//  Created by Srikanth on 5/9/17.
//  Copyright © 2017 iCodeBlog. All rights reserved.
//

import UIKit
import CoreGraphics

/*
 * SPButton :- State Progress Button
 */

//@IBDesignable
class SPButton: UIView {

    
    @IBOutlet weak var button: UIButton!

    
    enum State {
        
        case Disabled
        case Enabled
        case Selected
    }
    
    var currentState: State {
        get {
            return __buttonState
        }
    }
    
    var currentProgress: CGFloat {
        get {
            return __progress
        }
    }
    
    fileprivate var __buttonState: State = .Disabled {
        
        didSet {
            updateState()
        }
    }
    
    fileprivate var __progress: CGFloat = 0.0 {
        
        didSet {
            updateProgress()
        }
    }
    
    
    func setState(_ state: State) {
        __buttonState = state
    }
    
    func setProgress(_ progress: CGFloat) {
        
        var pg = progress
        
        if pg > 1.0 {
            pg = 1.0
        } else if pg < 0 {
            pg = 0.0
        }
        
        __progress = progress
    }
    
    private var target: NSObject?
    private var action: Selector?
    
    func addTarget(_ target: NSObject?, action: Selector) {
        self.target = target
        self.action = action
    }
    
    fileprivate func updateProgress() {
        
        guard __buttonState != .Disabled else {
            return
        }
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.4)
        innerLayer.strokeEnd = __progress
        CATransaction.commit()
    }
    
    fileprivate func updateState() {
        
        switch __buttonState {
            
        case .Disabled:
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            outerLayer.lineWidth = self.lineWidth()
            innerLayer.lineWidth = self.lineWidth()
            
            innerLayer.strokeEnd = 0.0
            
            button.backgroundColor = UIColor.white
            button.tintColor = UIColor.lightGray
            
            CATransaction.commit()
            
        case .Enabled:
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.4)
            
            outerLayer.lineWidth = self.lineWidth()
            innerLayer.lineWidth = self.lineWidth()
            
            button.backgroundColor = UIColor.white
            button.tintColor = UIColor.red
            
            CATransaction.commit()
            
        case .Selected:
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.4)
            outerLayer.lineWidth = self.selectedLineWidth()
            innerLayer.lineWidth = self.selectedLineWidth()
            
            button.backgroundColor = UIColor.red
            button.tintColor = UIColor.white
            
            CATransaction.commit()
            
        }
        
    }
    
    
    fileprivate var outerLayer = CAShapeLayer()
    fileprivate var innerLayer = CAShapeLayer()
    
    private func lineWidth() -> CGFloat {
        
       return (outerLayer.frame.size.width - button.frame.size.width)/4.8
    }

    private func selectedLineWidth() -> CGFloat {
        
        return (outerLayer.frame.size.width - button.frame.size.width)/3.2
    }
    
    
    
    private var progressAngle: CGFloat = 1.0
    private var progressRotationAngle: CGFloat = 1.0

    
    private func createArcView() {
        
        outerLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width , height: bounds.size.height)
        layer.addSublayer(outerLayer)
        
        outerLayer.lineWidth = self.lineWidth()
        outerLayer.fillColor = UIColor.clear.cgColor
        outerLayer.strokeColor = UIColor.lightGray.cgColor
        outerLayer.strokeEnd = 1.0
        self.outerLayer.path = self.circlePath().cgPath
        
        innerLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width , height: bounds.size.height)
        layer.addSublayer(innerLayer)
        
        innerLayer.lineWidth = self.lineWidth()
        innerLayer.fillColor = UIColor.clear.cgColor
        innerLayer.strokeColor = UIColor.red.cgColor
        innerLayer.strokeEnd = 0.0
        innerLayer.lineCap = kCALineCapRound
        self.innerLayer.path = self.circlePath().cgPath
        
        button.layer.cornerRadius = button.frame.size.width/2
        button.clipsToBounds = true
        
        
        __buttonState = .Disabled
    }
    
    private func circleFrame() -> CGRect {
        // Align center
        let diameter = min(self.outerLayer.bounds.size.width, self.outerLayer.bounds.size.height)
        var circleFrame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        circleFrame.origin.x = outerLayer.bounds.midX - circleFrame.midX
        circleFrame.origin.y = outerLayer.bounds.midY - circleFrame.midY
        
        // offset lineWidth
        let inset = self.outerLayer.lineWidth / 2
        circleFrame = circleFrame.insetBy(dx: inset, dy: inset)
        
        return circleFrame
        
    }
    
    private func circlePath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        let center = CGPoint(x: circleFrame().midX, y: circleFrame().midY)
        let radius = circleFrame().size.width/2
        bezierPath.addArc(withCenter: center, radius: radius, startAngle: degreesToRadians(270) , endAngle: degreesToRadians(630), clockwise: true)
        bezierPath.close()
        return bezierPath
    }
    
    private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        
        return degrees / 180.0 * CGFloat(Double.pi)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        createArcView()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    @objc fileprivate func tapped() {
        
        target?.perform(action)
        
    }
}



