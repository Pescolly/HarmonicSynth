//
//  WaveformView.swift
//  chordmaker
//
//  Created by armen karamian on 1/19/15.
//  Copyright (c) 2015 armen karamian. All rights reserved.
//

import UIKit
import AVFoundation

class WaveformView: UIView
{
    var mLastPoint:CGPoint!
    
    //buffer with PCM info
    var mBuffer:AVAudioPCMBuffer?
    {
        didSet
        {
            self.setNeedsDisplay();
        }
    }
    
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }
    
    func calculateNewWaveform()
    {
        //add all 6 buffer arrays together
        //let finalWaveform:[UInt16]
        
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        mLastPoint = touches.anyObject()?.locationInView(self)
    }
    
    override func drawRect(rect: CGRect)
    {
        NSLog("draing new buffer")
        
        //create UInt16 array and store PCMBuffer value

        let array = self.mBuffer?.floatChannelData
        
        if self.mBuffer == nil
        {
            return
        }
        
        //initialize x and y values to 0
        let context = UIGraphicsGetCurrentContext()
        let frameCenter = self.frame.height / 2
        let frameWidth:Int = Int(self.frame.width)
        NSLog("Frame width: \(frameWidth)")
        
        var oldXValue:CGFloat = 0
        var oldYValue:CGFloat = self.frame.height / 2
        var xValue:CGFloat = 0
        var yValue:CGFloat = self.frame.height / 2
        
        let bufferLength:Int = Int(self.mBuffer!.frameLength)
        for var i = 0; i < frameWidth; i++
        {
            
            if array?.memory[i] == nil
            {
                break;
            }
            
            
            let sampleValue = array!.memory[i]
            //get new point from array
            xValue = CGFloat(i)  //CGFloat(frameWidth) * CGFloat(bufferLength)
            yValue = CGFloat(sampleValue) * frameCenter + frameCenter

            NSLog("\n")
            NSLog("Sample: \(sampleValue)")
            NSLog("xvalue: \(xValue), yvalue: \(yValue)\n")
            
            //draw from last point to new point
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, oldXValue, oldYValue)
            CGContextAddLineToPoint(context, xValue, yValue)
            CGContextSetRGBStrokeColor(context, 1, 0, 0, 1)
            CGContextStrokePath(context)
            
            //assign current value to old value
            oldXValue = xValue
            oldYValue = yValue
        }
    }
}
