//
//  AddDataViewController.swift
//  TODOList
//
//  Created by Vishal Khokad on 24/06/24.
//

import UIKit

class AddDataViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    let viewModel = TODOListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addData(_ sender: Any) {
        if isTextfieldEmpty() {
            let action = UIAlertAction(title: "Required field is empty", style: .cancel)
            let alertController = UIAlertController(title: "Missing data!", message: "Required fields are empty!", preferredStyle: .alert)
            alertController.addAction(action)
            present(alertController, animated: true)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let currentDate = Date()
            let formattedDate = dateFormatter.string(from: currentDate)
            let date = dateFormatter.date(from: formattedDate)!
            
            let model = LocalTODOListModel(date: date, title: titleTextField.text!, itemDescription: descriptionTextField.text!, isCompleted: false)
            viewModel.addData(model) { result in
                if result {
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func isTextfieldEmpty() -> Bool {
        return (titleTextField.text?.isEmpty ?? false) || (descriptionTextField.text?.isEmpty ?? false)
    }
}
