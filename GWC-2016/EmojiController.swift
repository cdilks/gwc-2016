//
//  EmojiController.swift
//  GWC-2016
//
//  Created by Joyce Van Drost on 7/20/16.
//  Copyright © 2016 Daily Burn. All rights reserved.
//

import UIKit

var mood: String = ""

class EmojiController: UIViewController {
    
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var fearButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var madButton: UIButton!
    @IBOutlet weak var surprisedButton: UIButton!
    
    func getMood() -> String{
        return mood
    }
    
    func happyButtonClicked(sender: UIButton){
        mood = "happy"
    }
    
    func sadButtonClicked(sender: UIButton){
        mood = "sad"
    }
    
    func madButtonClicked(sender: UIButton){
        mood = "mad"
    }
    
    func fearButtonClicked(sender: UIButton){
        mood = "fear"
    }
    
    func neutralButtonClicked(sender: UIButton){
        mood = "bored"
    }
    
    func surprisedButtonClicked(sender: UIButton){
        mood = "surprised"
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
