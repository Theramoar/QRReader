//
//  NetworkService.swift
//  QRReader
//
//  Created by MihailsKuznecovs on 28/01/2021.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

class NetworkService {
    private var session: URLSession = .shared
    
    func makeRequest(to url: URL, requestType type: RequestType, completion: @escaping (Data?, Int?) -> Void) {
        let request = createRequest(type: type, url: url)

        let task = createDataTask(from: request) { data, response, error in
            guard let data = data, error == nil, let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil)
                return
            }
            let httpCode = httpResponse.statusCode
            completion(data, httpCode)
        }
        task.resume()
    }
    
    private func createRequest(type: RequestType, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }
    }
}
