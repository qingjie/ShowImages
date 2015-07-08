//: Playground - noun: a place where people can play

import UIKit


var url = NSURL(string: "http://www.ruebarue.com/api/nearby/4902239969738752 ")

var data = NSData(contentsOfURL: url!, options:NSDataReadingOptions.DataReadingUncached,error:nil)

var json:AnyObject = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)!


var objects = [[String : String]]()

for (key,value) in json as! NSDictionary{
    var rank = json["rank"] as! NSInteger
    var slug = json["slug"] as! NSString
    var google = json["google"] as! NSDictionary
    var tripadvisor_id = json["tripadvisor_id"] as! NSString
    var  tags = json["tags"] as! NSArray
    var  place_type = json["place_type"] as! NSString
    var  cms_id = json["cms_id"] as! NSString
    var long_desc = json["long_desc"] as! NSString
    var duration_max = json["duration_max"] as! NSInteger
    var  name = json["name"] as! NSString
    var  destination = json["destination"] as! NSString
    var  featured_trip_ideas = json["featured_trip_ideas"] as! NSArray
    var id = json["id"] as! NSInteger
    var googleplaces_id = json["googleplaces_id"] as! NSString
    var sortable_name = json["sortable_name"] as! NSString
    var  duration_min = json["duration_min"] as! NSInteger
    var  photos = json["photos"] as! NSArray
    var  published = json["published"] as! Bool
    var  yelp_id = json["yelp_id"] as! NSString
    var  photo_count = json["photo_count"] as! NSInteger
    var  duration_avg = json["duration_avg"] as! NSInteger
    var  transit = json["transit"] as! NSDictionary
    
    
    //println(key)
    //println(value)
    
    
    //println("\(key):\(value)")
}




