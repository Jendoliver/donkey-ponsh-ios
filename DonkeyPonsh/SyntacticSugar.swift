//
//  SyntacticSugar.swift
//  DonkeyPonsh
//
//  Created by Jandol on 9/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import UIKit

class SyntacticSugar: NSObject
{
    public static func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
}
