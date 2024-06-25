//
//  TODOListViewController.swift
//  TODOList
//
//  Created by Vishal Khokad on 22/06/24.
//

import UIKit

class TODOListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let viewModel = TODOListViewModel()
    var todoData = [LocalTODOListModel]()
    let adVCObj = AddDataViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adVCObj.delegate = self
        viewModel.fetchData() { data in
            self.todoData = data
            self.tableView.reloadData()
        }
        
        
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "LocalTODOListTableViewCell", bundle: nil), forCellReuseIdentifier: "LocalTODOListTableViewCell")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func clickOnAddData(_ sender: Any) {
        let vc: AddDataViewController = storyboard?.instantiateViewController(withIdentifier: "AddDataViewController") as! AddDataViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TODOListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocalTODOListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LocalTODOListTableViewCell", for: indexPath) as! LocalTODOListTableViewCell
        cell.setupData(todoData[indexPath.row])
        cell.data = todoData[indexPath.row]
        cell.parentVC = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did tap on \(indexPath.row)")
    }
}

extension TODOListViewController: AddDataCompletionProtocol {
    func didAddData() {
        print("Delegated")
        viewModel.fetchData() { data in
            self.todoData = data
            self.tableView.reloadData()
        }
    }
}
