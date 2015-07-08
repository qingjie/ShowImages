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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadObj()
    }
    
    func loadObj(){
        view.backgroundColor = UIColor(patternImage: UIImage(named: imageFile)!)
        
        let lable = UILabel(frame: CGRectMake(0, 0, view.frame.width, 200))
        lable.textColor = UIColor.whiteColor()
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
    }
    
}























