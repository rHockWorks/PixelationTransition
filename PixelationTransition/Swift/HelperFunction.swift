//
//  HelperFunction.swift
//  PixelationTransition
//
//  Created by Rudolph Hock on 13/07/2021.
//  Copyright © 2021 rHockWorks. All rights reserved.
//

import Foundation
import SpriteKit



var effectNode      : SKEffectNode  = SKEffectNode()    //APPLYING THE PIXELATE FILTER TO THIS PARENT NODE AFFECTS ALL CHILDREN
let pixelateDetail  : Int           = 20                //LEVEL OF PIXELATION (MORE THAN 20 IS OVERKILL)


//LOCATE ALL NODES ON A SCENE AND MOVE THEM TO THE "effectNode"
func locateNodesToPixelate(forScene scene: SKScene) {
    
    scene.enumerateChildNodes(withName: "//*") { (node, stop) in
        node.move(toParent: effectNode)
    }
}


/*  PIXELATE : APPLYING THE CORE IMAGE FILTER TO THE SKEffectNode NODE (A SUBCLASS OF SKNode) WILL AFFECT ALL CHILD NODES
    WHICH WOULD HAVE BEEN MOVED IN THE locateNodesToPixelate FUNCTION CALL WHEN THE SCENE BEGAN (didMove).
 
    IN ORDER TO ACHIEVE THE PIXELATION DEGRADATION EFFECT EACH OF THE 20 TRANSITIONS MUST BE SEEN WHEN THE FILTER IS APPLIED.
    THIS COMPARRED TO THE USUAL SINGLE OUTPUTTED IMAGE.
 
    FOR THIS TO WORK WITHOUT SLOWING DOWN AN ENTIRE SCENE IT IS PLACED ON THREAD OF ITS OWN VIA DispatchQueue.
 
    THE FILTER IS PLACED INSIDE A LOOP OF 20 ITTERATIONS, WITH A SUM TO CALCULATE HOW LONG TO PAUSE FOR EACH TRANSITION.
    
*/
func pixelateSceneNodes() {
    
    for num in 1...pixelateDetail {
        let seconds = 0.3 + 0.1 * Double(num)
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {     //DELAY THE FILTER X NUMBER OF SECONDS FOR EACH TRANSITION
            effectNode.filter = CIFilter(name       : "CIPixellate",
                                         parameters : [kCIInputScaleKey: (num)])
        }
    }
}

//DE-PIXELATE : THE SAME pixelateDetail NUMBER IS USED TO REVERSE THE OPERATION
func depixelateSceneNodes() {
    
    for num in stride(from: pixelateDetail, to: 0, by: -1) {
        let seconds = 0.3 + 0.1 * Double(21 - num)                      //WORKAROUND : ONE ABOVE 20 ELSE SPRITE WILL DISAPPEAR
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            effectNode.filter = CIFilter(name       : "CIPixellate",
                                         parameters : [kCIInputScaleKey: (num)])
        }
    }
}
