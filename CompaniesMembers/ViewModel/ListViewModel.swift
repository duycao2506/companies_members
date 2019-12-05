//
//  ListViewModel.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/4/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

enum SortType : String{
    case name = "Name"
    case age = "Age"
}

enum SortDirection : String {
    case ascending = "Ascending"
    case descending = "Descending"
}

protocol ListViewModelProtocol : class {
    var isLoading : Bindable<Bool> {get set}
    var error : Bindable<Error?> {get set}
    var title: Bindable<String> {get set}
    
    var rawItemList : [ListItemViewModelProtocol] {get set}
    var sortOptions : [SortType] {get set}
    
    var filteredList : Bindable<[ListItemViewModelProtocol]> {get set}
    var searchString : Bindable<String> {get set}
    var sortType : Bindable<SortType> {get set}
    var sortDir : Bindable<SortDirection> {get set}
    
    func itemAt(section : Int, index : Int) -> ListItemViewModelProtocol
    func countSection() -> Int
    func countRowsIntSection(section : Int) -> Int
    func updateSortType(type : SortType)
    func updateSortDir(dir : SortDirection)
    func sort()
    func filter()
    func refresh()
}

class ListViewModel: NSObject, ListViewModelProtocol{
    
    var sortOptions: [SortType] = []
    
    var isLoading: Bindable<Bool> = .init(false)
    var error: Bindable<Error?> = .init(nil)
    
    var searchString: Bindable<String> = .init("")
    
    var title: Bindable<String> = .init("")
    
    var sortDir: Bindable<SortDirection> = .init(.ascending)
    
    var sortType: Bindable<SortType> = .init(.name)
    
    var rawItemList: [ListItemViewModelProtocol] = []
    
    var filteredList: Bindable<[ListItemViewModelProtocol]> = .init([])
    
    func countSection() -> Int {
        return 1
    }
    
    func countRowsIntSection(section: Int) -> Int {
        return self.filteredList.value.count
    }
    
    func itemAt(section: Int, index: Int) -> ListItemViewModelProtocol {
        return self.filteredList.value[index]
    }
    
    func sort() {
        self.filteredList.value = self.sorted(array: self.filteredList.value)
    }
    
    private func sorted(array : [ListItemViewModelProtocol]) -> [ListItemViewModelProtocol]{
        return array.sorted { [weak self] (lhs, rhs) -> Bool in
            guard let self = self else {return true}
            let lhsVal = lhs.getComparedValue(sortType: self.sortType.value)
            let rhsVal = rhs.getComparedValue(sortType: self.sortType.value)
            if self.sortDir.value == .ascending { return lhsVal < rhsVal}
            return lhsVal >= rhsVal
        }
    }
    
    func filter() {
        guard !self.searchString.value.isEmpty else {
            self.filteredList.value = self.sorted(array: self.rawItemList)
            return
        }
        let tmpList = self.rawItemList.filter({$0.mainTitle.lowercased().contains(self.searchString.value.lowercased())})
        self.filteredList.value = self.sorted(array: tmpList)
    }
    
    func refresh() {
        
    }
    
    func updateSortType(type: SortType) {
        self.sortType.value = type
        self.filter()
    }
    
    func updateSortDir(dir: SortDirection) {
        self.sortDir.value = dir
        self.filter()
    }
    
}
