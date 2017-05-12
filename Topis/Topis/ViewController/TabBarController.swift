//
//  TabBarController.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/9/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        
        viewControllers = [UIViewController]()
        
        self.addTabHome()
        self.addTabNewTopic()
        self.addTabExplore()
    }
    
    // MARK: Tab Home
    func addTabHome() {
        let vc = HomeVC(nibName: Constants.ViewControllers.homeVC, bundle: nil)
        let image = UIImage(named: "home")
        
        self.addTab(withViewController: vc, image: image!)
    }
    
    // MARK: Tab NewTopic
    func addTabNewTopic() {
        let vc = NewTopicVC(nibName: Constants.ViewControllers.newTopicVC, bundle: nil)
        let image = UIImage(named: "add")

        self.addTab(withViewController: vc, image: image!)
    }
    
    // MARK: Tab Explore
    func addTabExplore() {
        let vc = ExploreVC(nibName: Constants.ViewControllers.exploreVC, bundle: nil)
        let image = UIImage(named: "explore")
        
        self.addTab(withViewController: vc, image: image!)
    }
    
    func addTab(withViewController vc: UIViewController, image: UIImage) {
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: true)
        
        viewControllers?.append(nav)
        
        nav.tabBarItem = UITabBarItem(title: "", image: image, tag: 2)
        
        // set image center to tab bar
        nav.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    // MARK: - Animated Transition
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabViewControllers = tabBarController.viewControllers!
        guard let toIndex = tabViewControllers.index(of: viewController) else {
            return false
        }
        
        // Our method
        animateToTab(toIndex: toIndex)
        return true
    }
    
    func animateToTab(toIndex: Int, needResetToRootView: Bool = false, completion: ((UIViewController) -> Void)? = nil) {
        let tabViewControllers = viewControllers!
        let fromView = selectedViewController!.view!
        let toView = tabViewControllers[toIndex].view!
        let fromIndex = tabViewControllers.index(of: selectedViewController!)
        
        guard fromIndex != toIndex else {return}
        
        // Add the toView to the tab bar view
        fromView.superview!.addSubview(toView)
        
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width;
        let scrollRight = toIndex > fromIndex!;
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        
        // Disable interaction during animation
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            // Slide the views by -offset
            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y);
            toView.center   = CGPoint(x: toView.center.x - offset, y: toView.center.y);
            
            if needResetToRootView {
                _ = (tabViewControllers[toIndex] as! UINavigationController).popToRootViewController(animated: true)
            }
            
        }, completion: { finished in
            
            // Remove the old view from the tabbar view.
            fromView.removeFromSuperview()
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
            
            if let completion = completion {
                let vc = (tabViewControllers[self.selectedIndex] as! UINavigationController).viewControllers.first!
                completion(vc)
            }
        })
    }
}
