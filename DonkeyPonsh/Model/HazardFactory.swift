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
    private let upperDistanceToPlayer: CGFloat
    
    private var scene: GameScene?
    
    init(scene: GameScene)
    {
        self.scene = scene
        upperDistanceToPlayer = scene.frame.size.height
    }
    
    public func generateHazard() -> Hazard
    {
        return Hazard(pos: CGPoint(x: SyntacticSugar.random(scene!.frame.minX..<scene!.frame.maxY), y: scene!.player!.position.y + upperDistanceToPlayer))
    }
}
