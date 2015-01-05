//
//  ViewController.swift
//  chordmaker
//
//  Created by armen karamian on 1/4/15.
//  Copyright (c) 2015 armen karamian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{

    @IBOutlet weak var firstHarmonicPicker: UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func firstHarmonicSliderSetup()
    {
/*
        octave (P8)	1,200.0	0.0
        just perfect fifth	P8 + just perfect fifth (P5)	1,902.0	702.0
*/

        let pickerData = ["Octave","Perfect 5th", "OFF"]
    }
    func secondHarmonicSliderSetup()
    {
/*
	second octave	2P8	2,400.0	0.0
	just major third	2P8 + just major third (M3)	2,786.3	386.3
	just minor third	2P8 + P5	3,102.0	702.0
	septimal minor third	2P8 + septimal minor seventh (m7)	3,368.8	968.8
*/

        let pickerData = ["2nd","2nd + M3","M3","2nd + m3","m3", "m7"]

        
    }
    
    func thirdHarmonicPickerSetup()
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
    }
    
    func fourthHarmonicPickerSetup()
    {
        
    }
    
    func sliderControls()
    {
    //slider 1 ranges from 0-20K over a linear scale and increments by 100
    
    //slider 2 ranges from 0-100 over a linear scale and increments by 1
    
    //slider 3 ranges from .01-.99 over a linear scale and increments by .01
    }

}

