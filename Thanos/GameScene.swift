//
//  GameScene.swift
//  Thanos
//
//  Created by Ariel Marasigan on 26/04/2019.
//  Copyright © 2019 Ariel Marasigan. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var thanos_idle = SKSpriteNode()
    private var thanos_snap = SKSpriteNode()
    private var thanos_time = SKSpriteNode()
    private var textureArraysnap = [SKTexture]()
    private var textureArraytime = [SKTexture]()
    private var status = 0
    private var label1 = SKLabelNode(text: "Ervin")
    private var label2 = SKLabelNode(text: "Poochai")
    private var label3 = SKLabelNode(text: "Neil")
    private var label4 = SKLabelNode(text: "Jepong")
    private var label5 = SKLabelNode(text: "Sinag")
    private var label6 = SKLabelNode(text: "Daryl")
    private var label7 = SKLabelNode(text: "Bryan")
    
    override func didMove(to view: SKView) {
        
        let sheetSnap = SpriteSheet(texture: SKTexture(imageNamed: "thanos_snap"), rows: 1, columns: 48, spacing: 0, margin: 0)
        let sheetTime = SpriteSheet(texture: SKTexture(imageNamed: "thanos_time"), rows: 1, columns: 48, spacing: 0, margin: 0)
        
        for i in 1...47 {
//            var sprite = SKSpriteNode(texture: sheet.textureForColumn(column: i, row: 0))
//
            textureArraysnap.append(sheetSnap.textureForColumn(column: i, row: 0)!)
            textureArraytime.append(sheetTime.textureForColumn(column: i, row: 0)!)
        }

//        thanos = SKSpriteNode(texture: textureArraysnap[0])
        thanos_idle = SKSpriteNode(imageNamed: "thanos_idle")
        thanosIdle()
        addLabels()
        
        
        
    }
    
    func addRewindLabel() {
        label1.position = CGPoint(x: -150, y: -250)
        label3.position = CGPoint(x: -130, y: 250)
        label4.position = CGPoint(x: -100, y: 0)
        label5.position = CGPoint(x: 130, y: 0)
        label6.position = CGPoint(x: 50, y: 150)
        label7.position = CGPoint(x: 100, y: -220)
        addChild(label1)
        addChild(label3)
        addChild(label4)
        addChild(label5)
        addChild(label6)
        addChild(label7)
    }
    
    func addLabels() {
        label1.position = CGPoint(x: -150, y: -250)
        label2.position = CGPoint(x: 150, y: 250)
        label3.position = CGPoint(x: -130, y: 250)
        label4.position = CGPoint(x: -100, y: 0)
        label5.position = CGPoint(x: 130, y: 0)
        label6.position = CGPoint(x: 50, y: 150)
        label7.position = CGPoint(x: 100, y: -220)
        addChild(label1)
        addChild(label2)
        addChild(label3)
        addChild(label4)
        addChild(label5)
        addChild(label6)
        addChild(label7)
    }
    
    func thanosIdle() {
        addChild(thanos_idle)
    }
    
    func removeThanosIdle() {
        thanos_idle.removeFromParent()
    }
    
    func snap() {
        removeThanosIdle()
        thanos_snap = SKSpriteNode(texture: textureArraysnap[0])
        addChild(thanos_snap)
        thanos_snap.run(SKAction.repeat(SKAction.animate(with: textureArraysnap, timePerFrame: 0.03), count: 1)) {
            self.thanos_snap.removeFromParent()
            self.thanosIdle()
            self.vanish()
            
        }
        status = 1
    }
    
    func vanish() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.label1.removeFromParent()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.label3.removeFromParent()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.label4.removeFromParent()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.label5.removeFromParent()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            self.label6.removeFromParent()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
            self.label7.removeFromParent()
        })
        
    }
    
    func rewind() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.addRewindLabel()
        })
        
    }
    
    func time() {
        removeThanosIdle()
        thanos_time = SKSpriteNode(texture: textureArraytime[0])
        addChild(thanos_time)
        thanos_time.isUserInteractionEnabled = false
        thanos_time.run(SKAction.repeat(SKAction.animate(with: textureArraytime, timePerFrame: 0.03), count: 1)) {
            self.thanos_time.removeFromParent()
            self.thanosIdle()
            self.rewind()
        }
        status = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        label?.text = "FUCK YOU!"
        if status == 0 {
            snap()
        } else {
            time()
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
