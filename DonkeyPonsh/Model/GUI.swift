//
//  GUI.swift
//  DonkeyPonsh
//
//  Created by Jandol on 4/5/18.
//  Copyright © 2018 apporelbotna. All rights reserved.
//

import UIKit
import SpriteKit

class GUI: SKNode
{
    public enum GUIAction
    {
        case left
        case up
        case right
        case out
    }
    
    private static let offset = CGFloat(250)
    private static let transparency = CGFloat(0.3)
    
    private var buttonSize: CGFloat?
    
    private let leftArrow = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "arrow")))
    private let rightArrow = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "arrow")))
    private let upArrow = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "arrow")))
    private var score = SKLabelNode()
    
    override init()
    {
        super.init()
        rightArrow.zRotation = CGFloat.pi
        upArrow.zRotation = -CGFloat.pi / 2
        self.zPosition = 1
        setupScoreLabel()
        
        self.addChild(score)
        self.addChild(leftArrow)
        self.addChild(upArrow)
        self.addChild(rightArrow)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show()
    {
        buttonSize = scene!.frame.width / 3
        print("buttonSize: " + String(describing: buttonSize))
        let positionY = scene!.frame.minY + buttonSize! / 2
        buttonSize! += GUI.offset
        leftArrow.position = CGPoint(x: frame.maxX - buttonSize! / 2, y: positionY)
        leftArrow.alpha = GUI.transparency
        upArrow.position = CGPoint(x: frame.midX, y: positionY)
        upArrow.alpha = GUI.transparency
        rightArrow.position = CGPoint(x: frame.minX + buttonSize! / 2, y: positionY)
        rightArrow.alpha = GUI.transparency
        buttonSize! -= GUI.offset
    }
    
    public func processInput(point: CGPoint) -> GUIAction
    {
        if(point.y < scene!.frame.minY + buttonSize!)
        {
            if(point.x < scene!.frame.minX + buttonSize!)
            {
                print("GUI#processInput: Action left")
                return GUIAction.left
            }
            else if(point.x > scene!.frame.maxX - buttonSize!)
            {
                print("GUI#processInput: Action right")
                return GUIAction.right
            }
            print("GUI#processInput: Action up")
            return GUIAction.up
        }
        print("GUI#processInput: Action out")
        return GUIAction.out
    }
    

    func setupScoreLabel()
    {
        score.fontName = "Arial"
        score.fontSize = 80
        score.text = "Score : 0"
        score.position = CGPoint(x: self.frame.midX, y: self.frame.maxY)
        score.zPosition = 2
        score.alpha = 0.5
    }
}
