//
//  TLGameMenuOptions.swift
//  iOS_Game_003
//
//  Created by Alexander Wegner on 07.07.16.
//  Copyright © 2016 Alexander Wegner. All rights reserved.
//

import SpriteKit
import AVFoundation

class TLGameMenuOptions: SKScene, SKPhysicsContactDelegate, UITextFieldDelegate {
    var lbMenuOptions: SKLabelNode!
    var lbOptName: SKLabelNode!
    var lbOptMusic: SKLabelNode!
    var lbOptSounds: SKLabelNode!
    var snOptName: SKSpriteNode!
    var snMenuOptions: SKSpriteNode!
    var snMenuBack: SKSpriteNode!
    var snOptMusicCheckbox: SKSpriteNode!
    var snOptMusicSliderBody: SKSpriteNode!
    var snOptMusicSliderKnob: SKSpriteNode!
    var snOptSoundsCheckbox: SKSpriteNode!
    var snOptSoundsSliderBody: SKSpriteNode!
    var snOptSoundsSliderKnob: SKSpriteNode!
    var iButtonPressed: Int!
    var apClick: AVAudioPlayer!
    var tfPlayerName: UITextField!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        self.anchorPoint = CGPointMake(0, 0)
        let txGameMenuBackgrd = SKTexture(imageNamed: "Media/gamemenu_003.png")
        
        let snGameMenuBackgrd = SKSpriteNode(texture: txGameMenuBackgrd, color: UIColor.clearColor(), size: CGSizeMake(self.frame.width, self.frame.height))
        snGameMenuBackgrd.anchorPoint = CGPointMake(0.5, 0.5)
        snGameMenuBackgrd.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        snGameMenuBackgrd.zPosition = 1.0
        snGameMenuBackgrd.alpha = 1.0
        addChild(snGameMenuBackgrd)
        // Setup
        iButtonPressed = 0
        
        // Menu sprite size
        let flMenuSpriteWidth = (SKTexture(imageNamed: "Media/menu_headline.png").size().width) * (self.frame.width/667.0)
        let flMenuSpriteHeight = (SKTexture(imageNamed: "Media/menu_headline.png").size().height) * (self.frame.height/375.0)
        let flMenuBackSpriteWidth = (SKTexture(imageNamed: "Media/menu_back.png").size().width) * (self.frame.width/667.0)
        let flMenuBackSpriteHeight = (SKTexture(imageNamed: "Media/menu_back.png").size().height) * (self.frame.height/375.0)
        let flOptCheckboxWidth = (SKTexture(imageNamed: "Media/checkbox_checked.png").size().width) * (self.frame.width/667.0)
        let flOptCheckboxHeight = (SKTexture(imageNamed: "Media/checkbox_checked.png").size().height) * (self.frame.height/375.0)
        let flOptSliderBodyWidth = (SKTexture(imageNamed: "Media/slider_body.png").size().width) * (self.frame.width/667.0)
        let flOptSliderBodyHeight = (SKTexture(imageNamed: "Media/slider_body.png").size().height) * (self.frame.height/375.0)
        let flOptSliderKnobWidth = (SKTexture(imageNamed: "Media/slider_knob.png").size().width) * (self.frame.width/667.0)
        let flOptSliderKnobHeight = (SKTexture(imageNamed: "Media/slider_knob.png").size().height) * (self.frame.height/375.0)
        // +-----------------+
        // |   Player name   |
        // +-----------------+
        // Menu "Name" Sprite
        snOptName = SKSpriteNode(texture: SKTexture(imageNamed: "Media/menu_middle.png"), color: UIColor.clearColor(), size: CGSizeMake(flMenuSpriteWidth, flMenuSpriteHeight))
        snOptName.anchorPoint = CGPointMake(1.0, 0.5)
        snOptName.position = CGPoint(x: 15*(self.frame.width / 16), y: 6*(self.frame.height / 12))
        snOptName.zPosition = 1.0
        snOptName.alpha = 1.0
        snOptName.name = "MenuName"
        self.addChild(snOptName)
        // Menu "Name" Text
        lbOptName = SKLabelNode(fontNamed: fnGameFont?.fontName)
        lbOptName.horizontalAlignmentMode = .Left
        lbOptName.verticalAlignmentMode = .Center
        lbOptName.text = "NAME"
        lbOptName.fontSize = 35 * (self.frame.width/667.0)
        lbOptName.position = CGPoint(x: 1*(self.frame.width / 16), y: 6*(self.frame.height / 12))
        lbOptName.fontColor = UIColor.whiteColor()
        lbOptName.zPosition = 1.0
        lbOptName.name = "OptName"
        self.addChild(lbOptName)
        // Menu "Name" textfield
        tfPlayerName = UITextField(frame: CGRectMake(15*(self.frame.width / 16) - flMenuSpriteWidth, 6*(self.frame.height / 12) - (flMenuSpriteHeight / 2), flMenuSpriteWidth, flMenuSpriteHeight))
        tfPlayerName.delegate = self
        tfPlayerName.borderStyle = UITextBorderStyle.None
        tfPlayerName.textColor = SKColor.whiteColor()
        tfPlayerName.placeholder = ""
        tfPlayerName.backgroundColor = SKColor.clearColor()
        tfPlayerName.tintColor = SKColor.whiteColor()
        tfPlayerName.autocorrectionType = UITextAutocorrectionType.No
        tfPlayerName.font = UIFont(name: fnGameTextFont!.fontName, size: 30 * (self.frame.width/667.0))
        tfPlayerName.text = GameData.strPlayerName
        tfPlayerName.textAlignment = .Center
        tfPlayerName.contentVerticalAlignment = .Center
        tfPlayerName.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.view!.addSubview(tfPlayerName)
        // Menu "Options" Sprite
        snMenuOptions = SKSpriteNode(texture: SKTexture(imageNamed: "Media/menu_headline.png"), color: UIColor.clearColor(), size: CGSizeMake(flMenuSpriteWidth, flMenuSpriteHeight))
        snMenuOptions.anchorPoint = CGPointMake(1.0, 0.5)
        snMenuOptions.position = CGPoint(x: 15*(self.frame.width / 16), y: 10*(self.frame.height / 12))
        snMenuOptions.zPosition = 1.0
        snMenuOptions.alpha = 1.0
        snMenuOptions.name = "MenuOptions"
        addChild(snMenuOptions)
        // Menu "Options" Text
        lbMenuOptions = SKLabelNode(fontNamed: fnGameFont?.fontName)
        lbMenuOptions.horizontalAlignmentMode = .Center
        lbMenuOptions.verticalAlignmentMode = .Center
        lbMenuOptions.text = "OPTIONS"
        lbMenuOptions.fontSize = 30 * (self.frame.width/667.0)
        lbMenuOptions.position = CGPoint(x: CGRectGetMidX(snMenuOptions.frame), y: 10*(self.frame.height / 12))
        lbMenuOptions.fontColor = UIColor.whiteColor()
        lbMenuOptions.zPosition = 1.0
        lbMenuOptions.name = "MenuOptions"
        self.addChild(lbMenuOptions)
        // Menu "Back" Sprite
        snMenuBack = SKSpriteNode(texture: SKTexture(imageNamed: "Media/menu_back.png"), color: UIColor.clearColor(), size: CGSizeMake(flMenuBackSpriteWidth, flMenuBackSpriteHeight))
        snMenuBack.anchorPoint = CGPointMake(0.0, 0.5)
        snMenuBack.position = CGPoint(x: 1*(self.frame.width / 16), y: 10*(self.frame.height / 12))
        snMenuBack.zPosition = 1.0
        snMenuBack.alpha = 1.0
        snMenuBack.name = "MenuBack"
        self.addChild(snMenuBack)
        // --- Sounds: Click ---
        let path = NSBundle.mainBundle().pathForResource("Media/sounds/click_001", ofType:"wav")
        let fileURL = NSURL(fileURLWithPath: path!)
        do {
            try apClick = AVAudioPlayer(contentsOfURL: fileURL, fileTypeHint: nil)
        } catch {
            print("Could not create audio player: \(error)")
            return
        }
        apClick.numberOfLoops = 0
        // --- Music ---
        // "Music" Text
        lbOptMusic = SKLabelNode(fontNamed: fnGameFont?.fontName)
        lbOptMusic.horizontalAlignmentMode = .Left
        lbOptMusic.verticalAlignmentMode = .Center
        lbOptMusic.text = "MUSIC"
        lbOptMusic.fontSize = 35 * (self.frame.width/667.0)
        lbOptMusic.position = CGPoint(x: 1*(self.frame.width / 16), y: 4*(self.frame.height / 12))
        lbOptMusic.fontColor = UIColor.whiteColor()
        lbOptMusic.zPosition = 1.0
        lbOptMusic.name = "OptMusic"
        self.addChild(lbOptMusic)
        // "Music" Checkbox
        snOptMusicCheckbox = SKSpriteNode(texture: SKTexture(imageNamed: "Media/checkbox_checked.png"), color: UIColor.clearColor(), size: CGSizeMake(flOptCheckboxWidth, flOptCheckboxHeight))
        snOptMusicCheckbox.anchorPoint = CGPointMake(0.0, 0.5)
        snOptMusicCheckbox.position = CGPoint(x: 6*(self.frame.width / 16), y: 4*(self.frame.height / 12))
        snOptMusicCheckbox.zPosition = 1.0
        snOptMusicCheckbox.alpha = 1.0
        snOptMusicCheckbox.name = "OptMusicCheckbox"
        self.addChild(snOptMusicCheckbox)
        if GameData.blMusicEnabled == true {
            snOptMusicCheckbox.texture = SKTexture(imageNamed: "Media/checkbox_checked.png")
        } else {
            snOptMusicCheckbox.texture = SKTexture(imageNamed: "Media/checkbox_unchecked.png")
        }
        // "Music" Slider body
        snOptMusicSliderBody = SKSpriteNode(texture: SKTexture(imageNamed: "Media/slider_body.png"), color: UIColor.clearColor(), size: CGSizeMake(flOptSliderBodyWidth, flOptSliderBodyHeight))
        snOptMusicSliderBody.anchorPoint = CGPointMake(1.0, 0.5)
        snOptMusicSliderBody.position = CGPoint(x: 15*(self.frame.width / 16), y: 4*(self.frame.height / 12))
        snOptMusicSliderBody.zPosition = 1.0
        snOptMusicSliderBody.alpha = 1.0
        snOptMusicSliderBody.name = "OptMusicSliderBody"
        self.addChild(snOptMusicSliderBody)
        // "Music" Slider knob
        snOptMusicSliderKnob = SKSpriteNode(texture: SKTexture(imageNamed: "Media/slider_knob.png"), color: UIColor.clearColor(), size: CGSizeMake(flOptSliderKnobWidth, flOptSliderKnobHeight))
        snOptMusicSliderKnob.anchorPoint = CGPointMake(0.5, 0.5)
        snOptMusicSliderKnob.position = CGPoint(x: (15*(self.frame.width / 16)  - snOptMusicSliderBody.frame.size.width), y: (4*(self.frame.height / 12)))
        snOptMusicSliderKnob.zPosition = 1.0
        snOptMusicSliderKnob.alpha = 1.0
        snOptMusicSliderKnob.name = "OptMusicSliderKnob"
        self.addChild(snOptMusicSliderKnob)
        let flOptMusicSliderKnobPos = (((snOptMusicSliderBody.frame.size.width - snOptMusicSliderKnob.frame.size.width) / 100.0) * CGFloat(GameData.flMusicVolume * 100.0)) + (snOptMusicSliderKnob.frame.size.width / 2)
        snOptMusicSliderKnob.position = CGPoint(x: (15*(self.frame.width / 16) - snOptMusicSliderBody.frame.size.width + flOptMusicSliderKnobPos), y: (4 * (self.frame.height / 12)))
        // +------------+
        // |   Sounds   |
        // +------------+
        // "Sounds" Text
        lbOptSounds = SKLabelNode(fontNamed: fnGameFont?.fontName)
        lbOptSounds.horizontalAlignmentMode = .Left
        lbOptSounds.verticalAlignmentMode = .Center
        lbOptSounds.text = "SOUNDS"
        lbOptSounds.fontSize = 35 * (self.frame.width/667.0)
        lbOptSounds.position = CGPoint(x: 1*(self.frame.width / 16), y: 2*(self.frame.height / 12))
        lbOptSounds.fontColor = UIColor.whiteColor()
        lbOptSounds.zPosition = 1.0
        lbOptSounds.name = "OptSounds"
        self.addChild(lbOptSounds)
        // "Sounds" Checkbox
        snOptSoundsCheckbox = SKSpriteNode(texture: SKTexture(imageNamed: "Media/checkbox_checked.png"), color: UIColor.clearColor(), size: CGSizeMake(flOptCheckboxWidth, flOptCheckboxHeight))
        snOptSoundsCheckbox.anchorPoint = CGPointMake(0.0, 0.5)
        snOptSoundsCheckbox.position = CGPoint(x: 6*(self.frame.width / 16), y: 2*(self.frame.height / 12))
        snOptSoundsCheckbox.zPosition = 1.0
        snOptSoundsCheckbox.alpha = 1.0
        snOptSoundsCheckbox.name = "OptSoundsCheckbox"
        self.addChild(snOptSoundsCheckbox)
        if GameData.blSoundEffectsEnabled == true {
            snOptSoundsCheckbox.texture = SKTexture(imageNamed: "Media/checkbox_checked.png")
        } else {
            snOptSoundsCheckbox.texture = SKTexture(imageNamed: "Media/checkbox_unchecked.png")
        }
        // "Sounds" Slider body
        snOptSoundsSliderBody = SKSpriteNode(texture: SKTexture(imageNamed: "Media/slider_body.png"), color: UIColor.clearColor(), size: CGSizeMake(flOptSliderBodyWidth, flOptSliderBodyHeight))
        snOptSoundsSliderBody.anchorPoint = CGPointMake(1.0, 0.5)
        snOptSoundsSliderBody.position = CGPoint(x: 15*(self.frame.width / 16), y: 2*(self.frame.height / 12))
        snOptSoundsSliderBody.zPosition = 1.0
        snOptSoundsSliderBody.alpha = 1.0
        snOptSoundsSliderBody.name = "OptSoundsSliderBody"
        self.addChild(snOptSoundsSliderBody)
        // "Sounds" Slider knob
        snOptSoundsSliderKnob = SKSpriteNode(texture: SKTexture(imageNamed: "Media/slider_knob.png"), color: UIColor.clearColor(), size: CGSizeMake(flOptSliderKnobWidth, flOptSliderKnobHeight))
        snOptSoundsSliderKnob.anchorPoint = CGPointMake(0.5, 0.5)
        snOptSoundsSliderKnob.position = CGPoint(x: (15*(self.frame.width / 16)  - snOptSoundsSliderBody.frame.size.width), y: (2*(self.frame.height / 12)))
        snOptSoundsSliderKnob.zPosition = 1.0
        snOptSoundsSliderKnob.alpha = 1.0
        snOptSoundsSliderKnob.name = "OptSoundsSliderKnob"
        self.addChild(snOptSoundsSliderKnob)
        let flOptSoundsSliderKnobPos = (((snOptSoundsSliderBody.frame.size.width - snOptSoundsSliderKnob.frame.size.width) / 100.0) * CGFloat(GameData.flSoundsVolume * 100.0))
        snOptSoundsSliderKnob.position = CGPoint(x: (15*(self.frame.width / 16) - snOptSoundsSliderBody.frame.size.width + flOptSoundsSliderKnobPos + (snOptSoundsSliderKnob.frame.size.width / 2)), y: (2*(self.frame.height / 12)))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        if let location = touches.first?.locationInNode(self) {
            let touchedNode = nodeAtPoint(location)
            
            switch (touchedNode.name) {
            case "MenuBack"?:
                snMenuBack.texture = SKTexture(imageNamed: "Media/menu_back_pressed.png")
                iButtonPressed = 1
                fctPlayClickSound()
            case "OptMusicCheckbox"?:
                iButtonPressed = 2
                fctPlayClickSound()
            case "OptSoundsCheckbox"?:
                iButtonPressed = 3
                fctPlayClickSound()
            case "OptMusicSliderKnob"?:
                iButtonPressed = 4
            case "OptSoundsSliderKnob"?:
                iButtonPressed = 5
            default:
                ()
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if iButtonPressed == 4 {
            for touch in touches {
                let flOptMusicSliderKnobMin = 15*(self.frame.width / 16) - snOptMusicSliderBody.frame.size.width + (snOptMusicSliderKnob.frame.size.width / 2)
                let flOptMusicSliderKnobMax = 15*(self.frame.width / 16) - (snOptMusicSliderKnob.frame.size.width / 2)
                
                if (touch.locationInView(view).x >= flOptMusicSliderKnobMin) && (touch.locationInView(view).x <= flOptMusicSliderKnobMax) {
                    snOptMusicSliderKnob.position = CGPoint(x: touch.locationInView(view).x, y: snOptMusicSliderKnob.position.y)
                    GameData.flMusicVolume = Float(snOptMusicSliderKnob.position.x - (snOptMusicSliderBody.position.x - snOptMusicSliderBody.frame.size.width))
                    GameData.flMusicVolume = GameData.flMusicVolume - Float(snOptMusicSliderKnob.frame.size.width / 2.0)
                    GameData.flMusicVolume = GameData.flMusicVolume / Float(snOptMusicSliderBody.frame.size.width - snOptMusicSliderKnob.frame.size.width)
                    //print(GameData.flMusicVolume) // #debug
                }
                if touch.locationInView(view).x < flOptMusicSliderKnobMin {
                    snOptMusicSliderKnob.position = CGPoint(x: flOptMusicSliderKnobMin, y: snOptMusicSliderKnob.position.y)
                    GameData.flMusicVolume = 0.0
                    //print(GameData.flMusicVolume) // #debug
                }
                if touch.locationInView(view).x > flOptMusicSliderKnobMax {
                    snOptMusicSliderKnob.position = CGPoint(x: flOptMusicSliderKnobMax, y: snOptMusicSliderKnob.position.y)
                    GameData.flMusicVolume = 1.0
                    //print(GameData.flMusicVolume) // #debug
                }
                if blGameStarted == true {
                    if gzGame.apBackgroundMusic != nil {
                     gzGame.apBackgroundMusic.volume = GameData.flMusicVolume
                    }
                }
            }
        }
        if iButtonPressed == 5 {
            for touch in touches {
                let flOptSoundsSliderKnobMin = 15*(self.frame.width / 16) - snOptSoundsSliderBody.frame.size.width + (snOptSoundsSliderKnob.frame.size.width / 2)
                let flOptSoundsSliderKnobMax = 15*(self.frame.width / 16) - (snOptSoundsSliderKnob.frame.size.width / 2)
                
                if (touch.locationInView(view).x >= flOptSoundsSliderKnobMin) && (touch.locationInView(view).x <= flOptSoundsSliderKnobMax) {
                    snOptSoundsSliderKnob.position = CGPoint(x: touch.locationInView(view).x, y: snOptSoundsSliderKnob.position.y)
                    GameData.flSoundsVolume = Float(snOptSoundsSliderKnob.position.x - (snOptSoundsSliderBody.position.x - snOptSoundsSliderBody.frame.size.width))
                    GameData.flSoundsVolume = GameData.flSoundsVolume - Float(snOptSoundsSliderKnob.frame.size.width / 2.0)
                    GameData.flSoundsVolume = GameData.flSoundsVolume / Float(snOptSoundsSliderBody.frame.size.width - snOptSoundsSliderKnob.frame.size.width)
                    //print(GameData.flSoundsVolume)  // #debug
                }
                if touch.locationInView(view).x < flOptSoundsSliderKnobMin {
                    snOptSoundsSliderKnob.position = CGPoint(x: flOptSoundsSliderKnobMin, y: snOptSoundsSliderKnob.position.y)
                    GameData.flSoundsVolume = 0.0
                    //print(GameData.flSoundsVolume) // #debug
                }
                if touch.locationInView(view).x > flOptSoundsSliderKnobMax {
                    snOptSoundsSliderKnob.position = CGPoint(x: flOptSoundsSliderKnobMax, y: snOptSoundsSliderKnob.position.y)
                    GameData.flSoundsVolume = 1.0
                    //print(GameData.flSoundsVolume) // #debug
                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        // Reset pressed sprites
        snMenuBack.texture = SKTexture(imageNamed: "Media/menu_back.png")
        // Screen elements
        if let location = touches.first?.locationInNode(self) {
            let touchedNode = nodeAtPoint(location)
            
            switch (touchedNode.name) {
            case "MenuBack"?:
                if iButtonPressed == 1 {
                    GameData.strPlayerName = tfPlayerName.text!
                    fctSaveGameData()
                    tfPlayerName.removeFromSuperview()
                    let transition = SKTransition.fadeWithColor(.blackColor(), duration: 0.2)
                    
                    if blGameStarted == false {
                        let nextScene = TLGameMenu(size: scene!.size)
                        nextScene.scaleMode = .AspectFill
                        scene?.view?.presentScene(nextScene, transition: transition)
                    } else {
                        let nextScene = gzGame
                        nextScene.scaleMode = .AspectFill
                        scene?.view?.presentScene(nextScene, transition: transition)
                    }
                    
                    //self.view?.presentScene(nil)
                }
            case "OptMusicCheckbox"?:
                if iButtonPressed == 2 {
                    if GameData.blMusicEnabled == true {
                        GameData.blMusicEnabled = false
                        snOptMusicCheckbox.texture = SKTexture(imageNamed: "Media/checkbox_unchecked.png")
                    } else {
                        GameData.blMusicEnabled = true
                        snOptMusicCheckbox.texture = SKTexture(imageNamed: "Media/checkbox_checked.png")
                    }
                    if blGameStarted == true {
                        gzGame.fctPlayBackgroundMusic()
                    }
                }
            case "OptSoundsCheckbox"?:
                if iButtonPressed == 3 {
                    if GameData.blSoundEffectsEnabled == true {
                        GameData.blSoundEffectsEnabled = false
                        snOptSoundsCheckbox.texture = SKTexture(imageNamed: "Media/checkbox_unchecked.png")
                    } else {
                        GameData.blSoundEffectsEnabled = true
                        snOptSoundsCheckbox.texture = SKTexture(imageNamed: "Media/checkbox_checked.png")
                    }
                }
            default:
                ()
            }
        }
        snMenuBack.texture = SKTexture(imageNamed: "Media/menu_back.png")
        iButtonPressed = 0
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
    
    func fctPlayClickSound() {
        if GameData.blSoundEffectsEnabled == true {
            apClick.volume = GameData.flSoundsVolume
            apClick.prepareToPlay()
            apClick.play()
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 10
        let currentString: NSString! = textField.text
        let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        GameData.strPlayerName = tfPlayerName.text!
        tfPlayerName.resignFirstResponder()
        return true
    }
    
    func fctSaveGameData () {
        // Save Data
        SDGameData.strPlayerName = GameData.strPlayerName
        SDGameData.blSoundEffectsEnabled = GameData.blSoundEffectsEnabled
        SDGameData.blMusicEnabled = GameData.blMusicEnabled
        SDGameData.flSoundsVolume = GameData.flSoundsVolume
        SDGameData.flMusicVolume = GameData.flMusicVolume
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(SDGameData, toFile: TLSaveData.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        } else {
            print("Player name successfully saved")
        }
    }
}

