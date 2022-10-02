//
//  BaseService.swift
//  Latihan Iglo Beyond
//
//  Created by Muhammad Alwan on 28/09/22.
//

import Foundation

class BaseService {
    
    private func baseRequest(header: [String: String]?, request: URLRequest, completion: @escaping ([String: Any]?, Error?) -> Void) {
        
        var request = request
        
        if let header = header {
            for header in header {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                print("Post Request Error: Invalid Response")
                completion(nil, "Invalid Response" as? Error)
                return
            }
            
            guard let data = data else {
                print("Post Request Error: Data is nil")
                completion(nil, "Data is nil" as? Error)
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("jsonResponse: \(jsonResponse)")
                    completion(jsonResponse, nil)
                } else {
                    print("Post Request Error: Data maybe corrupted or in wrong format")
                    completion(nil, "Data maybe corrupted or in wrong format" as? Error)
                    throw URLError(.badServerResponse)
                }
            } catch let error {
                print("Post Request Error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    public func postRequest(parameter: [String: Any], url: URL, header: [String: String]?, completion: @escaping ([String: Any]?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        } catch let error {
            print("Post Request Error: \(error.localizedDescription)")
            completion(nil, error)
            return
        }
        
        baseRequest(header: header, request: request, completion: { data, error in
            completion(data, error)
        })
    }
    
    public func getRequest(urlString: String, queryItems: [URLQueryItem]?, header: [String: String]?, completion: @escaping ([String: Any]?, Error?) -> Void) {
        
        var components = URLComponents(string: urlString)!
        
        components.queryItems = queryItems
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = components.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        baseRequest(header: header, request: request, completion: { data, error in
            completion(data, error)
        })
    }
    
}
