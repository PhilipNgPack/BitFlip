//
//  PageViewController.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/27/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class PageViewController: UIPageViewController {
    fileprivate var items: [UIViewController] = []
    
    var graphController: GraphController!
    var gameController: GameController!
    var historyController: HistoryController!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        print("pageviewcontroller loaded")
        decoratePageControl()
        populateItems()
        let firstViewController = items[1]
        setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        
    }
    
    fileprivate func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [PageViewController.self])
        pc.currentPageIndicatorTintColor = .orange
        pc.pageIndicatorTintColor = .gray
    }
    
    // populate da items
    fileprivate func populateItems() {
        items.append(graphController)
        items.append(gameController)
        items.append(historyController)
    }
}

// MARK: - DataSource
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return items.last
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
