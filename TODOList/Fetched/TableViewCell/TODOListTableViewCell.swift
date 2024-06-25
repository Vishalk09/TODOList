//
//  TODOListTableViewCell.swift
//  TODOList
//
//  Created by Vishal Khokad on 22/06/24.
//

import UIKit

class TODOListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completed: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: TODOResponseModel) {
        
        titleLabel.text = data.title
        if data.completed {
            completed.tintColor = .blue
        } else {
            completed.tintColor = .gray
        }
        
    }
    
}
