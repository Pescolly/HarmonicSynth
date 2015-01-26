//
//  Line.swift
//  chordmaker
//
//  Created by armen karamian on 1/25/15.
//  Copyright (c) 2015 armen karamian. All rights reserved.
//

import UIKit
import Foundation

class Line: NSObject
{
    var mStart:CGPoint
    var mEnd:CGPoint
    
    init(start _start: CGPoint, end _end: CGPoint)
    {
        mStart = _start
        mEnd = _end
    }
}
