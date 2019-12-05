//
//  CompanyListViewModel.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/5/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation

class CompanyListViewModel : ListViewModel {
    var repo : CompanyRepoProtocol!
    
    required init(repo: CompanyRepoProtocol = CompanyRepo.init()) {
        super.init()
        self.repo = repo
        self.title.value = "Companies"
    }
    
    override func refresh() {
        self.isLoading.value = true
        self.repo.getCompanyList(success: { [weak self] (companies) in
            guard let self = self else {return}
            self.rawItemList = companies.map({CompanyListItemViewModel.init(company: $0)})
            self.filter()
            
            self.isLoading.value = false
        }) {[weak self] (error) in
            self?.error.value = error
            self?.isLoading.value = false
        }
    }
}
