//
//  GameViewController.swift
//  sampleGame
//
//  Created by Panindra Tumkur Seetharamu on 7/4/15.
//  Copyright (c) 2015 Panindra Tumkur Seetharamu. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    var backgroundAVMusicPlayer :AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }*/
    }

    override func viewWillLayoutSubviews() {
        var bgMusicURL :NSURL? = NSBundle.mainBundle().URLForResource("bgmusic", withExtension: "mp3")
        backgroundAVMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        backgroundAVMusicPlayer?.numberOfLoops = -1
        backgroundAVMusicPlayer?.prepareToPlay()
        backgroundAVMusicPlayer?.play()

        var sKView: SKView? = self.view as? SKView
        sKView?.showsFPS = true
        sKView?.showsNodeCount = true

        var scene: SKScene = GameScene(size: sKView!.bounds.size)
        scene.scaleMode =  SKSceneScaleMode.AspectFill
        sKView?.presentScene(scene)

    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
