//
//  ViewController1.swift
//  ShowImages
//
//  Created by qingjiezhao on 7/2/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//

import UIKit


class ViewController1: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var objects = [String : String]()
    var urlArray = [String]()
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.userInteractionEnabled = true
        scrollView.contentSize = CGSizeMake(320,900)
        
        loadData()
        //loadButton(dic)
    }

    
    
    func loadButton(){
        
//         for temp in urlArray {
//            println(temp)
//
//         }
        
        
        var arrayOfVillains = [
            
            "http://media.ruebarue.com/photos/places/4902239969738752/4-museum-of-fine-arts-4.jpg",
            "http://media.ruebarue.com/photos/places/4902239969738752/3-museum-of-fine-arts-3.jpg",
            "http://media.ruebarue.com/photos/places/4902239969738752/2-museum-of-fine-arts-2.jpg",
            "http://media.ruebarue.com/photos/places/4902239969738752/1-museum-of-fine-arts-1.jpg"]
        var buttonY : CGFloat = 3
        var labelY : CGFloat = 151
        var btnWidth : CGFloat = 183
        var btnHeight : CGFloat = 183
        var lblWidth : CGFloat = 183
        var lblHeight : CGFloat = 35
       
        
        //for var i = 0; i <= arrayOfVillains.count; i++ {
        for villain in arrayOfVillains {

            var imgURL: NSURL = NSURL(string: villain)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                var image = UIImage(data: data)

                let villainButton1 = UIButton(frame: CGRect(x: 3, y: buttonY, width: btnWidth, height: btnHeight))
                let villainButton2 = UIButton(frame: CGRect(x: 189, y: buttonY, width: btnWidth, height: btnHeight))
                let label1 = UILabel(frame: CGRect(x: 3, y: labelY, width: lblWidth, height: lblHeight))
                let label2 = UILabel(frame: CGRect(x: 189, y: labelY, width: lblWidth, height: lblHeight))
                
                UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                
                buttonY = buttonY + 186  // we are going to space these UIButtons 50px apart
                labelY = labelY + 186
                
                villainButton1.layer.cornerRadius = 10  // get some fancy pantsy rounding
                villainButton1.backgroundColor = UIColor.darkGrayColor()
                villainButton1.setTitle("Button1: \(villain)", forState: UIControlState.Normal) // We are going to use the item name as the Button Title here.
                villainButton1.setBackgroundImage(image, forState: .Normal)
                
                villainButton1.titleLabel?.text = "\(villain)"
                villainButton1.addTarget(self, action: "btnTouched:", forControlEvents: UIControlEvents.TouchUpInside)
                villainButton1.setImage(image, forState: .Normal)
                
                villainButton2.layer.cornerRadius = 10  // get some fancy pantsy rounding
                villainButton2.backgroundColor = UIColor.darkGrayColor()
                villainButton2.setTitle("Button2: \(villain)", forState: UIControlState.Normal) // We are going to use the item name as the Button Title here.
                villainButton2.titleLabel?.text = "\(villain)"
                
                villainButton2.addTarget(self, action: "btnTouched:", forControlEvents: UIControlEvents.TouchUpInside)
                villainButton2.setImage(image, forState: .Normal)
                
                
               
                label1.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
                label1.textColor = UIColor.whiteColor()
                label1.textAlignment = NSTextAlignment.Left
                label1.text = "Boston"
                
                label2.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
                label2.textColor = UIColor.whiteColor()
                label2.textAlignment = NSTextAlignment.Left
                label2.text = "Boston"
                
                
                self.scrollView.addSubview(villainButton1)  // myView in this case is the view you want these buttons added
                self.scrollView.addSubview(label1)
                
                
                self.scrollView.addSubview(villainButton2)  // myView in this case is the view you want these buttons added
                self.scrollView.addSubview(label2)
                
            })
            
            
        }
            
        
    }
    

    
     func btnTouched(sender: UIButton) {
        if sender.titleLabel?.text != nil {
            println("You have chosen Villain: \(sender.titleLabel?.text)")
        } else {
            
            println("Nowhere to go :/")
            
        }
    }
    
    
    
    
    
    
    func loadData(){
        
        var urlString : String = "http://www.ruebarue.com/api/place/4902239969738752"
        
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)) { [unowned self] in
            if let url = NSURL(string: urlString){
                if let data = NSData(contentsOfURL: url, options: .allZeros, error: nil){
                    //let json = JSON( data: data)
                    let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)! as! NSDictionary
                    self.parseJSON(json)
                }else{
                    self.showError()
                }
            }else{
                self.showError()
            }
        }

    }
    
    
    func showError(){
        dispatch_async(dispatch_get_main_queue()){ [unowned self] in
            let ac = UIAlertController(title: "Loading error", message: "It was a problem to loading,", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    func parseJSON(json : NSDictionary){
        
        for (key,value) in json as NSDictionary{
            var rank = json["rank"] as! NSInteger
            var slug = json["slug"] as! NSString
            var google = json["google"] as! NSDictionary
            var tripadvisor_id = json["tripadvisor_id"] as! NSString
            var tags = json["tags"] as! NSArray
            var place_type = json["place_type"] as! NSString
            var cms_id = json["cms_id"] as! NSString
            var long_desc = json["long_desc"] as! NSString
            var duration_max = json["duration_max"] as! NSInteger
            var name = json["name"] as! NSString
            var destination = json["destination"] as! NSString
            
            var featured_trip_ideas = json["featured_trip_ideas"] as! NSArray
            var id = json["id"] as! NSInteger
            var googleplaces_id = json["googleplaces_id"] as! NSString
            var sortable_name = json["sortable_name"] as! NSString
            var duration_min = json["duration_min"] as! NSInteger
            var photos = json["photos"] as! NSArray
            
            for item in photos{
                var photo_ide = item["id"] as! NSInteger
                var photo_name = item["name"] as! String
                var photo_display_order = item["display_order"] as! NSInteger
                var photo_timestamp = item["timestamp"] as! String
                var photo_url = item["url"] as! String
                var photo_caption = item["caption"] as! String
                var photo_credit = item["credit"] as! String
                
                self.urlArray.append(photo_url)
                //objects[photo_url] = destination as String
                //objects[destination] =  photo_urlas String
                
            }
            
            var published = json["published"] as! Bool
            var yelp_id = json["yelp_id"] as! NSString
            var photo_count = json["photo_count"] as! NSInteger
            var duration_avg = json["duration_avg"] as! NSInteger
            var transit = json["transit"] as! NSDictionary
            

        }

            
        

        
        
        dispatch_async(dispatch_get_main_queue()){ [unowned self] in
            //self.tableView.reloadData()
            self.loadButton()
        }
        
    }
    
    

}