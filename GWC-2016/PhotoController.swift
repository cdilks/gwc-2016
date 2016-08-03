//
//  PhotoController.swift
//  GWC-2016
//
//  Created by Joyce Van Drost on 7/20/16.
//  Copyright © 2016 Daily Burn. All rights reserved.
//

import UIKit
import Alamofire

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraAccess: UIButton!
    @IBOutlet weak var photoLibrary: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    let picker = UIImagePickerController()
    var pickedImagePath: NSURL?
    var pickedImageData: NSData?
    var localPath: String?
    
    @IBAction func cameraAccessAction(sender: UIButton) {
        picker.delegate = self
        picker.sourceType = .Camera
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func photoLibraryAction(sender: UIButton) {
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func submitPhoto(sender: UIButton) {
        guard let path = localPath else {
            return
        }
    
        getEmotions(pickedImageData!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.allowsEditing = false
        submitButton.addTarget(self, action: #selector(PhotoController.submitPhoto(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard var image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        image = self.imageWithImage(image, scaledToSize: CGSize(width: 300, height: 500))
        imgView.image = image

        pickedImageData = UIImagePNGRepresentation(imgView.image!)
        
        let documentDirectory: NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        
        let imageName = "temp"
        let imagePath = documentDirectory.stringByAppendingPathComponent(imageName)
        
        if let data = UIImageJPEGRepresentation(image, 80) {
            data.writeToFile(imagePath, atomically: true)
        }
        
        localPath = imagePath
        
        dismissViewControllerAnimated(true, completion: {
            
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    var emotions: [String] = ["anger", "contempt", "disgust", "fear", "happiness", "neutral", "sadness", "surprise"]
    var numbers: [Float] = []
    
    func getEmotions(imageData: NSData) {
        var detectedEmotion: String = ""
        var detectedIndex: Int = -1
        var detectedLevel: Float = 0.0
        let headers = ["Content-Type": "application/octet-stream",
                       "Ocp-Apim-Subscription-Key": "af3e3e8332dd40a3ba68bc570855d368"]
        
        Alamofire.upload(.POST, "https://api.projectoxford.ai/emotion/v1.0/recognize", headers: headers, data: imageData)
            .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                print(totalBytesWritten)
                
                dispatch_async(dispatch_get_main_queue()) {
                    //print("Total bytes written on main queue: \(totalBytesWritten)")
                }
            }
            .responseJSON { response in
                print(response)
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    if JSON.count! > 0 {
                        for a in 0..<8{
                            self.numbers.append(JSON[0]!["scores"]!![self.emotions[a]] as! Float)
                        }
                        var i: Int = 0
                        for num in self.numbers{
                            if num > detectedLevel {
                                detectedIndex = i
                                detectedLevel = num
                            }
                            i += 1
                        }
                        detectedEmotion = self.emotions[detectedIndex]
                        print(detectedEmotion)
                        if (detectedEmotion == "contempt"){
                            detectedEmotion = "angry"
                        }
                        if (detectedEmotion == "disgust"){
                            detectedEmotion = "angry"
                        }
                        processEmotion(detectedEmotion)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("lastpage") as! LastPage
                        
                        self.presentViewController(vc, animated: true, completion: {
                        })

                        
                    }
                    //self.processEmotion()
                    self.numbers.removeAll()
                    print("Success!")
                }
        }
    }
        
}