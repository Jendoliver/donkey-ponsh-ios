//
//  HazardFactory.swift
//  DonkeyPonsh
//
//  Created by Jandol on 12/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import UIKit
import SpriteKit

class HazardFactory: NSObject
{
    private let upperMargin = CGFloat(200)
    
    private var scene: SKScene?
    
    init(scene: SKScene)
    {
        self.scene = scene
    }
    
    public func generateHazard() -> Hazard
    {
        return Hazard(pos: CGPoint(x: SyntacticSugar.random(scene!.frame.minX..<scene!.frame.maxY), y: scene!.frame.maxY + upperMargin))
    }
}
