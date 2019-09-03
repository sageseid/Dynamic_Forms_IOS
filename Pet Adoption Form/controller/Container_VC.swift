//
//  Main_VC.swift
//  Pet Adoption Form
//
//  Created by Noel Obaseki on 02/09/2019.
//  Copyright © 2019 Tizeti. All rights reserved.
//

import UIKit

class Container_VC: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var pageController: UIPageViewController?

    var base = [BaseModel]()
    var pg = [PagesModel]()
    var elements = [ElementsModel]()
    var sections = [SectionsModel]()
    var currentIndex = 0
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var formTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.isHidden = true
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromLocalJsonFile()
        let pgs = base.flatMap{$0.pages}
        pg.append(contentsOf: pgs)
        
        let first = pg[currentIndex].sections.flatMap{$0.elements}
        elements.append(contentsOf: first)
        setupPageController()
    }

    
    func removeSwipeGesture(){
        for view in self.pageController!.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PetAdoptionPageOne_VC).currentIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
                if index - 1 < pg.count {
                    submitBtn.isHidden = true
                }
        
        index -= 1
        
        return viewControllerAtIndex(index: index)
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PetAdoptionPageOne_VC).currentIndex
        if index == NSNotFound {return nil}
        
        index += 1
        if (index == self.pg.count) {
            //nil
        }
        return viewControllerAtIndex(index: index)
    }
    
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pg.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    private func pageViewController(pageViewController: UIPageViewController, willTransitionTo: [UIViewController]) {
        // called when swiping begins
    }
    
    private func pageViewController(pageViewController: UIPageViewController, didFinishAnimating: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
        // called when swiping ends
                if currentIndex  == pg.count {
                    submitBtn.isHidden = false
                }
    }
    
    func viewControllerAtIndex(index: Int) -> PetAdoptionPageOne_VC? {
        if self.pg.count == 0 || index >= self.pg.count {
            return nil
        }
        if (index == self.pg.count-1) {
            submitBtn.isHidden = false
        }
        
        let pageContentViewController = PetAdoptionPageOne_VC()
        pageContentViewController.pages_model = pg 
        pageContentViewController.currentIndex  = index
        currentIndex = index
        pageContentViewController.DynamicTableView.reloadData()
        return pageContentViewController
    }
    

    
    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        
        let startingViewController: PetAdoptionPageOne_VC = viewControllerAtIndex(index: 0)!
        let viewControllers = [startingViewController]
        pageController?.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
        pageController?.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height);

        addChild(pageController!)
        view.addSubview(pageController!.view)
        removeSwipeGesture()
        
    }
    
    
    
    func getDataFromLocalJsonFile(){
        guard let data = stubbedResponse("pet_adoption") else {return}
        do {
            let decoded = try JSONDecoder().decode(BaseModel.self, from: data)
            formTitle.text = decoded.name
            base.append(decoded)
        } catch {
            print("error")
        }
        let array = base.compactMap {$0}
            .flatMap{$0.pages}
        array.forEach { (pg) in
            sections.append(contentsOf: pg.sections)
        }
    }
    
    func stubbedResponse(_ filename: String) -> Data! {
        @objc class TestClass: NSObject {}
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
    
    
    
}
