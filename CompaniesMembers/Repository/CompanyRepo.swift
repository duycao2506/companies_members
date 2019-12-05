//
//  CompanyRepo.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/4/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol CompanyRepoProtocol {
    func getCompanyList(success : @escaping (([Company])->()), failure : @escaping ((Error)->()))
}

class CompanyRepo: NSObject, CompanyRepoProtocol {
    func getCompanyList(success : @escaping (([Company])->()), failure : @escaping ((Error)->())){
        AF.request("https://next.json-generator.com/api/json/get/Vk-LhK44U").responseArray { (response: DataResponse<[Company], AFError>) in
            if let error = response.error {
                failure(NSError.init(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey:error.localizedDescription]))
                return
            }
            do {
                let companyList = try response.result.get()
                success(companyList)
            } catch let err {
                failure(err)
            }
        }
    }
}
