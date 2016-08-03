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

class LastPage: UIViewController {
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var done: UILabel!

    var gifView: FLAnimatedImageView = FLAnimatedImageView()
    var gifs: [String] = []
    var index: Int = 0
    let emoji: EmojiController = EmojiController()

     func nextButtonTouched(sender: UIButton) {
        if (index + 1 < gifs.count) {
            index = index + 1
            self.getImage(index)
            print(index)
        } else {
            print("reached all images")
            self.done.text = "You've reached all the GIFs!"
        }
    }

    func backButtonTouched(sender:UIButton) {
        if (index - 1 >= 0){
            index = index - 1
            print(index)
            self.getImage(index);
        } else {
            self.done.text = "You're at the beginning!"
        }
    }

    func getImage(index: Int) {
        self.done.text = "You are " + emoji.getEmotion()
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
                        for _ in 1...60 {
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

    func initNextButton(){
        next.addTarget(self, action: #selector(LastPage.nextButtonTouched(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        next.backgroundColor = UIColor.init(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        next.layer.cornerRadius = 25
        next.titleLabel!.font = UIFont(name: "Heiti SC", size: 20)
        next.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }

    func initBackButton(){

        back.addTarget(self, action: #selector(LastPage.backButtonTouched(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //next.backgroundColor = UIColor.lightGrayColor()
        back.backgroundColor = UIColor.init(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        back.layer.cornerRadius = 25
        back.titleLabel!.font = UIFont(name: "Heiti SC", size: 20)
        back.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = emoji.getColor()
        self.done.font = UIFont(name: "AppleGothic", size: 20)
        self.done.backgroundColor = UIColor.clearColor()
        self.initNextButton()
        self.initBackButton()
        self.gifView.frame = CGRectMake(40.0, 200.0, 300.0, 200.0)
        self.gifView.constraints
        self.view.addSubview(gifView)
        print(emoji.getMood())
        self.getGIF(mood)
        //self.getGIF("happiness")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
