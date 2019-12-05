//
//  MemberListItemViewModel.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/5/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation

class MemberListItemViewModel: ListItemViewModel {
    var isFavorite : Bool = false
    var age : Int = 0
    var phone : String = ""
    
    override func getComparedValue(sortType: SortType) -> String {
        switch sortType {
        case .age:
            return "\(age)"
        default:
            return super.getComparedValue(sortType: sortType)
        }
    }
    
    init(member : Member) {
        super.init()
        self.rawValue = member
        self.mainTitle =  member.getFullName()
        self.subTitle = member.email
        self.phone = member.phone
        self.age = member.age
    }
    
    override func getViewIdentifier() -> String {
        return MemberTableViewCell.identifier
    }
}
