//
//  Company.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/4/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation
import ObjectMapper

class Company : NSObject, Mappable {
    var id : String = ""
    var website : String = ""
    var name : String = ""
    var about : String = ""
    var logoUrl : String = ""
    var members : [Member] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON {
            id          <- map["_id"]
            website     <- map["website"]
            name        <- map["company"]
            about       <- map["about"]
            logoUrl     <- map["logo"]
            members     <- map["members"]
        }else{
            
        }
    }
    
    
}
