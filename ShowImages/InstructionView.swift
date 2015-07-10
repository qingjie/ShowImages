//
//  InstructionView.swift
//  ShowImages
//
//  Created by qingjiezhao on 7/4/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//

import UIKit

class InstructionView: UIViewController {
    var pageIndex : Int = 0
    var titleText : String = ""
    var imageFile : String = ""
    var imageCache = [String:UIImage]()
    //let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    //let screenSize:CGRect = UIScreen.mainScreen().bounds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadObj()
    }
    
    
    func loadObj(){
//        spinner.center = CGPoint(x: view.center.x, y: view.center.y - view.bounds.origin.y / 2.0)
//        self.view.addSubview(spinner)
//        spinner.stopAnimating()
//        spinner.startAnimating()
        
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "page1.png")!)
        
        // If this image is already cached, don't re-download
        if let img = imageCache[imageFile] {
            //cell.imageView?.image = img
            view.backgroundColor = UIColor(patternImage: img)
        }
        else {
            // The image isn't cached, download the img data
            // We should perform this in a background thread
            
            var imgURL: NSURL = NSURL(string: imageFile)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            let mainQueue = NSOperationQueue.mainQueue()
            
            NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
                
                println(response)
             
                if error == nil {
                    // Convert the downloaded data in to a UIImage object
                    let image = UIImage(data: data)
                    
                    //set image size
                    var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size of iPhone
                    let imageObj:UIImage! =   self.imageResize(image!, sizeChange: CGSizeMake(mainScreenSize.width, mainScreenSize.height))
                    
                    // Store the image in to our cache
                    self.imageCache[self.imageFile] = imageObj
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        //Update.imageView?.image = image
                        
                        self.view.backgroundColor = UIColor(patternImage: imageObj!)
                    })
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
//            spinner.stopAnimating()
//            spinner.hidesWhenStopped = true
            
        }
        
        //view.backgroundColor = UIColor(patternImage: UIImage(named: imageFile)!)
        let lable = UILabel(frame: CGRectMake(0, 0, view.frame.width , 200))
        lable.textColor = UIColor.orangeColor()
        lable.text = titleText
        lable.textAlignment = .Center
        self.view.addSubview(lable)
        
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(20, view.frame.height - 110, view.frame.width - 40, 50)
        button.backgroundColor = UIColor(red: 138/255.0, green: 181/255.0, blue: 91/255.0, alpha: 1)
        button.setTitle(titleText, forState: UIControlState.Normal)
        button.addTarget(self, action: "Action:", forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
    }
    
    @IBAction func Action(sender: AnyObject) {
        println("123")
    }
    
    func imageResize (imageObj:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = false
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
}













