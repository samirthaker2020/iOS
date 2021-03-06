//
//  TLInventory.swift
//  iOS_Game_003
//
//  Created by Alexander Wegner on 15.12.15.
//  Copyright © 2015 Alexander Wegner. All rights reserved.
//

import Foundation
import SpriteKit

class TLInventory: SKSpriteNode {
    var snMenuWpnLaserCone: SKSpriteNode!
    var snMenuWpnLaserSphere: SKSpriteNode!
    var snMenuWpnLaserDisruptor: SKSpriteNode!
    var snMenuWpnLaser: SKSpriteNode!
    var snMenuBack: SKSpriteNode!
    
    init(size: CGSize) {
        //let txBackground_001 = SKTexture(imageNamed: "Media/reactor_001.png")
        
        super.init(texture: nil,color: UIColor.clear, size: CGSize(width: size.width, height: size.height))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // --- Part 001 ---
        let snBackground_001 = SKSpriteNode(texture: nil,color: UIColor.black, size: CGSize(width: size.width, height: size.height))
        snBackground_001.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        snBackground_001.position = CGPoint(x: flScreenWidth / 2, y: flScreenHeight / 2)
        snBackground_001.alpha = 0.8
        //snBackground_001.zPosition = 2.5
        addChild(snBackground_001)
        // Menu "Back" Sprite
        let flMenuBackSpriteWidth = (SKTexture(imageNamed: "Media/menu_back.png").size().width) * (self.frame.width/667.0)
        let flMenuBackSpriteHeight = (SKTexture(imageNamed: "Media/menu_back.png").size().height) * (self.frame.height/375.0)
        snMenuBack = SKSpriteNode(texture: SKTexture(imageNamed: "Media/menu_back.png"), color: UIColor.clear, size: CGSize(width: flMenuBackSpriteWidth, height: flMenuBackSpriteHeight))
        snMenuBack.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        snMenuBack.position = CGPoint(x: 1*(flScreenWidth / 16), y: 10*(flScreenHeight / 12))
        snMenuBack.zPosition = 2.2
        snMenuBack.alpha = 1.0
        snMenuBack.name = "MenuBack"
        self.addChild(snMenuBack)
        // Weapons
        let flMenuWpnSpriteWidth = (SKTexture(imageNamed: "Media/wpn_laser_cone_unequipped.png").size().width) * (self.frame.width/667.0)
        let flMenuWpnSpriteHeight = (SKTexture(imageNamed: "Media/wpn_laser_cone_unequipped.png").size().height) * (self.frame.height/375.0)
        // Weapon laser
        snMenuWpnLaser = SKSpriteNode(texture: SKTexture(imageNamed: "Media/wpn_laser_unchecked.png"), color: UIColor.clear, size: CGSize(width: flMenuWpnSpriteWidth, height: flMenuWpnSpriteHeight))
        snMenuWpnLaser.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        snMenuWpnLaser.position = CGPoint(x: 5*(flScreenWidth / 16), y:flScreenHeight / 2)
        snMenuWpnLaser.zPosition = 2.2
        snMenuWpnLaser.alpha = 1.0
        snMenuWpnLaser.name = "MenuWpnLaser"
        self.addChild(snMenuWpnLaser)
        // Weapon laser cone
        snMenuWpnLaserCone = SKSpriteNode(texture: SKTexture(imageNamed: "Media/wpn_laser_cone_unequipped.png"), color: UIColor.clear, size: CGSize(width: flMenuWpnSpriteWidth, height: flMenuWpnSpriteHeight))
        snMenuWpnLaserCone.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        snMenuWpnLaserCone.position = CGPoint(x: 8*(flScreenWidth / 16), y:flScreenHeight / 2)
        snMenuWpnLaserCone.zPosition = 2.2
        snMenuWpnLaserCone.alpha = 1.0
        snMenuWpnLaserCone.name = "MenuWpnLaserCone"
        self.addChild(snMenuWpnLaserCone)
        // Weapon laser sphere
        snMenuWpnLaserSphere = SKSpriteNode(texture: SKTexture(imageNamed: "Media/wpn_laser_sphere_unequipped.png"), color: UIColor.clear, size: CGSize(width: flMenuWpnSpriteWidth, height: flMenuWpnSpriteHeight))
        snMenuWpnLaserSphere.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        snMenuWpnLaserSphere.position = CGPoint(x: 11*(flScreenWidth / 16), y:flScreenHeight / 2)
        snMenuWpnLaserSphere.zPosition = 2.2
        snMenuWpnLaserSphere.alpha = 1.0
        snMenuWpnLaserSphere.name = "MenuWpnLaserSphere"
        self.addChild(snMenuWpnLaserSphere)
        // Achievement
        if (GameData.iAchieved & (1<<2) == (1<<2)) {
            snMenuWpnLaser.position = CGPoint(x: 3.5*(flScreenWidth / 16), y:flScreenHeight / 2)
            snMenuWpnLaserCone.position = CGPoint(x: 6.5*(flScreenWidth / 16), y:flScreenHeight / 2)
            snMenuWpnLaserSphere.position = CGPoint(x: 9.5*(flScreenWidth / 16), y:flScreenHeight / 2)
            // Weapon laser sphere
            snMenuWpnLaserDisruptor = SKSpriteNode(texture: SKTexture(imageNamed: "Media/wpn_laser_sphere_unequipped.png"), color: UIColor.clear, size: CGSize(width: flMenuWpnSpriteWidth, height: flMenuWpnSpriteHeight))
            snMenuWpnLaserDisruptor.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            snMenuWpnLaserDisruptor.position = CGPoint(x: 12.5*(flScreenWidth / 16), y:flScreenHeight / 2)
            snMenuWpnLaserDisruptor.zPosition = 2.2
            snMenuWpnLaserDisruptor.alpha = 1.0
            snMenuWpnLaserDisruptor.name = "MenuWpnLaserDisruptor"
            self.addChild(snMenuWpnLaserDisruptor)
        }
        fctUpdateWpns()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fctUpdateWpns() {
        switch (iSelectedWeapon) {
        case 0: // laser
            snMenuWpnLaser.texture = SKTexture(imageNamed: "Media/wpn_laser_checked.png")
            if blLaserConePickedUp == true {
                snMenuWpnLaserCone.texture = SKTexture(imageNamed: "Media/wpn_laser_cone_unchecked.png")
            } else {
                snMenuWpnLaserCone.texture = SKTexture(imageNamed: "Media/wpn_laser_cone_unequipped.png")
            }
            if blLaserSpherePickedUp == true {
                snMenuWpnLaserSphere.texture = SKTexture(imageNamed: "Media/wpn_laser_sphere_unchecked.png")
            } else {
                snMenuWpnLaserSphere.texture = SKTexture(imageNamed: "Media/wpn_laser_sphere_unequipped.png")
            }
            if (GameData.iAchieved & (1<<2) == (1<<2)) {
                if blLaserDisruptorPickedUp == true {
                    snMenuWpnLaserDisruptor.texture = SKTexture(imageNamed: "Media/wpn_laser_disruptor_unchecked.png")
                } else {
                    snMenuWpnLaserDisruptor.texture = SKTexture(imageNamed: "Media/wpn_laser_disruptor_unequipped.png")
                }
            }
        case 1: // sphere
            snMenuWpnLaserSphere.texture = SKTexture(imageNamed: "Media/wpn_laser_sphere_checked.png")
            snMenuWpnLaser.texture = SKTexture(imageNamed: "Media/wpn_laser_unchecked.png")
            if blLaserConePickedUp == true {
                snMenuWpnLaserCone.texture = SKTexture(imageNamed: "Media/wpn_laser_cone_unchecked.png")
            } else {
                snMenuWpnLaserCone.texture = SKTexture(imageNamed: "Media/wpn_laser_cone_unequipped.png")
            }
            if (GameData.iAchieved & (1<<2) == (1<<2)) {
                if blLaserDisruptorPickedUp == true {
                    snMenuWpnLaserDisruptor.texture = SKTexture(imageNamed: "Media/wpn_laser_disruptor_unchecked.png")
                } else {
                    snMenuWpnLaserDisruptor.texture = SKTexture(imageNamed: "Media/wpn_laser_disruptor_unequipped.png")
                }
            }
        case 2: // cone
            snMenuWpnLaserCone.texture = SKTexture(imageNamed: "Media/wpn_laser_cone_checked.png")
            snMenuWpnLaser.texture = SKTexture(imageNamed: "Media/wpn_laser_unchecked.png")
            if blLaserSpherePickedUp == true {
                snMenuWpnLaserSphere.texture = SKTexture(imageNamed: "Media/wpn_laser_sphere_unchecked.png")
            } else {
                snMenuWpnLaserSphere.texture = SKTexture(imageNamed: "Media/wpn_laser_sphere_unequipped.png")
            }
            if (GameData.iAchieved & (1<<2) == (1<<2)) {
                if blLaserDisruptorPickedUp == true {
                    snMenuWpnLaserDisruptor.texture = SKTexture(imageNamed: "Media/wpn_laser_disruptor_unchecked.png")
                } else {
                    snMenuWpnLaserDisruptor.texture = SKTexture(imageNamed: "Media/wpn_laser_disruptor_unequipped.png")
                }
            }
        case 3: // disruptor
            if (GameData.iAchieved & (1<<2) == (1<<2)) {
                snMenuWpnLaserDisruptor.texture = SKTexture(imageNamed: "Media/wpn_laser_disruptor_checked.png")
                snMenuWpnLaser.texture = SKTexture(imageNamed: "Media/wpn_laser_unchecked.png")
            }
            if blLaserSpherePickedUp == true {
                snMenuWpnLaserSphere.texture = SKTexture(imageNamed: "Media/wpn_laser_sphere_unchecked.png")
            } else {
                snMenuWpnLaserSphere.texture = SKTexture(imageNamed: "Media/wpn_laser_sphere_unequipped.png")
            }
            if blLaserConePickedUp == true {
                snMenuWpnLaserCone.texture = SKTexture(imageNamed: "Media/wpn_laser_cone_unchecked.png")
            } else {
                snMenuWpnLaserCone.texture = SKTexture(imageNamed: "Media/wpn_laser_cone_unequipped.png")
            }
        default:
            ()
        }
    }
}
