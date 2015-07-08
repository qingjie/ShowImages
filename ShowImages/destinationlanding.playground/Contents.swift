//: Playground - noun: a place where people can play

import UIKit



var url = NSURL(string: "http://www.ruebarue.com/api/search?types=attraction")

var data = NSData(contentsOfURL: url!, options:NSDataReadingOptions.DataReadingUncached,error:nil)

var json:AnyObject = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)!

for result in json as! NSArray{
    var id = result.objectForKey("id") as! String
   
    var name = result.objectForKey("name") as! String
    var sortable_name = result.objectForKey("sortable_name") as! String
    var slug = result.objectForKey("slug") as! String
    var place_type = result.objectForKey("place_type") as! String
    var location = result.objectForKey("location") as! NSDictionary
    let latitudeData : AnyObject? = location["Lat"]
    let longitudeData: AnyObject? = location["Lng"]
    
    println("latitude --> \(latitudeData)")
    println("longitude --> \(longitudeData)")
    
    var address = result.objectForKey("address") as! String
    
    var city = result.objectForKey("city") as! String
   
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
   
}