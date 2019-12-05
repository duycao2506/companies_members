//
//  MemberTableViewCell.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/4/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell, ListItemCellProtocol {

    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    static let identifier : String = "MemberTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(itemViewModel: ListItemViewModelProtocol) {
        guard let memberViewModel = itemViewModel as? MemberListItemViewModel else {return}
        self.lblAge.text = "\(memberViewModel.age)y"
        self.lblName.text = memberViewModel.mainTitle
        self.lblEmail.text = memberViewModel.subTitle
        self.lblPhone.text = memberViewModel.phone
    }
    
    
}
