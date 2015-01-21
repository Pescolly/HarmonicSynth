//
//  WaveformGenerator.swift
//  chordmaker
//
//  Created by armen karamian on 1/18/15.
//  Copyright (c) 2015 armen karamian. All rights reserved.
//

import Foundation
import AVFoundation

class WaveformGenerator
{
    
    //audio engine
    var mAudioEngine:AVAudioEngine?
    
    //setup interrupt constant
    let INTERRUPT_LOOP = AVAudioPlayerNodeBufferOptions.InterruptsAtLoop
    
    //audio engine nodes for fundamental and harmonics
    var mFundamentalNode:AVAudioPlayerNode?
    var mFirstHarmonicNode:AVAudioPlayerNode?
    var mSecondHarmonicNode:AVAudioPlayerNode?
    var mThirdHarmonicNode:AVAudioPlayerNode?
    var mFourthHarmonicNode:AVAudioPlayerNode?
    var mFifthHarmonicNode:AVAudioPlayerNode?
    
    var mFirstHarmonicNodeConnected:Bool = false
    {
        didSet
        {
            if mFirstHarmonicNodeConnected == true
            {
                if mAudioEngine?.running != nil
                {
                    NSLog("connecting audio nodes, first harmonic frequency: \(mFirstHarmonicFrequency)")
                    var buffer = getBuffer(mFirstHarmonicFrequency!, _node: mFirstHarmonicNode!)
                    mAudioEngine?.connect(mFirstHarmonicNode, to: mMixerNode, format: nil)
                    mFirstHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
                    mFirstHarmonicNode?.play()
                    
                }
            }
            if mFirstHarmonicNodeConnected == false
            {
                mAudioEngine?.disconnectNodeOutput(mFirstHarmonicNode)
            }
        }
    }

    var mSecondHarmonicNodeConnected:Bool = false
    var mThirdHarmonicNodeConnected:Bool = false
    var mFourthHarmonicNodeConnected:Bool = false
    var mFifthHarmonicNodeConnected:Bool = false

    //frequencies for each node
    var mFundamentalFrequency: Float?
    var mFirstHarmonicFrequency: Float?
    var mSecondHarmonicFrequency: Float?
    var mThirdHarmonicFrequency: Float?
    var mFourthHarmonicFrequency: Float?
    var mFifthHarmonicFrequency: Float?
    
    //audio engine node for mixer
    var mMixerNode:AVAudioMixerNode?
    
    let mBufferSize = 48000
    
    init(_fundamental: Float, _firstHarmonic: Float, _secondHarmonic: Float, _thirdHarmonic: Float, _fourthHarmonic: Float, _fifthHarmonic: Float)
    {
        //setup frequencies
        mFundamentalFrequency = _fundamental
        mFirstHarmonicFrequency = _firstHarmonic
        mSecondHarmonicFrequency = _secondHarmonic
        mThirdHarmonicFrequency = _thirdHarmonic
        mFourthHarmonicFrequency = _fourthHarmonic
        mFifthHarmonicFrequency = _fifthHarmonic
        
        //init engine and main mixer
        mAudioEngine = AVAudioEngine()
        mMixerNode = mAudioEngine?.mainMixerNode
        
        //setup fundamental node and connect to main mixer for output
        mFundamentalNode = AVAudioPlayerNode()
        mFirstHarmonicNode = AVAudioPlayerNode()
        mSecondHarmonicNode = AVAudioPlayerNode()
        mThirdHarmonicNode = AVAudioPlayerNode()
        mFourthHarmonicNode = AVAudioPlayerNode()
        mFifthHarmonicNode = AVAudioPlayerNode()
        
        //connect nodes to mixer
        mAudioEngine?.attachNode(mFundamentalNode)
        mAudioEngine?.connect(mFundamentalNode, to: mMixerNode, format: nil)
        
        mAudioEngine?.attachNode(mFirstHarmonicNode)
        mAudioEngine?.connect(mFirstHarmonicNode, to: mMixerNode, format: nil)
        
    }
    
    func startOscillation()
    {
        //get fundamental
        
        //put waveform in PCM buffer
        
        //        let audioFrameCount:AVAudioFrameCount = AVAudioFrameCount(mBufferSize)
        //let channelLayout:AVAudioChannelLayout = AVAudioChannelLayout(
        
        
        //start mAudioEngine
        mAudioEngine?.startAndReturnError(nil)
        
        //start fundamental
        NSLog("Starting oscillation, fundamental: \(mFundamentalFrequency!)")
        let fundamentalBuffer = getBuffer(mFundamentalFrequency!, _node: mFundamentalNode!)
        mFundamentalNode?.scheduleBuffer(fundamentalBuffer, atTime: nil, options: .Loops, completionHandler: nil)
        mFundamentalNode?.play()
        

        if mFirstHarmonicNodeConnected
        {
            NSLog("First harmonic connected")
            let buffer = getBuffer(mFirstHarmonicFrequency!, _node: mFirstHarmonicNode!)
            mFirstHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
            NSLog("Playing first harmonic")
            mFirstHarmonicNode?.play()
            
        }
        
/*        if mSecondHarmonicNodeConnected
        {
            let buffer = getBuffer(mSecondHarmonicFrequency!, _node: mSecondHarmonicNode!)
            mSecondHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
        }
  */
        
     }
    
    func stopOscillation()
    {
        mFundamentalNode?.stop()
        mFirstHarmonicNode?.stop()
        mAudioEngine?.stop()
    }
    

    
    func fundamentalChanged(_newFundamental:Float)
    {
        NSLog("Fundamental changed in waveform generator to: \(_newFundamental)")
        //calculate new waveforms and harmonics
        mFundamentalFrequency = _newFundamental
        var buffer = getBuffer(mFundamentalFrequency!, _node: mFundamentalNode!)
    
        //schedule buffer
        mFundamentalNode?.scheduleBuffer(buffer, atTime: nil, options: INTERRUPT_LOOP, completionHandler: nil)
        mFundamentalNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
        
    }
    
    func harmonicOneChanged(_frequency: Float)
    {
        mFirstHarmonicFrequency = _frequency
        var buffer = getBuffer(mFirstHarmonicFrequency!, _node: mFirstHarmonicNode!)
        mFirstHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: INTERRUPT_LOOP, completionHandler: nil)
        mFirstHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)

    }
    
    func harmonicTwoChanged(_frequency: Float)
    {
        
    }
    
    func harmonicThreeChanged(_frequency: Float)
    {
        
    }
    
    func harmonicFourChanged(_frequency: Float)
    {
        
    }
    
    func harmonicFiveChanged(_frequency: Float)
    {
        
    }
    
    func getBuffer(_frequency: Float, _node: AVAudioNode) -> AVAudioPCMBuffer
    {
        NSLog("Getting buffer")
        let audioFormat:AVAudioFormat = _node.outputFormatForBus(0)
        
        let sampleRate:Float = Float(mMixerNode!.outputFormatForBus(0).sampleRate)
        let channelCount = mMixerNode?.outputFormatForBus(0).channelCount
        
        let frameLength:UInt32 = 100
        let buffer = AVAudioPCMBuffer(PCMFormat: audioFormat, frameCapacity: frameLength)
        buffer.frameLength = frameLength
        
        for var i = 0; i < Int(buffer.frameLength); i += Int(channelCount!)
        {
            var val = sinf(_frequency*Float(i)*2*Float(M_PI) / sampleRate)
            buffer.floatChannelData.memory[i] = val
        }
        NSLog("returning buffer")
        return buffer
    }

}