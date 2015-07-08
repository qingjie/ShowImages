//
//  ViewController2.swift
//  ShowImages
//
//  Created by qingjiezhao on 7/2/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//

import UIKit
import MapKit

class ViewController2: UIViewController , MKMapViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nearbyImgView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    var urlString : String = "http://www.ruebarue.com/api/search?types=attraction"

    @IBOutlet weak var addImg: UIButton!
    @IBOutlet weak var addImg1: UIButton!
    @IBOutlet weak var addImg2: UIButton!
    
    
    @IBOutlet weak var lbl0: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    
    let screenWidth = UIScreen.mainScreen().bounds.width;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.userInteractionEnabled = true
        scrollView.contentSize = CGSizeMake(screenWidth,1000)
        //scrollView.frame = CGRectMake(0.0, 0.0, 320.0, 1000.0)
       
        loadMap()
        loadImg()
        loadLbl0()
        loadLbl1()
        loadLbl2()
        loadLbl3()
        swimg()
    }
    
    
    func loadMap(){
        var location = CLLocationCoordinate2DMake(43.0377,-76.1396)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Syracuse University"
        annotation.subtitle = "NY"
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
        mapView.addAnnotation(annotation)
        mapView.frame = CGRectMake(1.0, 373.0, screenWidth - 2.0 , 170.0)
        self.scrollView.addSubview(mapView)
    }
    
    func loadImg(){
        var imgURL: NSURL = NSURL(string: "http://media.ruebarue.com/photos/places/4902239969738752/1-museum-of-fine-arts-1.jpg")!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    self.imgView.image = UIImage(data: data)
                }
        })
        
       
        imgView.frame = CGRectMake(1.0, 1.0, screenWidth - 2.0 , 200.0)
        addImg.frame = CGRectMake(310, 10, 30, 30 )
        addImg1.frame = CGRectMake(310, 150, 30, 30 )
        self.imgView.addSubview(addImg)
        self.imgView.addSubview(addImg1)
        self.scrollView.addSubview(imgView)
    }
    
    func loadLbl0(){
        
        lbl0.frame = CGRectMake(1.0, 202.0, screenWidth - 2.0 , 150.0)
        addImg2.frame = CGRectMake(310, 20, 30, 30 )
        self.lbl0.addSubview(addImg2)
        self.scrollView.addSubview(lbl0)
    }
    func loadLbl1(){
        
        lbl1.frame = CGRectMake(1.0, 333.0, screenWidth - 2.0 , 40.0)
        self.scrollView.addSubview(lbl1)
        
    }
    func loadLbl2(){
        
        lbl2.frame = CGRectMake(1.0, 543.0, screenWidth - 2.0 , 40.0)
        self.scrollView.addSubview(lbl2)
        
    }
    func loadLbl3(){
        lbl3.frame = CGRectMake(1.0, 583.0, screenWidth - 2.0 , 40.0)
        self.scrollView.addSubview(lbl3)
        
    }
    
    
    
    @IBAction func addImg(sender: AnyObject) {
    }
    
    @IBAction func addImg1(sender: AnyObject) {
    }
    
    @IBAction func addImg2(sender: AnyObject) {
    }
    
    var imageList:[String] = ["image1.jpg", "image2.jpg", "image3.jpg","image4.jpg"]
    let maxImages = 2
    
    var imageIndex: NSInteger = 0
    
    
    
    func swimg(){
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:") // put : at the end of method name
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:") // put : at the end of method name
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        nearbyImgView.image = UIImage(named:"image1.jpg")
        nearbyImgView.frame = CGRectMake(1.0, 624.0, screenWidth - 2.0 , 200.0)
        self.scrollView.addSubview(nearbyImgView) 
    }
    
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Right :
                println("User swiped right")
                
                // decrease index first
                
                imageIndex--
                
                // check if index is in range
                
                if imageIndex < 0 {
                    
                    imageIndex = maxImages
                    
                }
                
                nearbyImgView.image = UIImage(named: imageList[imageIndex])
                
            case UISwipeGestureRecognizerDirection.Left:
                println("User swiped Left")
                
                // increase index first
                
                imageIndex++
                
                // check if index is in range
                
                if imageIndex > maxImages {
                    
                    imageIndex = 0
                    
                }
                
                nearbyImgView.image = UIImage(named: imageList[imageIndex])
                
                
                
                
            default:
                break //stops the code/codes nothing.
                
                
            }
            
        }
        
        
    }
    
}
