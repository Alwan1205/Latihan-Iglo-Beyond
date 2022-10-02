//
//  JobCategoryService.swift
//  Latihan Iglo Beyond
//
//  Created by Muhammad Alwan on 03/10/22.
//

import Foundation

class JobCategoryService {
    
    public func getListCategory(completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url: URL = .getJobListCategory
        let urlString = url.absoluteString
        
        BaseService().getRequest(urlString: urlString, queryItems: nil, header: nil, completion: { data, error in
            completion(data, error)
        })
    }
    
}
