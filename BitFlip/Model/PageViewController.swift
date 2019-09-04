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
    fileprivate var pages: [UIViewController] = []
    
    var graphController: GraphController!
    var gameController: GameController!
    var historyController: HistoryController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        populatePages()
        let firstViewController = pages[1]
        setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        loadObservers()
    }
    
    // populate da pages
    fileprivate func populatePages() {
        pages.append(graphController)
        pages.append(gameController)
        pages.append(historyController)
    }
    
    func loadObservers () {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(goToPage(notification:)),
                                       name: .goToPageNotif,
                                       object: nil)
    }

}

// MARK: - DataSource
extension PageViewController: UIPageViewControllerDataSource {
    
    // go back a page
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)!
        let previousIndex = currentIndex - 1
        return (previousIndex == -1) ? nil : pages[previousIndex]
    }
    
    // go forwards
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)!
        let nextIndex = currentIndex + 1
        
        // insert code here to clear graph data to save memory
        return (nextIndex == pages.count) ? nil : pages[nextIndex]
    }
    
    
    @objc func goToPage(notification: NSNotification) {
        guard let currentViewController = self.viewControllers?.first else { return }
        
        if let userInfo = notification.userInfo?["page"] as? String {
            switch userInfo {
            case "graph":
                guard let nextViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
                setViewControllers([nextViewController], direction: .reverse, animated: true, completion: nil)
                
            default:
                guard let previousViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
                setViewControllers([previousViewController], direction: .forward, animated: true, completion: nil)
                
            }
        }
    }
}
