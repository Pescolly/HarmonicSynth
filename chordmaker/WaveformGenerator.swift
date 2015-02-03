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
    
    //setup samplerate
    let SAMPLE_RATE:Double = 48000

	// setup mono
	let MONO = 1
	
    //setup interrupt constant
    let INTERRUPT_LOOP = AVAudioPlayerNodeBufferOptions.InterruptsAtLoop
    
    //audio engine nodes for fundamental and harmonics
    var mFundamentalNode:AVAudioPlayerNode?
    var mFirstHarmonicNode:AVAudioPlayerNode?
    var mSecondHarmonicNode:AVAudioPlayerNode?
    var mThirdHarmonicNode:AVAudioPlayerNode?
    var mFourthHarmonicNode:AVAudioPlayerNode?
    var mFifthHarmonicNode:AVAudioPlayerNode?
    
    //setup buffer
    var mTapBuffer:AVAudioPCMBuffer?
    
    //setup harmonic node connections
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
    {
        didSet
        {
            if mSecondHarmonicNodeConnected == true
            {
                if mAudioEngine?.running != nil
                {
                    NSLog("connecting audio nodes, second harmonic frequency: \(mSecondHarmonicFrequency)")
                    var buffer = getBuffer(mSecondHarmonicFrequency!, _node: mSecondHarmonicNode!)
                    mAudioEngine?.connect(mSecondHarmonicNode, to: mMixerNode, format: nil)
                    mSecondHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
                    mSecondHarmonicNode?.play()
                }
            }
        
            if mSecondHarmonicNodeConnected == false
            {
                mAudioEngine?.disconnectNodeOutput(mSecondHarmonicNode)
            }
        }
    }
    
    var mThirdHarmonicNodeConnected:Bool = false
    {
        didSet
        {
            if mThirdHarmonicNodeConnected == true
            {
                if mAudioEngine?.running != nil
                {
                    NSLog("connecting audio nodes, third harmonic frequency: \(mThirdHarmonicFrequency)")
                    var buffer = getBuffer(mThirdHarmonicFrequency!, _node: mThirdHarmonicNode!)
                    mAudioEngine?.connect(mThirdHarmonicNode, to: mMixerNode, format: nil)
                    mThirdHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
                    mThirdHarmonicNode?.play()
                }
            }
            
            if mThirdHarmonicNodeConnected == false
            {
                mAudioEngine?.disconnectNodeOutput(mThirdHarmonicNode)
            }
        }
    }
    
    var mFourthHarmonicNodeConnected:Bool = false
    {
        didSet
        {
            if mFourthHarmonicNodeConnected == true
            {
                if mAudioEngine?.running != nil
                {
                    NSLog("connecting audio nodes, third harmonic frequency: \(mFourthHarmonicFrequency)")
                    var buffer = getBuffer(mFourthHarmonicFrequency!, _node: mFourthHarmonicNode!)
                    mAudioEngine?.connect(mFourthHarmonicNode, to: mMixerNode, format: nil)
                    mFourthHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
                    mFourthHarmonicNode?.play()
                }
            }
            
            if mFourthHarmonicNodeConnected == false
            {
                mAudioEngine?.disconnectNodeOutput(mFourthHarmonicNode)
            }
        }
    }
    
    var mFifthHarmonicNodeConnected:Bool = false
    {
        didSet
        {
            if mFifthHarmonicNodeConnected == true
            {
                if mAudioEngine?.running != nil
                {
                    NSLog("connecting audio nodes, third harmonic frequency: \(mFifthHarmonicFrequency)")
                    var buffer = getBuffer(mFifthHarmonicFrequency!, _node: mFifthHarmonicNode!)
                    mAudioEngine?.connect(mFifthHarmonicNode, to: mMixerNode, format: nil)
                    mFifthHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
                    mFifthHarmonicNode?.play()
                }
            }
            
            if mFifthHarmonicNodeConnected == false
            {
                mAudioEngine?.disconnectNodeOutput(mFifthHarmonicNode)
            }
        }
    }
    
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
		let channelcount = AVAudioChannelCount(1)
		let audioformat = AVAudioFormat(commonFormat: AVAudioCommonFormat.PCMFormatInt16, sampleRate: SAMPLE_RATE, channels: channelcount, interleaved: false)

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
        mAudioEngine?.connect(mFundamentalNode, to: mMixerNode, format: audioformat)
        
        mAudioEngine?.attachNode(mFirstHarmonicNode)
        mAudioEngine?.connect(mFirstHarmonicNode, to: mMixerNode, format: audioformat)
        
        mAudioEngine?.attachNode(mSecondHarmonicNode)
        mAudioEngine?.connect(mSecondHarmonicNode, to: mMixerNode, format: audioformat)
        
        mAudioEngine?.attachNode(mThirdHarmonicNode)
        mAudioEngine?.connect(mThirdHarmonicNode, to: mMixerNode, format: audioformat)
        
        mAudioEngine?.attachNode(mFourthHarmonicNode)
        mAudioEngine?.connect(mFourthHarmonicNode, to: mMixerNode, format: audioformat)
        
        mAudioEngine?.attachNode(mFifthHarmonicNode)
        mAudioEngine?.connect(mFifthHarmonicNode, to: mMixerNode, format: audioformat)
        
        //setup tap after mixer node and put values into array
        
        
        mMixerNode?.installTapOnBus(0, bufferSize: 4096, format: mMixerNode?.outputFormatForBus(0),
        {
            (buffer: AVAudioPCMBuffer!, time:AVAudioTime!) -> Void in
            // NSLog("tapped that azz")
                self.mTapBuffer = buffer
        }
        )
        NSLog("Audio engine setup")
    }
    
    func startOscillation()
    {
        //start mAudioEngine
        mAudioEngine?.startAndReturnError(nil)
        
        //start fundamental
        NSLog("Starting oscillation, fundamental: \(mFundamentalFrequency!)")
        let fundamentalBuffer = getBuffer(mFundamentalFrequency!, _node: mFundamentalNode!)
        mFundamentalNode?.scheduleBuffer(fundamentalBuffer, atTime: nil, options: .Loops, completionHandler: nil)
        mFundamentalNode?.play()
        

        // check if nodes are connected, schedule buffers and play
        if mFirstHarmonicNodeConnected
        {
            let buffer = getBuffer(mFirstHarmonicFrequency!, _node: mFirstHarmonicNode!)
            mFirstHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
            mFirstHarmonicNode?.play()
        }
        
        if mSecondHarmonicNodeConnected
        {
            let buffer = getBuffer(mSecondHarmonicFrequency!, _node: mSecondHarmonicNode!)
            mSecondHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
            mSecondHarmonicNode?.play()
        }

        if mThirdHarmonicNodeConnected
        {
            let buffer = getBuffer(mThirdHarmonicFrequency!, _node: mThirdHarmonicNode!)
            mThirdHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
            mThirdHarmonicNode?.play()
        }

        if mFourthHarmonicNodeConnected
        {
            let buffer = getBuffer(mFourthHarmonicFrequency!, _node: mFourthHarmonicNode!)
            mFourthHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
            mFourthHarmonicNode?.play()
        }
        
        if mFifthHarmonicNodeConnected
        {
            let buffer = getBuffer(mFifthHarmonicFrequency!, _node: mFifthHarmonicNode!)
            mFifthHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
            mFifthHarmonicNode?.play()
        }
        
        
     }
    
    func stopOscillation()
    {
        //shutdown node players
        mFundamentalNode?.stop()
        mFirstHarmonicNode?.stop()
        mSecondHarmonicNode?.stop()
        mThirdHarmonicNode?.stop()
        mFourthHarmonicNode?.stop()
        mFifthHarmonicNode?.stop()
        
        //shutdown engine
        mAudioEngine?.stop()
    }
    

    
    func fundamentalChanged(_newFundamental:Float)
    {
		//        NSLog("Fundamental changed in waveform generator to: \(_newFundamental)")
        //calculate new waveforms and harmonics
        mFundamentalFrequency = _newFundamental
        var buffer = getBuffer(mFundamentalFrequency!, _node: mFundamentalNode!)
    
        //schedule buffer
        mFundamentalNode?.scheduleBuffer(buffer, atTime: nil, options: INTERRUPT_LOOP, completionHandler: nil)
        mFundamentalNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
        
    }
    
    func harmonicOneChanged(_frequency: Float)
    {
        //assign new frequency to instance variable
        mFirstHarmonicFrequency = _frequency
        
		//        NSLog("harmoinc one in waveform generator to: \(_frequency)")
        
        //get new buffer and schedule
        var buffer = getBuffer(mFirstHarmonicFrequency!, _node: mFirstHarmonicNode!)
        mFirstHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: INTERRUPT_LOOP, completionHandler: nil)
        mFirstHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)

    }
    
    func harmonicTwoChanged(_frequency: Float)
    {
        //assign new frequency to instance variable
        mSecondHarmonicFrequency = _frequency
		//NSLog("harmoinc two in waveform generator to: \(_frequency)")

        //get new buffer and schedule
        var buffer = getBuffer(mSecondHarmonicFrequency!, _node: mSecondHarmonicNode!)
        mSecondHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: INTERRUPT_LOOP, completionHandler: nil)
        mSecondHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
    }
    
    func harmonicThreeChanged(_frequency: Float)
    {
        //assign new frequency to instance variable
        mThirdHarmonicFrequency = _frequency
		//NSLog("harmoinc three in waveform generator to: \(_frequency)")

        //get new buffer and schedule
        var buffer = getBuffer(mThirdHarmonicFrequency!, _node: mThirdHarmonicNode!)
        mThirdHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: INTERRUPT_LOOP, completionHandler: nil)
        mThirdHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)

    }
    
    func harmonicFourChanged(_frequency: Float)
    {
        //assign new frequency to instance variable
        mFourthHarmonicFrequency = _frequency
		//NSLog("harmoinc fourth in waveform generator to: \(_frequency)")

        //get new buffer and schedule
        var buffer = getBuffer(mFourthHarmonicFrequency!, _node: mFourthHarmonicNode!)
        mFourthHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: INTERRUPT_LOOP, completionHandler: nil)
        mFourthHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
        
    }
    
    func harmonicFiveChanged(_frequency: Float)
    {
        //assign new frequency to instance variable
        mFifthHarmonicFrequency = _frequency
		//        NSLog("harmoinc fifth in waveform generator to: \(_frequency)")

        //get new buffer and schedule
        var buffer = getBuffer(mFifthHarmonicFrequency!, _node: mFifthHarmonicNode!)
        mFifthHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: INTERRUPT_LOOP, completionHandler: nil)
        mFifthHarmonicNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
        
    }
    
    func getBuffer(_frequency: Float, _node: AVAudioNode) -> AVAudioPCMBuffer
    {
		//        NSLog("Getting buffer")
        let audioFormat:AVAudioFormat = _node.outputFormatForBus(0)
		
		let sampleRate:Float = Float(mMixerNode!.outputFormatForBus(0).sampleRate)
        let channelCount = mMixerNode?.outputFormatForBus(0).channelCount
        let frameLength:UInt32 = UInt32(1000)
        let buffer = AVAudioPCMBuffer(PCMFormat: audioFormat, frameCapacity: frameLength)
        buffer.frameLength = frameLength
		NSLog("mixer channel count: \(channelCount!)")
			
        for var i = 0; i < Int(buffer.frameLength); i += Int(channelCount!)
        {
            var val = sinf(_frequency * Float(i) * (2 * Float(M_PI)) / sampleRate)
            buffer.floatChannelData.memory[i] = val
            // NSLog("Val: \(val)")
        }
        
		//        NSLog("returning buffer")
        return buffer
    }

}