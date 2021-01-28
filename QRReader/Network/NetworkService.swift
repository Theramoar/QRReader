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
    
    func makeRequest(to url: URL, requestType type: RequestType, completion: @escaping (Data?) -> Void) {
        let request = createRequest(type: type, url: url)

        let task = createDataTask(from: request) { data, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
    }
    
    private func createUrl(from path: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = ""//API.scheme.rawValue
        components.host = ""//API.host.rawValue
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
    
    private func createRequest(type: RequestType, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        session.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
