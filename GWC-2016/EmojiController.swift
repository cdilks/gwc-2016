//
//  EmojiController.swift
//  GWC-2016
//
//  Created by Joyce Van Drost on 7/20/16.
//  Copyright © 2016 Daily Burn. All rights reserved.
//

import UIKit

var mood: String = ""
var emotion: String = ""
var color: UIColor = UIColor.init(red: 100.0/255.0, green: 160.0/255.0, blue: 255.0/255.0, alpha: 1.0)

class EmojiController: UIViewController {
    
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var fearButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var madButton: UIButton!
    @IBOutlet weak var surprisedButton: UIButton!
    var happy: [String] = ["happy", "happiness", "joy", "YAY"]
    var sad: [String] = ["sad", "lonely", "cheer up", "crying"]
    var fear: [String] = ["fear", "scared", "ahh", "fear"]
    var mad: [String] = ["mad", "angry", "grr", "frustrated"]
    var neutral: [String] = ["bored", "boring", "yawn", "bored"]
    var surprised: [String] = ["surprise", "whoa", "surprised", "speechless"]
    
    func getMood() -> String{
        return mood
    }
    
    func getColor() -> UIColor{
        return color
    }
    
    func getEmotion() -> String{
        return emotion
    }
    
    func processEmotion (theEmotion: String){
        let random = Int(arc4random_uniform(4));
        switch(theEmotion){
        case "happy":
            emotion = "happy"
            mood = happy[random]
            //color = UIColor.yellowColor()
        case "sad":
            emotion = "sad"
            mood = sad[random]
            //color = UIColor.cyanColor()
        case "mad":
            emotion = "mad"
            mood = mad[random]
            //color = UIColor.redColor()
        case "surprised":
            emotion = "surprised"
            mood = surprised[random]
            //color = UIColor.orangeColor()
        case "fear":
            emotion = "scared"
            mood = fear[random]
            //color = UIColor.lightGrayColor()
        case "neutral":
            emotion = "neutral"
            mood = neutral[random]
            //color = UIColor.whiteColor()
        default:
            print("Invalid emotion")
        }
    }
    
    func happyButtonClicked(sender: UIButton){
        self.processEmotion("happy")
    }
    func sadButtonClicked(sender: UIButton){
        self.processEmotion("sad")
    }
    
    func madButtonClicked(sender: UIButton){
        self.processEmotion("mad")
    }
    
    func fearButtonClicked(sender: UIButton){
        self.processEmotion("fear")
    }
    
    func neutralButtonClicked(sender: UIButton){
        self.processEmotion("neutral")
    }
    
    func surprisedButtonClicked(sender: UIButton){
        self.processEmotion("surprised")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        happyButton.addTarget(self, action: #selector(EmojiController.happyButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        sadButton.addTarget(self, action: #selector(EmojiController.sadButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        fearButton.addTarget(self, action: #selector(EmojiController.fearButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        neutralButton.addTarget(self, action: #selector(EmojiController.neutralButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        surprisedButton.addTarget(self, action: #selector(EmojiController.surprisedButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        madButton.addTarget(self, action: #selector(EmojiController.madButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
