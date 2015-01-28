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
    @IBOutlet weak var oneTenthHertzSlider: UISlider!
    @IBOutlet weak var oneHundrethHertzSlider: UISlider!
    
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
    
    @IBOutlet var fundamentalFrequencyOutput: UITextField!
    
    @IBOutlet var mDrawView: UIView!
    
    let firstHarmonicPickerData = [kOctave, kPerfectFifth]
    let secondHarmonicPickerData = [kOctave, kMajor3, kMinor3, kSeptimalMinorThird]
    let thirdHarmonicPickerData = [kOctave, kMajorSecond, kMinorWholeTone, kGreaterUnidecimalNeutralSecond, kLesserUnidecimalNeutralSecond]
    let fourthHarmonicPickerData = [kOctave]
    let fifthHarmonicPickerData = [kOctave]
    
    var mFundamentalFrequency: Float? = 1000
    
    var mWaveformGenerator:WaveformGenerator?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //setup harmonic pickers
        pickerSetup()
        
        //setup switch to turn harmonics on/off
        switchSetup()
        
        //setup sliders to adjust frequency
        frequencyValueSliderSetup()
        
        //setup audioengine/ waveform gen
        mWaveformGenerator = WaveformGenerator(
            _fundamental: mFundamentalFrequency!,
            _firstHarmonic: calculateFirstHarmonic(mFundamentalFrequency!, kOctave),
            _secondHarmonic: calculateSecondHarmonic(mFundamentalFrequency!, kOctave),
            _thirdHarmonic: calculateThirdHarmonic(mFundamentalFrequency!, kOctave),
            _fourthHarmonic: calculateFourthHarmonic(mFundamentalFrequency!, kOctave),
            _fifthHarmonic: calculateFifthHarmonic(mFundamentalFrequency!, kOctave)
        )
        
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
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == firstHarmonicPicker
        {
            NSLog("first harmonic selected")
            mWaveformGenerator?.harmonicOneChanged(calculateFirstHarmonic(mFundamentalFrequency!,
                firstHarmonicPickerData[pickerView.selectedRowInComponent(component)]))
        }

        if pickerView == secondHarmonicPicker
        {
            NSLog("second harmonic selected")
            mWaveformGenerator?.harmonicTwoChanged(calculateSecondHarmonic(mFundamentalFrequency!, secondHarmonicPickerData[pickerView.selectedRowInComponent(component)]))
        }
        
        if pickerView == thirdHarmonicPicker
        {
            mWaveformGenerator?.harmonicThreeChanged(calculateThirdHarmonic(mFundamentalFrequency!, thirdHarmonicPickerData[pickerView.selectedRowInComponent(component)]))
        }
        
        if pickerView == fourthHarmonicPicker
        {
            mWaveformGenerator?.harmonicFourChanged(calculateFourthHarmonic(mFundamentalFrequency!, fourthHarmonicPickerData[pickerView.selectedRowInComponent(component)]))
        }
        
        if pickerView == fifthHarmonicPicker
        {
            mWaveformGenerator?.harmonicFiveChanged(calculateFifthHarmonic(mFundamentalFrequency!, fifthHarmonicPickerData[pickerView.selectedRowInComponent(component)]))
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
    
    func pickerSetup()
    {
        firstHarmonicPicker.delegate = self
        firstHarmonicPicker.tag = 1
        secondHarmonicPicker.delegate = self
        secondHarmonicPicker.tag = 2
        thirdHarmonicPicker.delegate = self
        thirdHarmonicPicker.tag = 3
        fourthHarmonicPicker.delegate = self
        fourthHarmonicPicker.tag = 4
        fifthHarmonicPicker.delegate = self
        fifthHarmonicPicker.tag = 5
    }
    
    func frequencyValueSliderSetup()
    {
        //        NSLog("Running frequency value slider setup")
        //slider 1 ranges from 0-20K over a linear scale and increments by 100
        hundredHertzSlider.maximumValue = 199
        hundredHertzSlider.minimumValue = 0
        hundredHertzSlider.continuous = true
        hundredHertzSlider.value = 10
        
        
        //slider 2 ranges from 0-100 over a linear scale and increments by 10
        tenHertzSlider.maximumValue = 9
        tenHertzSlider.minimumValue = 0
        tenHertzSlider.continuous = true
        tenHertzSlider.value = 0
        
        //slider 3 ranges from 0-10 over a linear scale and increments by 1
        oneHertzSlider.maximumValue = 9
        oneHertzSlider.minimumValue = 0
        oneHertzSlider.continuous = true
        oneHertzSlider.value = 0
        
        //slider 4 ranges from .0 - .9 over a linear scale and increments by .1
        oneTenthHertzSlider.maximumValue = 9
        oneTenthHertzSlider.minimumValue = 0
        oneTenthHertzSlider.continuous = true
        oneTenthHertzSlider.value = 0
        
        //slider 5 ranges from .00-.09 over a linear scale and increments by .01
        oneHundrethHertzSlider.maximumValue = 9
        oneHundrethHertzSlider.minimumValue = 0
        oneHundrethHertzSlider.continuous = true
        oneHundrethHertzSlider.value = 0
    }

    @IBAction func octaveIncrement(sender: UIButton)
    {
        
        var newFundamentalFrequency = mFundamentalFrequency! * 2
        if newFundamentalFrequency < 20000
        {
            mFundamentalFrequency = newFundamentalFrequency
            mWaveformGenerator?.fundamentalChanged(mFundamentalFrequency!)
            fundamentalFrequencyOutput.text = toString(mFundamentalFrequency!)
        }
    }
    
    @IBAction func octaveDecrement(sender: UIButton)
    {
        var newFundamentalFrequency = mFundamentalFrequency! / 2
        if newFundamentalFrequency > 20
        {
            mFundamentalFrequency = newFundamentalFrequency
            mWaveformGenerator?.fundamentalChanged(mFundamentalFrequency!)
            fundamentalFrequencyOutput.text = toString(mFundamentalFrequency!)
        }
    }
    
    @IBAction func frequencyValueSlidersChanged(sender: UISlider)
    {
        //get fundamental frequency from sliders
        let hundredHertzSliderValue:Int = Int(hundredHertzSlider.value) * 100
        let tenHertzSliderValue:Int = Int(tenHertzSlider.value) * 10
        let oneHertzSliderValue:Int = Int(oneHertzSlider.value)
        let oneTenthHertzSliderValue:Float = Float(Int(oneTenthHertzSlider.value)) / 10
        let oneHundrethHertzSliderValue:Float = Float(Int(oneHundrethHertzSlider.value)) / 100
        
        NSLog("\(hundredHertzSliderValue) + \(tenHertzSliderValue)")
        
        mFundamentalFrequency = Float(hundredHertzSliderValue) +
            Float(tenHertzSliderValue) +
            Float(oneHertzSliderValue) +
            oneTenthHertzSliderValue +
            oneHundrethHertzSliderValue
        
        mWaveformGenerator?.fundamentalChanged(mFundamentalFrequency!)
        
        mWaveformGenerator?.harmonicOneChanged(calculateFirstHarmonic(mFundamentalFrequency!,
            firstHarmonicPickerData[firstHarmonicPicker.selectedRowInComponent(0)]))
        
        mWaveformGenerator?.harmonicTwoChanged(calculateSecondHarmonic(mFundamentalFrequency!, secondHarmonicPickerData[secondHarmonicPicker.selectedRowInComponent(0)]))
        
        mWaveformGenerator?.harmonicThreeChanged(calculateThirdHarmonic(mFundamentalFrequency!, thirdHarmonicPickerData[thirdHarmonicPicker.selectedRowInComponent(0)]))
        
        mWaveformGenerator?.harmonicFourChanged(calculateFourthHarmonic(mFundamentalFrequency!, fourthHarmonicPickerData[fourthHarmonicPicker.selectedRowInComponent(0)]))
        
        mWaveformGenerator?.harmonicFiveChanged(calculateFifthHarmonic(mFundamentalFrequency!, fifthHarmonicPickerData[fifthHarmonicPicker.selectedRowInComponent(0)]))
        
        fundamentalFrequencyOutput.text = toString(mFundamentalFrequency!)
        
        //assign WaveformView buffer to mTapBuffer from generator
        let drawView:WaveformView = mDrawView as WaveformView
        if mWaveformGenerator?.mTapBuffer != nil
        {
            drawView.mBuffer = mWaveformGenerator?.mTapBuffer!
            NSLog("assigned waveform generator buffer to drawview buffer")
        }
        
    }
    
    
    
    @IBAction func startOscillation(sender: UIButton)
    {
        mWaveformGenerator?.startOscillation()
    }
    
    @IBAction func stopOscillator(sender: UIButton)
    {
        mWaveformGenerator?.stopOscillation()
    }
    
    @IBAction func firstHarmonicSwitched(sender: UISwitch)
    {
        if sender.on == true
        {
            mWaveformGenerator?.mFirstHarmonicNodeConnected = true
        }
        if sender.on == false
        {
            mWaveformGenerator?.mFirstHarmonicNodeConnected = false
        }
    }
    
    @IBAction func secondHarmonicSwitch(sender: UISwitch)
    {
        if sender.on == true
        {
            mWaveformGenerator?.mSecondHarmonicNodeConnected = true
        }
        if sender.on == false
        {
            mWaveformGenerator?.mSecondHarmonicNodeConnected = false
        }
    }
    
    @IBAction func thirdHarmonicSwitched(sender: UISwitch)
    {
        if sender.on == true
        {
            mWaveformGenerator?.mThirdHarmonicNodeConnected = true
        }
        if sender.on == false
        {
            mWaveformGenerator?.mThirdHarmonicNodeConnected = false
        }
    }
    
    @IBAction func fourthHarmonicSwitched(sender: UISwitch)
    {
        if sender.on == true
        {
            mWaveformGenerator?.mFourthHarmonicNodeConnected = true
        }
        if sender.on == false
        {
            mWaveformGenerator?.mFourthHarmonicNodeConnected = false
        }
    }
    
    @IBAction func fifthHarmonicSwitched(sender: UISwitch)
    {
        if sender.on == true
        {
            mWaveformGenerator?.mFifthHarmonicNodeConnected = true
        }
        if sender.on == false
        {
            mWaveformGenerator?.mFifthHarmonicNodeConnected = false
        }
    }
}

