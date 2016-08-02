//
//  firstChoice.swift
//  GWC-2016
//
//  Created by Joyce Van Drost on 8/2/16.
//  Copyright © 2016 Daily Burn. All rights reserved.
//

import UIKit

class firstChoice: UIViewController {

    @IBOutlet weak var faceButton: UIButton!
    @IBOutlet weak var emojiButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceButton.layer.cornerRadius = 30
        emojiButton.layer.cornerRadius = 30
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
