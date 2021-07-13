//
//  Scene1.swift
//  PixelationTransition
//
//  Created by Rudolph Hock on 13/07/2021.
//  Copyright © 2021 rHockWorks. All rights reserved.
//

import SpriteKit


class Scene1: SKScene {

    override func didMove(to view: SKView) {
        
        depixelateSceneNodes()                  //BRING THE PIXELATED TEXT BACK TO LIFE WHEN THE SCENE BEGINS
        locateNodesToPixelate(forScene: self)   //FIND ALL OF THE NODES AND ADD TO THE effectNode (TO APPLY THE FILTER TO ALL CHILD NODES)
        effectNode.removeFromParent()           //REMOVE THE LEFT OVER effectNode FROM THE PREVIOUS SCENE
        addChild(effectNode)                    //ADD THE effectNode TO THE SCENE (WITH ALL THE SCENE NODES TIED TO IT)
    }
    
    //WHEN EVER / WHERE EVER THE SCREEN IS TAPPED PERFORM THE PIXELATION ACTION AND TRANSITION TO THE NEXT SCENE
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch == touches.first {
                
                //PIXELATE THE SCENE BEFORE TRANSITIONING AWAY
                pixelateSceneNodes()
                
                //PAUSE SCENE TRANSITION REQUEST FOR TWO WHOLE SECONDS WHILE THE PIXELATION OPERATION COMPLETES
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    effectNode.removeAllChildren()                      //WIPE THE EFFECT NODE CLEAN OF ALL SCENE NODES
                    let scene = Scene2(fileNamed: "Scene2")!            //LOCATE NEXT SCENE
                    self.view?.presentScene(scene)                      //TRANSITION TO NEXT SCENE
                }
            }
        }
    }
}
