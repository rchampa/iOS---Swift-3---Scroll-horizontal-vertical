//
//  TutorialPageViewController.swift
//  Pages
//
//  Created by Ricardo Champa on 04/12/2016.
//  Copyright © 2016 rchampa. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GreenViewController"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YellowViewController"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlueViewController"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VerticalPageViewController")]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        super.dataSource = self
//        super.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: UIPageViewControllerNavigationDirection.forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private func newColoredViewController(_ color: String) -> UIViewController {
        let name : String
        name = "\(color)ViewController"
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    private func enableScroll(enable : Bool){
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = enable
            }
        }
    }

}


extension TutorialPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
//            return orderedViewControllers.first
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
//            return orderedViewControllers.last
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
}
