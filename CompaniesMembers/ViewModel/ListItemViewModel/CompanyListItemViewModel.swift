//
//  CompanyListItemViewModel.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/5/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation

class CompanyListItemViewModel : ListItemViewModel {
    var logoUrl : String = ""
    var about  : String = ""
    
    override func getComparedValue(sortType: SortType) -> String {
        super.getComparedValue(sortType: sortType)
    }
    
    init(company: Company) {
        super.init()
        self.rawValue = company
        self.about = company.about
        self.mainTitle = company.name
        self.subTitle = company.website
        self.about = company.about
        self.logoUrl = company.logoUrl
    }
    
    override func getViewIdentifier() -> String {
        return CompanyTableViewCell.identifier
    }
}
