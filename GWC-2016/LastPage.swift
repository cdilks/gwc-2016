//
//  LastPage.swift
//  GWC-2016
//
//  Created by Wu, Mendy on 7/28/16.
//  Copyright © 2016 Daily Burn. All rights reserved.
//

import UIKit
import Alamofire
import FLAnimatedImage

//back button
//

class LastPage: UIViewController {
    @IBOutlet weak var done: UITextView!
    @IBOutlet weak var next: UIButton!
    var gifView: FLAnimatedImageView = FLAnimatedImageView()
    var gifs: [String] = []
    var index: Int = 1
    let emoji: EmojiController = EmojiController()
    
     func nextButtonTouched(sender: UIButton) {
        if (index < gifs.count) {
            self.getImage(index)
            index = index + 1
            print(index)
        } else {
            print("reached all images")
            self.done.text = "You've reached all the GIFs!"
        }
    }
    
    func getImage(index: Int) {
        let link = self.gifs[index]
        let imageGIF: FLAnimatedImage = FLAnimatedImage.init(animatedGIFData: NSData(contentsOfURL: NSURL(string: link)!)!)
        self.gifView.animatedImage = imageGIF
    }
    
    func getGIF(emotion: String) {
        self.done.text = "You are " + emoji.getEmotion()
        let parameters = [
                "api_key": "dc6zaTOxFJmzC",
                "q": emotion,
                "rating" : "pg",
                "limit" : 100
        ]
        Alamofire.Manager.sharedInstance.request(.GET, "http://api.giphy.com/v1/gifs/search",
                parameters: parameters as? [String : AnyObject],
                encoding: .URL)
                .responseJSON{response in
                    if let JSON = response.result.value {
                        self.gifs.removeAll()
                        for _ in 1...4
                        {
                            var added: DarwinBoolean = false
                            while added == false {
                                let random = Int(arc4random_uniform(100));
                                //print(random)
                                let link = JSON["data"]!![random]["images"]!!["downsized"]!!["url"] as! String
                                if (!self.gifs.contains(link)) {
                                    self.gifs.append(link)
                                    print(link)
                                    added = true
                                }
                            }
                        }
                    }
                    self.getImage(0)
                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = emoji.getColor()
        self.done.font = UIFont(name: "AppleGothic", size: 20)
        self.done.backgroundColor = UIColor.clearColor()
        next.addTarget(self, action: #selector(LastPage.nextButtonTouched(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //next.backgroundColor = UIColor.lightGrayColor()
        next.backgroundColor = UIColor.init(red: 104.0/255.0, green: 157.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        next.layer.cornerRadius = 30
        next.titleLabel!.font = UIFont(name: "Heiti SC", size: 20)
        next.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.gifView.frame = CGRectMake(40.0, 200.0, 300.0, 200.0)
        self.view.addSubview(gifView)
        print(emoji.getMood())
        self.getGIF(emoji.getMood())
        //self.getGIF("happiness")
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}