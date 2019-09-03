//
//  PetAdoptionPageOne_VC.swift
//  Pet Adoption Form
//
//  Created by Noel Obaseki on 30/08/2019.
//  Copyright © 2019 Tizeti. All rights reserved.
//

import UIKit
class PetAdoptionPageOne_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var SBnextBtn: UIButton!
    
    var base = [BaseModel]()
    var pages_model = [PagesModel]()
    var elements = [ElementsModel]()
    var sections = [SectionsModel]()
    var currentIndex = 0
    
    
    var nextClick: (() -> ())?
    var backClick: (() -> ())?
    
    
    let DynamicTableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        getDataFromLocalJsonFile()
        
        let pages_models = base.flatMap{$0.pages}
        pages_model.append(contentsOf: pages_models)
        let first = pages_model[currentIndex].sections.flatMap{$0.elements}
        elements.append(contentsOf: first)
        setUpTableView()
        
    }
    
    
    func loadNewTableViewContent(){
        elements.removeAll()
        
        let dynamicIndex = pages_model[currentIndex].sections.flatMap{$0.elements}
        elements.append(contentsOf: dynamicIndex)
        
        elements.forEach { (el) in
            guard let id  = el.unique_id else {return}
            self.DynamicTableView.register(CustomDynamicTableViewCell.self, forCellReuseIdentifier: id)
        }
        DynamicTableView.reloadData()
    }
    
    
    func getDataFromLocalJsonFile(){
        guard let data = stubbedResponse("pet_adoption") else {return}
        do {
            let decoded = try JSONDecoder().decode(BaseModel.self, from: data)
            base.append(decoded)
        } catch {
            print("error")
        }
        let array = base.compactMap {$0}
            .flatMap{$0.pages}
        array.forEach { (pages_model) in
            sections.append(contentsOf: pages_model.sections)
        }
    }

    
     func stubbedResponse(_ filename: String) -> Data! {
        @objc class TestClass: NSObject {}
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
    
    
    func ValidateForm(){
        
    }
    
    
    func setUpTableView(){
        view.addSubview(DynamicTableView)

        DynamicTableView.delegate = self
        DynamicTableView.dataSource = self
        DynamicTableView.rowHeight = UITableView.automaticDimension
        DynamicTableView.estimatedRowHeight = 600
        
        elements.forEach { (el) in
            guard let id  = el.unique_id else {return}
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
