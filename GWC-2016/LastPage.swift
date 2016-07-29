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

class LastPage: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var next: UIButton!
    var gifs: [String] = []
    var index: Int = 1
    
     func buttonTouched(sender: UIButton) {
        if (index < gifs.count){
            self.getImage(index)
            index = index + 1
            print(index)
        } else {
            print("reached all images")
        }
    }
    
    func getGIF(emotion: String){
        let parameters = [
                "api_key": "dc6zaTOxFJmzC",
                "q": emotion,
                "rating" : "pg-13",
                "limit" : 100
        ]
        Alamofire.Manager.sharedInstance.request(.GET, "http://api.giphy.com/v1/gifs/search",
                parameters: parameters as? [String : AnyObject],
                encoding: .URL)
                .responseJSON{response in
                    if let JSON = response.result.value {
                        for _ in 0...49 {
                            var done: DarwinBoolean = false
                            while done == false{
                                let random = Int(arc4random_uniform(100));
                                print(random)
                                let link = JSON["data"]!![random]["images"]!!["downsized"]!!["url"] as! String
                                if (!self.gifs.contains(link)){
                                    self.gifs.append(link)
                                    print(link)
                                    done = true
                                }
                            }
                        }
                    }
                    print(self.gifs.count)
                    self.getImage(0)
                }
        }
    
    func getImage(index: Int){
        let link = self.gifs[index]
        let imageGIF: FLAnimatedImage = FLAnimatedImage.init(animatedGIFData: NSData(contentsOfURL: NSURL(string: link)!)!)
        let gifView: FLAnimatedImageView = FLAnimatedImageView()
        gifView.animatedImage = imageGIF
        gifView.frame = CGRectMake(50.0, 200.0, 300.0, 200.0)
        self.view.addSubview(gifView)
    }
    
    override func viewDidLoad() {
        let emoji: EmojiController = EmojiController()
        super.viewDidLoad()
        next.addTarget(self, action: #selector(LastPage.buttonTouched(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.getGIF(emoji.getMood())
        print(emoji.getMood())
        //self.getGIF("happiness")
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}