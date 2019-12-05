//
//  ListItemViewModel.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/5/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit



protocol ListItemViewModelProtocol : class {
    var rawValue : Any? {get set}
    var mainTitle : String {get set}
    var subTitle : String {get set}
    
    func getComparedValue(sortType : SortType) -> String
    func getViewIdentifier() -> String
}


class ListItemViewModel: NSObject, ListItemViewModelProtocol {
    
    var rawValue : Any? = nil
    
    var mainTitle: String = ""
    var subTitle: String = ""
    
    
    func getComparedValue(sortType : SortType) -> String {
        return self.mainTitle
    }
    
    func getViewIdentifier() -> String {
        return ""
    }

}
