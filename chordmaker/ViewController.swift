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
    
    @IBOutlet weak var hundredHertzSlider: UISlider!
    @IBOutlet weak var tenHertzSlider: UISlider!
    @IBOutlet weak var oneHertzSlider: UISlider!
    @IBOutlet weak var tenthHertzSlider: UISlider!
    @IBOutlet weak var hundredthHertzSlider: UISlider!
    
    @IBOutlet weak var firstHarmonicPicker: UIPickerView!
    @IBOutlet weak var secondHarmonicPicker: UIPickerView!
    @IBOutlet weak var thirdHarmonicPicker: UIPickerView!
    @IBOutlet weak var fourthHarmonicPicker: UIPickerView!
    @IBOutlet weak var fifthHarmonicPicker: UIPickerView!
    
    @IBOutlet weak var firstHarmonicSwitch: UISwitch!
    @IBOutlet weak var secondHarmonicSwitch: UISwitch!
    @IBOutlet weak var thirdHarmonicSwitch: UISwitch!
    @IBOutlet weak var fourthHarmonicSwitch: UISwitch!
    @IBOutlet weak var fifthHarmonicSwitch: UISwitch!

    let firstHarmonicPickerData = [kOctave, kPerfectFifth]
    let secondHarmonicPickerData = [kOctave, kMajor3, kMinor3, kSeptimalMinorThird]
    let thirdHarmonicPickerData = [kOctave, kMajorSecond, kMinorWholeTone, kGreaterUnidecimalNeutralSecond, kLesserUnidecimalNeutralSecond]
    let fourthHarmonicPickerData = [kOctave]
    let fifthHarmonicPickerData = [kOctave]
    
    var fundamentalFrequency: Float?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //setup harmonic pickers
        firstHarmonicPickerSetup()
        secondHarmonicPickerSetup()
        thirdHarmonicPickerSetup()
        fourthHarmonicPickerSetup()
        fifthHarmonicPickerSetup()
        
        //setup switch to turn harmonics on/off
        switchSetup()
        
        //setup sliders to adjust frequency
        frequencyValueSliderSetup()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView.tag == 1
        {
            return firstHarmonicPickerData.count
        }
        else if pickerView.tag == 2
        {
            return secondHarmonicPickerData.count
        }
        else if pickerView.tag == 3
        {
            return thirdHarmonicPickerData.count
        }
        else if pickerView.tag == 4
        {
            return fourthHarmonicPickerData.count
        }
        else if pickerView.tag == 5
        {
            return fifthHarmonicPickerData.count
        }
        else
        {
            return 1
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String
    {
        if pickerView.tag == 1
        {
            return firstHarmonicPickerData[row]
        }
        else if pickerView.tag == 2
        {
            return secondHarmonicPickerData[row]
        }
        else if pickerView.tag == 3
        {
            return thirdHarmonicPickerData[row]
        }
        else if pickerView.tag == 4
        {
            return fourthHarmonicPickerData[row]
        }
        else if pickerView.tag == 5
        {
            return fifthHarmonicPickerData[row]
        }
        else
        {
            return ""
        }
    }
    
    func switchSetup()
    {
        firstHarmonicSwitch.on = false
        secondHarmonicSwitch.on = false
        thirdHarmonicSwitch.on = false
        fourthHarmonicSwitch.on = false
        fifthHarmonicSwitch.on = false

    }
    
    func firstHarmonicPickerSetup()
    {
/*
        octave (P8)	1,200.0	0.0
        just perfect fifth	P8 + just perfect fifth (P5)	1,902.0	702.0
*/
        firstHarmonicPicker.delegate = self
        firstHarmonicPicker.tag = 1
    }
    
    func secondHarmonicPickerSetup()
    {
/*
	second octave	2P8	2,400.0	0.0
	just major third	2P8 + just major third (M3)	2,786.3	386.3
	just minor third	2P8 + P5	3,102.0	702.0
	septimal minor third	2P8 + septimal minor seventh (m7)	3,368.8	968.8
*/
        secondHarmonicPicker.delegate = self
        secondHarmonicPicker.tag = 2
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
        thirdHarmonicPicker.delegate = self
        thirdHarmonicPicker.tag = 3
    }
    
    func fourthHarmonicPickerSetup()
    {
        //just (or minor) diatonic semitone	4P8	4,800.0	0.0
        fourthHarmonicPicker.delegate = self
        fourthHarmonicPicker.tag = 4
    }
    
    func fifthHarmonicPickerSetup()
    {
        fifthHarmonicPicker.delegate = self
        fifthHarmonicPicker.tag = 5
    }
    
    func frequencyValueSliderSetup()
    {
        //slider 1 ranges from 0-20K over a linear scale and increments by 100
        hundredHertzSlider.maximumValue = 20000
        hundredHertzSlider.minimumValue = 0
        hundredHertzSlider.value = 9000
        
        //slider 2 ranges from 0-100 over a linear scale and increments by 10
        tenHertzSlider.maximumValue = 90
        tenHertzSlider.minimumValue = 0
        tenHertzSlider.value = 40
        
        //slider 3 ranges from 0-10 over a linear scale and increments by 1
        oneHertzSlider.maximumValue = 9
        oneHertzSlider.minimumValue = 0
        oneHertzSlider.value = 4
        
        //slider 4 ranges from .0 - .9 over a linear scale and increments by .1
        tenthHertzSlider.maximumValue = 0.9
        tenthHertzSlider.minimumValue = 0
        tenthHertzSlider.value = 0.4
        
        //slider 5 ranges from .00-.09 over a linear scale and increments by .01
        hundredthHertzSlider.maximumValue = 0.09
        hundredthHertzSlider.minimumValue = 0
        hundredthHertzSlider.value = 0.04
    }

}

