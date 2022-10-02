//
//  ApiServices.swift
//  Latihan Iglo Beyond
//
//  Created by Muhammad Alwan on 27/09/22.
//

import Foundation

class LoginService {
    
    public func login(userName: String, password: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        
        let parameter: [String: Any] = [
            "userName": userName,
            "password": password
        ]
        
        let header = ["Content-Type": "application/json"]
        
        BaseService().postRequest(parameter: parameter, url: .loginURL, header: header, completion: { data, error in
            completion(data, error)
        })
    }
    
}
