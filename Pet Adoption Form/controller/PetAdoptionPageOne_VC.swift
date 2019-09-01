//
//  PetAdoptionPageOne_VC.swift
//  Pet Adoption Form
//
//  Created by Noel Obaseki on 30/08/2019.
//  Copyright © 2019 Tizeti. All rights reserved.
//

import UIKit
class PetAdoptionPageOne_VC: UIViewController {

    @IBOutlet weak var SBFormTitle: UILabel!
    
    var base = [BaseModel]()
    var pg = [PagesModel]()
    var elements = [ElementsModel]()
    var sections = [SectionsModel]()
    var currentIndex = 0
    
    
    let DynamicTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromLocalJsonFile()
        setUpTableView()
        
        let pgs = base.flatMap{$0.pages}
        pg.append(contentsOf: pgs)
        let first = pg[currentIndex].sections.flatMap{$0.elements}
        elements.append(contentsOf: first)
        
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
        DynamicTableView.translatesAutoresizingMaskIntoConstraints = false
        DynamicTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        DynamicTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        DynamicTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        DynamicTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
       
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    
   
}
