//
//  HarmonicCalculator.swift
//  chordmaker
//
//  Created by armen karamian on 1/13/15.
//  Copyright (c) 2015 armen karamian. All rights reserved.
//

import Foundation

let kOctave = "Octave"
let kPerfectFifth = "P5"
let kMajor3 = "M3"
let kMinor3 = "m3"
let kSeptimalMinorThird = "7m3"
let kMajorSecond = "M2"
let kSeptimalMajorSecond = "7M2"
let kMinorWholeTone = "m2"
let kGreaterUnidecimalNeutralSecond = "GN2"
let kLesserUnidecimalNeutralSecond = "lN2"
let kTridecimalTwoThirds = "2:3"
let kTwoThirds = "2:3"


//                                          ******* ALL HARMONIC MULTIPLIERS ARE WRONG!!!!!!! ******

func calculateFirstHarmonic(fundamental: Float, harmonicSelection: String) -> Float
{
    /*
        octave (P8)	1,200.0	0.0
        just perfect fifth	P8 + just perfect fifth (P5)	1,902.0	702.0
    */
    var firstHarmonic:Float?
    
    if harmonicSelection == kOctave
    {
        firstHarmonic = fundamental * 2
    }
    else if harmonicSelection == kPerfectFifth
    {
        firstHarmonic = (fundamental * 2)
        firstHarmonic =  firstHarmonic! + (firstHarmonic! * 1.5)    //todo: FIX!
    }
    else
    {
        firstHarmonic = 0
    }
    NSLog("First harmonic calculated: \(firstHarmonic!)")
    return firstHarmonic!
}

func calculateSecondHarmonic(fundamental: Float, harmonicSelection: String) -> Float
{
    /*
    second octave	2P8	2,400.0	0.0
    just major third	2P8 + just major third (M3)	2,786.3	386.3
    just minor third	2P8 + P5	3,102.0	702.0
    septimal minor third	2P8 + septimal minor seventh (m7)	3,368.8	968.8
    */
    var secondHarmonic:Float?
    if harmonicSelection == kOctave
    {
        secondHarmonic = fundamental * 3
    }
    else if harmonicSelection == kMajor3
    {
        secondHarmonic = fundamental * 3
        secondHarmonic = secondHarmonic! + (secondHarmonic! * 1.25)          //todo: FIX!
    }
    else if harmonicSelection == kMinor3
    {
        secondHarmonic = fundamental * 3
        secondHarmonic = secondHarmonic! + (secondHarmonic! * (3/2))   //todo: FIX!
    }
    else if harmonicSelection == kSeptimalMinorThird
    {
        secondHarmonic = fundamental * 3
        secondHarmonic = secondHarmonic! + (secondHarmonic! * 1.67)
    }
    else
    {
        secondHarmonic = 0
    }
    return secondHarmonic!
}

func calculateThirdHarmonic(fundamental: Float, harmonicSelection: String) -> Float
{
    /*
    septimal major second	3P8	3,600.0	0.0
    Pythagorean major second	3P8 + Pythagorean major second (M2)	3,803.9	203.9
    just minor whole tone	3P8 + just M3	3,986.3	386.3
    greater unidecimal neutral second	3P8 + lesser undecimal tritone	4,151.3	551.3
    lesser unidecimal neutral second	3P8 + P5	4,302.0	702.0
    tridecimal 2/3-tone	3P8 + tridecimal neutral sixth (n6)	4,440.5	840.5
    2/3-tone	3P8 + P5 + septimal minor third (m3)	4,568.8	968.8
    septimal (or major) diatonic semitone	3P8 + just major seventh (M7)	4,688.3	1,088.3
    */
    
    var thirdHarmonic:Float?
    
    if harmonicSelection == kOctave
    {
        thirdHarmonic = fundamental * 4
    }
    else if harmonicSelection == kMajorSecond
    {
        thirdHarmonic = fundamental * 4
        thirdHarmonic = thirdHarmonic! + (thirdHarmonic! * (9/8))
    }
    else if harmonicSelection == kSeptimalMajorSecond
    {
        thirdHarmonic = fundamental * 4
        thirdHarmonic = thirdHarmonic! + (thirdHarmonic! * (8/7))
    }
    else if harmonicSelection == kMinorWholeTone            // AKA minorSecond
    {
        thirdHarmonic = fundamental * 4
        thirdHarmonic = thirdHarmonic! + (thirdHarmonic! * (16/15))
    }
    else if harmonicSelection == kGreaterUnidecimalNeutralSecond
    {
        thirdHarmonic = fundamental * 4
        thirdHarmonic = thirdHarmonic! + (thirdHarmonic! * (15/11))
    }
    else if harmonicSelection == kLesserUnidecimalNeutralSecond
    {
        thirdHarmonic = fundamental * 4
        thirdHarmonic = thirdHarmonic! + (thirdHarmonic! * (3/2))
    }
    else
    {
        thirdHarmonic = 0
    }
    return thirdHarmonic!
}

func calculateFourthHarmonic(fundamental: Float, harmonicSelection: String) -> Float
{
    var fourthHarmonic:Float?
    
    if harmonicSelection == kOctave
    {
        fourthHarmonic = fundamental * 5
    }
    else
    {
        fourthHarmonic = 0
    }
    
    return fourthHarmonic!
}

func calculateFifthHarmonic(fundamental: Float, harmonicSelection: String) -> Float
{
    var fifthHarmonic:Float?
    
    if harmonicSelection == kOctave
    {
        fifthHarmonic = fundamental * 6
    }
    else
    {
        fifthHarmonic = 0
    }
    
    return fifthHarmonic!
}