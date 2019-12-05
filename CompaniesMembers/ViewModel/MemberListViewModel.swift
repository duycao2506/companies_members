//
//  MemberListViewModel.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/5/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation

class MemberListViewModel : ListViewModel {
    var company : Company!
    init(company : Company) {
        super.init()
        self.company = company
        self.title.value = company.name
        self.sortOptions = [.name, .age]
        self.rawItemList = company.members.map({MemberListItemViewModel.init(member: $0)})
        self.filter()
    }
    
    override func refresh() {
        isLoading.value = true
        isLoading.value = false
    }
}
