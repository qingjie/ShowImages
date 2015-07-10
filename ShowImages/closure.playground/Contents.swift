//: Playground - noun: a place where people can play

import UIKit

class Person {
    var name : String
    
    lazy var personalizedGreeting: String = {
       [unowned self] in
        return "Hello, \(self.name)!"
    }()
    
    init(name:String){
        self.name = name
    }
    
}


let person = Person(name:"qingjie")
person.personalizedGreeting



class Player{
    
    lazy var players : [String] = {
        
        var temporaryPlayers = [String]()
        
        temporaryPlayers.append("qingjie")
        
        return temporaryPlayers
        
        }()
}

let player = Player()
player.players


//        print(imageFile)
//        var imgURL: NSURL = NSURL(string: imageFile)!
//        let request: NSURLRequest = NSURLRequest(URL: imgURL)
//        NSURLConnection.sendAsynchronousRequest(
//            request, queue: NSOperationQueue.mainQueue(),
//            completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
//                if error == nil {
//                    //self.imgView.image = UIImage(data: data)
//                    self.view.backgroundColor = UIColor(patternImage: UIImage(data: data)!)
//                }
//        })

//
//lazy var personalizedGreeting: String = {
//    [unowned self] in
//    return "Hello, \(self.name)!"
//    }()


class ImgLoader{
    var imageFile : String
    

    
    init(imageFile:String){
        self.imageFile = imageFile
    }
    
    lazy var imgData : NSData = {
        [unowned self] in
        var imgURL: NSURL = NSURL(string: self.imageFile)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    //self.imgView.image = UIImage(data: data)
                    //self.view.backgroundColor = UIColor(patternImage: UIImage(data: data)!)
                    return data
                }
        })
        
    }()
}