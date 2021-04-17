//
//  NetworkServices.swift
//  Github-Repos
//
//  Created by sHiKoOo on 4/15/21.
//

import Foundation

class NetworkServices {
    /// General networkrequest function with URLSession request and Codable for parsing JSON response
    class func request<T: Codable> (endPoint: EndPoint, responseClass: T.Type, completion: @escaping (T?, NetworkServicesError?) -> Void) {
        let endPointURL = endPoint.path
        guard let url = URL(string: endPointURL) else {
            completion(nil, .connectionError(connection: "End-Point URL not valid"))
            return
        }
        
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.httpMethod = endPoint.method.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("DataTask error", error!)
                completion(nil, .responseError(response: error?.localizedDescription ?? "Response Error"))
            } else {
                guard let data = data else {
                    completion(nil, .responseError(response: "Data Error"))
                    return
                }
                do {
                    let responseObj = try JSONDecoder().decode(T.self, from: data)
                    completion(responseObj, nil)
                }catch {
                    do {
                        let responseObj = try JSONDecoder().decode(ErrorModelData.self, from: data)
                        let msg = responseObj.message ?? "Response Error"
                        completion(nil, .responseError(response: msg))
                    }catch {
                        print("ERROR: \(error)")
                        completion(nil, .responseError(response: error.localizedDescription))
                    }
                }
            }
        }.resume()
    }
    
}
