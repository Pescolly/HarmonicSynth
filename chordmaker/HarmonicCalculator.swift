//
//  HarmonicCalculator.swift
//  chordmaker
//
//  Created by armen karamian on 1/13/15.
//  Copyright (c) 2015 armen karamian. All rights reserved.
//

import Foundation

let kOctave = 1
let kPerfectFifth = 2
let kMajor3 = 3
let kMinor3 = 4
let kSeptimalMinorThird = 5

//                                          ******* ALL HARMONIC MULTIPLIERS ARE WRONG!!!!!!! ******

func calculateFirstHarmonic(fundamental: float_t, harmonicSelection: Int) -> float_t
{
    /*
        octave (P8)	1,200.0	0.0
        just perfect fifth	P8 + just perfect fifth (P5)	1,902.0	702.0
    */
    var firstHarmonic:float_t?
    
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
    return firstHarmonic!
}

func calculateSecondHarmonic(fundamental: float_t, harmonicSelection: Int) -> float_t
{
    /*
    second octave	2P8	2,400.0	0.0
    just major third	2P8 + just major third (M3)	2,786.3	386.3
    just minor third	2P8 + P5	3,102.0	702.0
    septimal minor third	2P8 + septimal minor seventh (m7)	3,368.8	968.8
    */
    var secondHarmonic:float_t?
    if harmonicSelection == kOctave
    {
        secondHarmonic = fundamental * 3
    }
    else if harmonicSelection == kMajor3
    {
        secondHarmonic = fundamental * 3
        secondHarmonic = secondHarmonic! + (fundamental * 1.25)          //todo: FIX!
    }
    else if harmonicSelection == kMinor3
    {
        secondHarmonic = fundamental * 3
        secondHarmonic = secondHarmonic! + (fundamental * 1.5)   //todo: FIX!
    }
    else if harmonicSelection == kSeptimalMinorThird
    {
        secondHarmonic = fundamental * 3
        secondHarmonic = secondHarmonic! + (fundamental * 1.67)
    }
    else
    {
        secondHarmonic = 0
    }
    return secondHarmonic!
}