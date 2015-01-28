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
    var mLines:[Line] = []
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
        
        //create UInt16 array and store PCMBuffer values

        

        let array = self.mBuffer?.floatChannelData
        
        if self.mBuffer == nil
        {
            return
        }
        
        for var i = 0; i < Int(self.mBuffer!.frameLength); i++
        {
            if array?.memory[i] == nil
            {
                break
            }
            //          NSLog("Array value: \(array?.memory[i])")
        }
  
        
        
        
    }

    
}
