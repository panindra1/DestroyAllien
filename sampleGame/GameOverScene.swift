//
//  GameOverScene.swift
//  sampleGame
//
//  Created by Panindra Tumkur Seetharamu on 7/5/15.
//  Copyright (c) 2015 Panindra Tumkur Seetharamu. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    init(size: CGSize, won:Bool) {
        super.init(size: size)
        self.backgroundColor = SKColor.blackColor()
        var message: String?

        if(won) {
            message = "You win"
        }
        else {
            message = "Game over"
        }

        var label:SKLabelNode = SKLabelNode(fontNamed: "DomascusBold")
        label.text = message!
        label.fontColor = SKColor.whiteColor()
        label.position = CGPointMake(self.size.width / 2, self.size.height / 2)

        self.addChild(label)
        self.runAction(SKAction.sequence([SKAction.waitForDuration(3), SKAction.runBlock() {
                var transition: SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
                var scene:SKScene = GameScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            }]))

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
