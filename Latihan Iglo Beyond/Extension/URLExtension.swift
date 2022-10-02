//
//  URLExtension.swift
//  Latihan Iglo Beyond
//
//  Created by Muhammad Alwan on 28/09/22.
//

import Foundation

let baseUrl = "http://34.101.119.19:8084" // development

extension URL {
    
    static var loginURL: URL {
        URL(string: "\(baseUrl)/api/User/Login")!
    }
    
    static var getJobListCategory: URL {
        URL(string: "\(baseUrl)/api/JobCategory/GetListCategory")!
    }
    
}
