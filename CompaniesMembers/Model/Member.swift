//
//  Member.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/4/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation
import ObjectMapper


class Member : NSObject, Mappable {
    var id : String = ""
    var age : Int = 0
    var firstName : String = ""
    var lastName : String = ""
    var email : String = ""
    var phone : String = "" 
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON {
            id              <- map["_id"]
            age             <- map["age"]
            firstName       <- map["name.first"]
            lastName        <- map["name.last"]
            email           <- map["email"]
            phone           <- map["phone"]
        }else {
            
        }
    }
    
    func getFullName() -> String {
        return [self.firstName, self.lastName].joined(separator: " ")
    }
}
