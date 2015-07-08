//
//  ViewController4.swift
//  ShowImages
//
//  Created by qingjiezhao on 7/4/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//


import UIKit

class ViewController4: UIViewController , UIPageViewControllerDataSource{
    
    
    var pageViewController : UIPageViewController?
    var pageTitles : Array<String> = ["God vs Man", "Cool Breeze", "Fire Sky"]
    var pageImages : Array<String> = ["page1.png", "page2.png", "page3.png"]
    var currentIndex : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPageController()
        loadPVC()
    }
    
    
    func loadPVC(){
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController : InstructionView = viewControllerAtIndex(0)!
        
        let viewControllers : NSArray = [startingViewController]
        pageViewController!.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 0, view.frame.width, view.frame.size.height)
        
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
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