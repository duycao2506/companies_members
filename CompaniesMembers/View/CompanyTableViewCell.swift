//
//  CompanyTableViewCell.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/4/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit
import SDWebImage

protocol ListItemCellProtocol {
    func configure(itemViewModel : ListItemViewModelProtocol)
}

class CompanyTableViewCell: UITableViewCell, ListItemCellProtocol {

    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    
    static let identifier : String = "CompanyTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(itemViewModel: ListItemViewModelProtocol) {
        guard let companyViewModel = itemViewModel as? CompanyListItemViewModel else {return}
        self.lblSubtitle.text = companyViewModel.subTitle
        self.lblMainTitle.text = companyViewModel.mainTitle
        self.imgLogo.sd_setImage(with: URL.init(string: companyViewModel.logoUrl), placeholderImage: UIImage.init(named: "company_placeholder"), options: [], context: nil)
        self.lblDescription.text = companyViewModel.about
    }
}
