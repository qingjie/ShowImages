//
//  ViewController3.swift
//  ShowImages
//
//  Created by qingjiezhao on 7/3/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//


import UIKit

class ViewController3: UIViewController ,UIScrollViewDelegate{
    
    
    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    
    var textView:UITextView!
    let screenWidth = UIScreen.mainScreen().bounds.width;
    let screenHeight = UIScreen.mainScreen().bounds.height;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadScrollView()
        //        
        //        textview.scrollEnabled = NO;
        //
        
    }
    
    func loadScrollView(){
        
        self.view = self.scrollView
        
        
        
        loadTextView()
        

    }
    
    
    
    func loadTextView(){
        
        let textView : UITextField = UITextField(frame:CGRect(x:10, y:(screenHeight/2), width:(screenWidth-20), height: (screenHeight/3)))
        
        textView.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        textView.placeholder = NSLocalizedString("Start typing...", comment: "")
        textView.borderStyle = UITextBorderStyle.Line;
        //   textView.autocorrectionType = .Yes
        self.view.addSubview( textView )
        
    }
    
    
    func loadImage(){
        var imageViewObject :UIImageView
        
        imageViewObject = UIImageView(frame:CGRectMake(0, 100, 100, 100))
        
        imageViewObject.image = UIImage(named:"http://media.ruebarue.com/photos/places/4902239969738752/1-museum-of-fine-arts-1.jpg")
        
        self.view.addSubview(imageViewObject)

    }
}