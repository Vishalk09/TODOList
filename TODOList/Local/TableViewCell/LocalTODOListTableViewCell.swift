//
//  LocalTODOListTableViewCell.swift
//  TODOList
//
//  Created by Vishal Khokad on 23/06/24.
//

import UIKit

class LocalTODOListTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var isCompleted: UIButton!
    var data: LocalTODOListModel?
    var parentVC: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: LocalTODOListModel) {
        title.text = data.title
        isCompleted.tintColor = data.isCompleted ? .blue : .gray
    }
    
    @IBAction func clickOnCompleted(_ sender: Any) {
        if var model = data {
            let alertController = UIAlertController(title: model.isCompleted ? "Mark incomplete?" : "Mark completed?", message: nil, preferredStyle: .alert)
            let alertActionOk = UIAlertAction(title: "Ok", style: .default) { _ in
                model.isCompleted = !model.isCompleted
                let viewModel = TODOListViewModel()
                viewModel.updateData(model)
                self.isCompleted.tintColor = model.isCompleted ? .blue : .gray
            }
            let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alertController.addAction(alertActionOk)
            alertController.addAction(alertActionCancel)
            
            parentVC.present(alertController, animated: true)
            
        }
    }
}
