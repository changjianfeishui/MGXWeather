//
//  AnimatableLabel.swift
//  MGXWeather
//
//  Created by Miu on 2019/4/28.
//  Copyright © 2019 MGX. All rights reserved.
//

import UIKit

private enum ALMediaTimingFunctionCalculation {
    case linear(t:Double)
    case easeInOut(t:Double)
    case easeIn(t:Double)
    case easeOut(t:Double)
    
    var progress:Double {
        let factor:Double = 2
        switch self {
        case .linear(let t):
            return t;
        case .easeInOut(var t):
            t *= 2;
            if (t < 1) {
                return 0.5 * pow (t, factor)
            } else {
                return 0.5 * (2.0 - pow(2.0 - t, factor))
            }
        case .easeIn(let t):
            return pow(t, factor)
        case .easeOut(let t):
            return 1 - pow((1 - t), factor);
        }
    }
    
}

enum ALMediaTimingFunctionName {
    case linear
    case easeInOut
    case easeIn
    case easeOut
}


class AnimatableCountLabel: UILabel {
    private var startValue:Int = 0
    private var endValue:Int = 0
    private var duration:TimeInterval = 2.0 {
        didSet {
            if duration == 0 {
                duration = 2.0
            }
        }
    }
    var timingFunction:ALMediaTimingFunctionName = .linear
    private var timer:CADisplayLink?
    private var lastUpdateTime:TimeInterval = 0
    private var durationProgress:Double = 0
    
    public var formatString:String?
    
    public func count(from startValue:Int, to endValue:Int, duration:TimeInterval = 2.0) -> Void {
        self.startValue = startValue
        self.endValue = endValue
        self.duration = duration
        lastUpdateTime = Date.timeIntervalSinceReferenceDate
        releaseTimer()
        setupTimer()
    }
    
    public func reset() {
        releaseTimer()
        startValue = 0
        endValue = 0
        durationProgress = 0
    }
    
    //MARK: Timer
    private func setupTimer() -> Void {
        timer = CADisplayLink(target: self, selector: #selector(updateValue))
        timer?.preferredFramesPerSecond = 30
        timer?.add(to: RunLoop.current, forMode: .common)
    }
    
    private func releaseTimer() -> Void {
        timer?.invalidate()
        timer = nil
    }
    
    //MARK: Event
    @objc private func updateValue() -> Void {
        //时间进度
        let currentTime = Date.timeIntervalSinceReferenceDate
        durationProgress = durationProgress + currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        if durationProgress > duration {
            releaseTimer()
            durationProgress = duration
        }
        
        func currentValue() -> String {
            if durationProgress >= duration  {
                return "\(endValue)"
            }
            let percent = durationProgress/duration
            var updateValue:Double
            switch timingFunction {
            case .linear:
                updateValue = ALMediaTimingFunctionCalculation.linear(t: percent).progress
            case .easeIn:
                updateValue = ALMediaTimingFunctionCalculation.easeIn(t: percent).progress
            case .easeOut:
                updateValue = ALMediaTimingFunctionCalculation.easeOut(t: percent).progress
            case .easeInOut:
                updateValue = ALMediaTimingFunctionCalculation.easeInOut(t: percent).progress
            }
            let currentDoubleValue = Double(startValue) + updateValue * Double(endValue - startValue)
            let currentIntValue = Int(currentDoubleValue)
            return "\(currentIntValue)"
            
        }
        
        text = currentValue() + (formatString ?? "")
        
    }

}
