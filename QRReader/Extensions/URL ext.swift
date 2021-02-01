//
//  URL ext.swift
//  QRReader
//
//  Created by Misha Kuznecov on 01/02/2021.
//

import Foundation

extension URL {
    var queryElements: [String: String] {
        var results = [String: String]()
        if let pairs = self.query?.components(separatedBy: "&"), pairs.count > 0 {
            for pair: String in pairs {
                if let keyValue = pair.components(separatedBy: "=") as [String]? {
                    if(keyValue.count > 1) {
                        results.updateValue(keyValue[1], forKey: keyValue[0])
                    }
                }
            }
        }
        return results
    }
    
    
    func refactorForForAPIKey() -> URL? {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.path = createNewPath()
        urlComponents.queryItems = createQueryItems()
        
        return urlComponents.url
    }
    
    
    private func createNewPath() -> String {
        var newPath = self.path
        
        var queryElements = self.queryElements
        
        if let pathComponent = queryElements["path"] {
            newPath += "/\(pathComponent)"
            queryElements.removeValue(forKey: "path")
        }
        return newPath
    }
    
    private func createQueryItems() -> [URLQueryItem] {
        var queryElements = self.queryElements
        queryElements["api_key"] = UserData.shared.savedAPIKey
        let queryItemNames = ["event_id", "security_code", "ticket_id", "api_key"]
        var queryItems = [URLQueryItem]()
        
        for name in queryItemNames {
            queryItems.append(URLQueryItem(name: name, value: queryElements[name]))
        }
        return queryItems
    }
    
}
