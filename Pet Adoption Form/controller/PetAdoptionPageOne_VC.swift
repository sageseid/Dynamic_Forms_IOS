//
//  PetAdoptionPageOne_VC.swift
//  Pet Adoption Form
//
//  Created by Noel Obaseki on 30/08/2019.
//  Copyright © 2019 Tizeti. All rights reserved.
//

import UIKit
class PetAdoptionPageOne_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var SBFormTitle: UILabel!
    
    var base = [BaseModel]()
    var pg = [PagesModel]()
    var elements = [ElementsModel]()
    var sections = [SectionsModel]()
    var currentIndex = 0
    
    
    let DynamicTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    
    
    @IBAction func SBnextBtnClicked(_ sender: Any) {
        currentIndex += 1
        
        if currentIndex >= (pg.count) {
            currentIndex = pg.count
            loadNewTableViewContent()
        }else {
            loadNewTableViewContent()
        }
        
    }
    
    @IBAction func SBbackBtnClicked(_ sender: Any) {
         currentIndex -= 1
        
        if currentIndex <= 0 {
            currentIndex = 0
            loadNewTableViewContent()
        }else {
            loadNewTableViewContent()
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        getDataFromLocalJsonFile()
        
        let pgs = base.flatMap{$0.pages}
        pg.append(contentsOf: pgs)
        let first = pg[currentIndex].sections.flatMap{$0.elements}
        elements.append(contentsOf: first)
        
        setUpTableView()
        
    }
    
    
    
    func loadNewTableViewContent(){
        elements.removeAll()
        let dynamicIndex = pg[currentIndex].sections.flatMap{$0.elements}
        elements.append(contentsOf: dynamicIndex)
        
        elements.forEach { (el) in
            guard let id  = el.unique_id else {return}
            print(id)
            self.DynamicTableView.register(CustomDynamicTableViewCell.self, forCellReuseIdentifier: id)
        }
        
        DynamicTableView.reloadData()
    }
    
    
    
    
    func getDataFromLocalJsonFile(){
        guard let data = stubbedResponse("pet_adoption") else {return}
        do {
            let decoded = try JSONDecoder().decode(BaseModel.self, from: data)
            SBFormTitle.text = decoded.name
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
    
    
    
    func setUpTableView(){
        view.addSubview(DynamicTableView)
        DynamicTableView.delegate = self
        DynamicTableView.dataSource = self
        DynamicTableView.rowHeight = UITableView.automaticDimension
        DynamicTableView.estimatedRowHeight = 600
        
        elements.forEach { (el) in
            guard let id  = el.unique_id else {return}
            print(id)
            self.DynamicTableView.register(CustomDynamicTableViewCell.self, forCellReuseIdentifier: id)
        }
        
        DynamicTableView.translatesAutoresizingMaskIntoConstraints = false
        DynamicTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        DynamicTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        DynamicTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        DynamicTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = elements[indexPath.row]
        let cellIdentifier = cellModel.unique_id
        let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath) as! CustomDynamicTableViewCell
        customCell.createDynamicTableViewCell(element_model: cellModel)
        return customCell as UITableViewCell
    }
    
   
}
