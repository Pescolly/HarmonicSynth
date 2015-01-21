//
//  WaveformViewController.swift
//  chordmaker
//
//  Created by armen karamian on 1/19/15.
//  Copyright (c) 2015 armen karamian. All rights reserved.
//

import UIKit
import AVFoundation

class WaveformViewController: UIView
{
    var fundamentalBufferArray:[UInt16]?
    {
        didSet
        {
        //trigger new waveform calculation
            self.calculateNewWaveform()
        }
    }

    var firstHarmonicBufferArray:[UInt16]?
    {
        didSet
        {
            //trigger new waveform calculation
            self.calculateNewWaveform()
        }
    }

    var secondHarmonicBufferArray:[UInt16]?
    {
        didSet
        {
            //trigger new waveform calculation
            self.calculateNewWaveform()
        }
    }
    
    var thirdHarmonicBufferArray:[UInt16]?
    {
        didSet
        {
            //trigger new waveform calculation
            self.calculateNewWaveform()
        }
    }
    
    var fourthHarmonicBufferArray:[UInt16]?
    {
        didSet
        {
            //trigger new waveform calculation
            self.calculateNewWaveform()
        }
    }
    
    var fifthHarmonicBufferArray:[UInt16]?
    {
        didSet
        {
            //trigger new waveform calculation
            self.calculateNewWaveform()
        }
    }
    
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    
    func calculateNewWaveform()
    {
        //add all 6 buffer arrays together
        //let finalWaveform:[UInt16]
        
    }

}
