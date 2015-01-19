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
    var mFundamental:Float?
    
    //audio engine
    var mAudioEngine:AVAudioEngine?
    
    //audio engine nodes for fundamental and harmonics
    var mFundamentalNode:AVAudioPlayerNode?
    var mFirstHarmonicNode:AVAudioPlayerNode?
    var mSecondHarmonicNode:AVAudioPlayerNode?
    var MthirdHarmonicNode:AVAudioPlayerNode?
    var mFourthHarmonicNode:AVAudioPlayerNode?
    var mFifthHarmonicNode:AVAudioPlayerNode?
    
    //audio engine node for mixer
    var mMixerNode:AVAudioMixerNode?
    
    let mBufferSize = 48000
    
    init(fundamental: Float)
    {
        //setup fundamental freq
        mFundamental = fundamental
        
        //init engine and main mixer
        mAudioEngine = AVAudioEngine()
        mMixerNode = mAudioEngine?.mainMixerNode
        
        //setup fundamental node and connect to main mixer for output
        mFundamentalNode = AVAudioPlayerNode()
        
        mAudioEngine?.attachNode(mFundamentalNode)
        mAudioEngine?.connect(mFundamentalNode, to: mMixerNode, format: nil)
        
    }
    
    func startOscillation()
    {
        //get fundamental
        
        //put waveform in PCM buffer
        
        //        let audioFrameCount:AVAudioFrameCount = AVAudioFrameCount(mBufferSize)
        //let channelLayout:AVAudioChannelLayout = AVAudioChannelLayout(
        
        let buffer = getBuffer()
        
        //start mAudioEngine
        mAudioEngine?.startAndReturnError(nil)
        mFundamentalNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
        mFundamentalNode?.play()
        
    }
    
    func stopOscillation()
    {
        mFundamentalNode?.stop()
        mAudioEngine?.stop()
    }
    

    
    func fundamentalChanged(newFundamental:Float)
    {
        mFundamental = newFundamental
        NSLog("Fundamental changed in waveform generator to: \(mFundamental!)")
        //calculate new waveforms and harmonics
        var buffer = getBuffer()
    
        //schedule buffer
        mFundamentalNode?.scheduleBuffer(buffer, atTime: nil, options: AVAudioPlayerNodeBufferOptions.InterruptsAtLoop, completionHandler: nil)
        mFundamentalNode?.scheduleBuffer(buffer, atTime: nil, options: .Loops, completionHandler: nil)
        
    }
    
    func harmonicOneChanged(harmonicOn: Bool, harmonic: String)
    {
        
    }
    
    func harmonicTwoChanged(harmonicOn: Bool, harmonic: String)
    {
        
    }
    
    func harmonicThreeChanged(harmonicOn: Bool, harmonic: String)
    {
        
    }
    
    func harmonicFourChanged(harmonicOn: Bool, harmonic: String)
    {
        
    }
    
    func harmonicFiveChanged(harmonicOn: Bool, harmonic: String)
    {
        
    }
    
    func getBuffer() -> AVAudioPCMBuffer
    {
        let audioFormat:AVAudioFormat = mFundamentalNode!.outputFormatForBus(0)
        
        let sampleRate:Float = Float(mMixerNode!.outputFormatForBus(0).sampleRate)
        let channelCount = mMixerNode?.outputFormatForBus(0).channelCount
        
        let frameLength:UInt32 = 100
        let buffer = AVAudioPCMBuffer(PCMFormat: audioFormat, frameCapacity: frameLength)
        buffer.frameLength = frameLength
        
        for var i = 0; i < Int(buffer.frameLength); i += Int(channelCount!)
        {
            var val = sinf(mFundamental!*Float(i)*2*Float(M_PI) / sampleRate)
            buffer.floatChannelData.memory[i] = val
        }
        
        return buffer
    }

}