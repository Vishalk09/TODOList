//
//  TODOFetchedListViewController.swift
//  TODOList
//
//  Created by Vishal Khokad on 22/06/24.
//

import UIKit
// This is for only demonstration for fetching data from API.
class TODOFetchedListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let viewModel = TODOFetchedListViewModel()
    var todoData = [TODOResponseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData() { data in
            self.todoData = data
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "TODOListTableViewCell", bundle: nil), forCellReuseIdentifier: "TODOListTableViewCell")
    }
}

extension TODOFetchedListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TODOListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TODOListTableViewCell", for: indexPath) as! TODOListTableViewCell
        cell.setupData(todoData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}
