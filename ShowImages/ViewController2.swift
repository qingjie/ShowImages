//
//  ViewController2.swift
//  ShowImages
//
//  Created by qingjiezhao on 7/2/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//

import UIKit
import MapKit

class ViewController2: UIViewController , MKMapViewDelegate , UIPageViewControllerDataSource{
    var objects = [[String : String]]()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nearbyImgView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addImg: UIButton!
    @IBOutlet weak var addImg1: UIButton!
    @IBOutlet weak var addImg2: UIButton!
    
    
    @IBOutlet weak var lbl0: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    
    let screenWidth = UIScreen.mainScreen().bounds.width;
    
    
    
    
    func parseURL(){
        var urlString : String = "http://www.ruebarue.com/api/search?types=attraction&destination=boston"
        
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)) { [unowned self] in
            if let url = NSURL(string: urlString){
                if let data = NSData(contentsOfURL: url, options: .allZeros, error: nil){
                    //let json = JSON( data: data)
                    let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)! as! NSArray
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
    
    func parseJSON(json : NSArray){
        for result in json as NSArray{
            var id = result.objectForKey("id") as! String
            println("id:\(id)\n")
            var name = result.objectForKey("name") as! String
            println("name:\(name)\n")
            var sortable_name = result.objectForKey("sortable_name") as! String
            var slug = result.objectForKey("slug") as! String
            var place_type = result.objectForKey("place_type") as! String
            var location = result.objectForKey("location") as! NSDictionary
            let latitudeData : AnyObject? = location["Lat"]
            let longitudeData: AnyObject? = location["Lng"]
            
            println("latitude --> \(latitudeData)")
            println("longitude --> \(longitudeData)")
            
            var address = result.objectForKey("address") as! String
            println("address:\(address)\n")
            var city = result.objectForKey("city") as! String
            //println("city:\(city)\n")
            var destination = result.objectForKey("destination") as! String
            var destination_name = result.objectForKey("destination_name") as! String
            var tags = result.objectForKey("tags") as! String
            var cuisines = result.objectForKey("cuisines") as! String
            var cms_id = result.objectForKey("cms_id") as! String
            var google_id = result.objectForKey("google_id") as! String
            var photo_count = result.objectForKey("photo_count") as! String
            var rank = result.objectForKey("rank") as! NSInteger
        
            var lat:String = latitudeData!.description
            var lon:String = longitudeData!.description
            
            let dict = ["name" : name , "address" : address, "latitudeData" :  lat, "longitudeData" : lon,"sortable_name":sortable_name,"slug":slug]
            
            objects.append(dict)
            
        }
        
        dispatch_async(dispatch_get_main_queue()){ [unowned self] in
            var lat = String()
            var lon = String()
            var name = String()
            var address = String()
            var sortable_name = String()
            var slug = String()
            
            for key in self.objects[0].keys{
                if key == "latitudeData" {
                    lat = self.objects[0]["latitudeData"]!
                }else if key == "longitudeData" {
                    lon = self.objects[0]["longitudeData"]!
                }else if key == "name" {
                    name = self.objects[0]["name"]!
                }else if key == "address" {
                    address = self.objects[0]["address"]!
                }else if key == "sortable_name" {
                    sortable_name = self.objects[0]["sortable_name"]!
                }else if key == "slug" {
                    slug = self.objects[0]["slug"]!
                }
                
                
                self.loadMap(lat,lon: lon,sortable_name: sortable_name,slug: slug)
                self.loadImg()
                self.loadLbl0(name)
                self.loadLbl1(address)
                self.loadLbl2()
                self.loadLbl3()
                self.loadLbl4()
                self.loadLbl5()
                self.loadPageController()
                self.loadPVC()
            }

        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         parseURL()
        scrollView.userInteractionEnabled = true
        scrollView.contentSize = CGSizeMake(screenWidth,1000)
        //scrollView.frame = CGRectMake(0.0, 0.0, 320.0, 1000.0)
        
    }
    
    
    func loadMap(lat: String, lon:String, sortable_name: String, slug: String){
        var location = CLLocationCoordinate2DMake((lat as NSString).doubleValue , (lon as NSString).doubleValue)
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = sortable_name
        annotation.subtitle = slug
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
        mapView.addAnnotation(annotation)
        mapView.frame = CGRectMake(1.0, 394.0, screenWidth - 2.0 , 170.0)
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
        addImg.frame = CGRectMake(330, 10, 30, 30 )
        addImg1.frame = CGRectMake(330, 150, 30, 30 )
        self.imgView.addSubview(addImg)
        self.imgView.addSubview(addImg1)
        self.scrollView.addSubview(imgView)
    }
    
    func loadLbl0(name:String){
        
        lbl0.frame = CGRectMake(1.0, 202.0, screenWidth - 2.0 , 150.0)
        lbl0.text = name
        lbl0.font = UIFont(name: lbl0.font.fontName, size: 15)
        lbl0.backgroundColor = UIColor.lightGrayColor()
        addImg2.frame = CGRectMake(330, 10, 30, 30 )
        self.lbl0.addSubview(addImg2)
        self.scrollView.addSubview(lbl0)
    }
    func loadLbl1(address:String){
        lbl1.text = address
        lbl1.frame = CGRectMake(1.0, 353.0, screenWidth - 2.0 , 40.0)
        lbl1.backgroundColor = UIColor.lightGrayColor()
        lbl1.font = UIFont(name: lbl1.font.fontName, size: 10)
        self.scrollView.addSubview(lbl1)
        
    }
    func loadLbl2(){
        lbl2.backgroundColor = UIColor.lightGrayColor()
        lbl2.frame = CGRectMake(1.0, 565.0, screenWidth - 2.0 , 40.0)
        self.scrollView.addSubview(lbl2)
        
    }
    func loadLbl3(){
        lbl3.backgroundColor = UIColor.lightGrayColor()
        lbl3.frame = CGRectMake(1.0, 606.0, screenWidth - 2.0 , 40.0)
        self.scrollView.addSubview(lbl3)
        
    }
    
    func loadLbl4(){
        lbl4.backgroundColor = UIColor.lightGrayColor()
        lbl4.frame = CGRectMake(1.0, 647.0, screenWidth - 2.0 , 40.0)
        self.scrollView.addSubview(lbl4)
        
    }
    
    func loadLbl5(){
        lbl5.backgroundColor = UIColor.lightGrayColor()
        lbl5.frame = CGRectMake(1.0, 688.0, screenWidth - 2.0 , 100.0)
        self.scrollView.addSubview(lbl5)
        
    }
    
    
    
    @IBAction func addImg(sender: AnyObject) {
    }
    
    @IBAction func addImg1(sender: AnyObject) {
    }
    
    @IBAction func addImg2(sender: AnyObject) {
    }
    
    var pageViewController : UIPageViewController?
    var pageTitles : Array<String> = ["God vs Man", "Cool Breeze", "Fire Sky"]
    //var pageImages : Array<String> = ["page1","page2","page3"];
    var pageImages : Array<String> = [
        "http://media.ruebarue.com/photos/places/4902239969738752/3-museum-of-fine-arts-3.jpg",
        "http://media.ruebarue.com/photos/places/4902239969738752/2-museum-of-fine-arts-2.jpg",
        "http://media.ruebarue.com/photos/places/4902239969738752/1-museum-of-fine-arts-1.jpg"
    ]
    var currentIndex : Int = 0
    
    func loadPVC(){
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController : InstructionView = viewControllerAtIndex(0)!
        
        let viewControllers : NSArray = [startingViewController]
        pageViewController!.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: false, completion: nil)
        //pageViewController!.view.frame = CGRectMake(0, 0, view.frame.width, view.frame.size.height)
        pageViewController!.view.frame = CGRectMake(2, 789.0, screenWidth - 4, 150.0)
        //pageViewController!.view.frame = CGRectMake(100, 763.0, screenWidth / 3 , 150.0)
        
        addChildViewController(pageViewController!)
        self.scrollView.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
    }
    
    
    func viewControllerAtIndex(index: Int) -> InstructionView? {
        if self.pageTitles.count == 0 || index >= self.pageTitles.count {
            return nil
        }
        
        let pageContentViewController = InstructionView()
        
        
        
       
        
        pageContentViewController.imageFile = pageImages[index]
        pageContentViewController.titleText = pageTitles[index]
        pageContentViewController.pageIndex = index
        currentIndex = index
        
        return pageContentViewController
    }
    
    
    
    func loadPageController(){
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.orangeColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! InstructionView).pageIndex
        
        if(index == 0 || (index == NSNotFound)){
            return nil
        }
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! InstructionView).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if (index == self.pageTitles.count){
            return nil
        }
        return viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
        
    
    
}
