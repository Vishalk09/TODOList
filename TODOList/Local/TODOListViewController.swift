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
    let addVCObj = AddDataViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addVCObj.delegate = self
        
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
        var model = todoData[indexPath.row]
        let alertController = UIAlertController(title: model.isCompleted ? "Mark incomplete?" : "Mark completed?", message: nil, preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Ok", style: .default) { _ in
            model.isCompleted = !model.isCompleted
            let viewModel = TODOListViewModel()
            viewModel.updateData(model)
            viewModel.fetchData() { data in
                self.todoData = data
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(alertActionOk)
        alertController.addAction(alertActionCancel)
        
        self.present(alertController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete?") { [weak self] _,_,_ in
            let alertController = UIAlertController(title: "Delete?", message: "Do you want to delete?", preferredStyle: .alert)
            let alertAction1 = UIAlertAction(title: "Yes", style: .default) { _ in
                self?.viewModel.deleteData("\(self?.todoData[indexPath.row].date ?? Date())")
                self?.viewModel.fetchData() { data in
                    self?.todoData = data
                }
                self?.tableView.reloadData()
            }
            let alertAction2 = UIAlertAction(title: "No", style: .destructive) { _ in
                // Cancelled
            }
            alertController.addAction(alertAction1)
            alertController.addAction(alertAction2)
            
            self?.present(alertController, animated: true)
        }
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
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
