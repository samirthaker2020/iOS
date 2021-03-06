//
//  TLLaserSphere.swift
//  iOS_Game_003
//
//  Created by Alexander Wegner on 17.12.15.
//  Copyright © 2015 Alexander Wegner. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class TLLaserSphere: SKSpriteNode {
    var blExploded = false
    var blActive = false
    var aAnimation = Array<SKTexture>()
    var apLaserSphereShootingSound: AVAudioPlayer!
    
    init(size: CGSize) {
        super.init(texture: SKTexture(imageNamed: "Media/effects/sphere_001.png"), color: UIColor.clear, size: CGSize(width: size.width, height: size.height))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: flShipPosX + (snShip.frame.size.width/2) + (size.width/2), y: flShipPosY)
        // --- physics body ---
        self.physicsBody = SKPhysicsBody(circleOfRadius: (self.size.width/2) - (4 * (flScreenWidth/667.0)))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = enBodyType.laserSphere.rawValue
        self.physicsBody?.contactTestBitMask = enBodyType.meteorite.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.zPosition = 1.1
        aAnimation.removeAll()
        aAnimation.append(SKTexture(imageNamed: "Media/effects/sphere_001.png"))
        aAnimation.append(SKTexture(imageNamed: "Media/effects/sphere_002.png"))
        aAnimation.append(SKTexture(imageNamed: "Media/effects/sphere_003.png"))
        aAnimation.append(SKTexture(imageNamed: "Media/effects/sphere_004.png"))
        aAnimation.append(SKTexture(imageNamed: "Media/effects/sphere_005.png"))
        aAnimation.append(SKTexture(imageNamed: "Media/effects/sphere_006.png"))
        
        self.removeAllActions()
        let actMoving = SKAction.animate(with: aAnimation, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(actMoving))
        
        if GameData.blSoundEffectsEnabled == true {
            // Sounds for laser sphere
            let path = Bundle.main.path(forResource: "Media/sounds/laser_006", ofType:"wav")
            let fileURL = URL(fileURLWithPath: path!)
            do {
                try apLaserSphereShootingSound = AVAudioPlayer(contentsOf: fileURL, fileTypeHint: nil)
            } catch {
                print("Could not create audio player: \(error)")
                return
            }
            apLaserSphereShootingSound.numberOfLoops = 0
            apLaserSphereShootingSound.volume = GameData.flSoundsVolume
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fctMoveRight() {
        let actShoot = SKAction.moveBy(x: flScreenWidth, y: 0, duration: 3.0)
        self.run(actShoot, completion: {() in
            self.fctExplode()
        })
    }
    
    func fctExplode() {
        self.blExploded = true
        self.blActive = false
        let actExplode = SKAction.animate(with: aAnimation, timePerFrame: 0.05)
        self.removeAllActions()
        self.physicsBody?.categoryBitMask = 0
        self.physicsBody?.contactTestBitMask = 0
        self.run(actExplode, completion: {() in
            self.blActive = false
            self.removeAllActions()
            self.removeFromParent()
        })
    }
    
    func fctPlayShootingSound() {
        if GameData.blSoundEffectsEnabled == true {
            apLaserSphereShootingSound.volume = GameData.flSoundsVolume
            apLaserSphereShootingSound.prepareToPlay()
            apLaserSphereShootingSound.play()
        }
    }
}
