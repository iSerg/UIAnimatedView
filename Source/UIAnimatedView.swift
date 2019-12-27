//
//  UIAnimatedButton.swift
//  ARShow
//
//  Created by Serg Rudenko on 3/23/18.
//  Copyright © 2018 Owly Labs. All rights reserved.
//

import UIKit

public final class UIAnimatedView: UIView {

    private var tapBeganProcess:Bool = false
    private var wasTapCancel:Bool = false
    private var wasTapEnd:Bool = false
    
    private var wasLongPress:Bool = false
    
    
    private var scaleX:CGFloat = 0.97
    private var scaleY:CGFloat = 0.97
    private var selected_alpha:CGFloat = 1.0
    
    
    var timer: Timer?
    
    var didSelectHandler:(_ object: UIAnimatedView)->Void = {_ in }
    var didLongTapHandler:(_ object: UIAnimatedView)->Void = {_ in }
    
    
    func setupHandler(scale_x:CGFloat, scale_y:CGFloat, alpha:CGFloat, didSelectCollection:@escaping(_ object: UIAnimatedView) ->()) {
        didSelectHandler = didSelectCollection
        self.selected_alpha = alpha
        self.scaleX = scale_x
        self.scaleY = scale_y
    }
    
    func setupHandler(didSelectCollection:@escaping(_ object: UIAnimatedView) ->()) {
        didSelectHandler = didSelectCollection
    }
    
    func setupLongPressHandler(didLongTap:@escaping(_ object: UIAnimatedView) ->()) {
        didLongTapHandler = didLongTap
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            self.runTimer()
            
            _ = touch.location(in: self)
            // do something with your currentPoint
            
            self.tapBeganProcess = true
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.init(scaleX: self.scaleX, y: self.scaleY)
                self.alpha = self.selected_alpha
            }) { (done) in
                if (self.wasTapEnd == true || self.wasTapCancel == true){
                    UIView.animate(withDuration: 0.05, animations: {
                        self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                        self.alpha = 1.0
                    }) { (done) in
                        if (self.wasTapEnd == true){
                            self.userTap()
                        }else{
                            self.stopTimer()
                        }
                        self.tapBeganProcess = false
                        self.wasTapCancel = false
                        self.wasTapEnd = false
                        
                    }
                }else{
                    self.tapBeganProcess = false
                    self.wasTapCancel = false
                    self.wasTapEnd = false
                }
            }
        }
    }
    
    /*
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            _ = touch.location(in: self)
            self.needAnimateAfterTap = true
        }
    }*/
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            
            self.wasTapEnd = true
            if (self.tapBeganProcess == true){
                return
            }else{
                self.wasTapEnd = false
            }
            
            //let currentPoint = touch.location(in: self)
            // do something with your currentPoint
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            }) { (done) in
                let location = touch.location(in: self)
                if location.x >= 0 &&  location.y>=0 {
                    self.userTap()
                    self.alpha = 1.0
                }
                
            }
        }
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            //let currentPoint = touch.location(in: self)
            // do something with your currentPoint
            self.wasTapCancel = true
            self.stopTimer()
            if (self.tapBeganProcess == true){
                return
            }else{
                self.wasTapCancel = false
            }
            
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            }) { (done) in
                self.alpha = 1.0
            }
        }
    }
    
    
    func userTap(){
        if (self.wasLongPress == true) {
            self.stopTimer()
        }else{
            self.stopTimer()
            self.didSelectHandler(self)
        }
        
    }
    
    
    func runTimer(){
        self.wasLongPress = false
        self.stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(userLongTap), userInfo: nil, repeats: false)
    }
    
    
    func stopTimer(){
        if (timer != nil){
            timer!.invalidate()
            timer = nil
        }
    }
    
    
    
    @objc func userLongTap(){
        self.wasLongPress = true
        self.didLongTapHandler(self)
        let fakeTouch:Set<NSObject> = [UITouch()]
        let event     = UIEvent()
        self.touchesCancelled(fakeTouch as! Set<UITouch>, with: event)
    }
    
    
    
}
