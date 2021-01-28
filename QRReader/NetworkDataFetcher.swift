//
//  NetworkDataFetcher.swift
//  QRReader
//
//  Created by MihailsKuznecovs on 28/01/2021.
//

import Foundation

enum NetworkAnswer {
    case succesfulCheckIn
    case alreadyCheckedIn
    case wrongAPIKey
    case failure
}

struct APIDummies {
    let wrongAPIKey = "b7c85140"
    let correctAPIKey = "b7c85141"
}

class NetworkDataFetcher {
    private let network = NetworkService()
    
    func sendAPIKeyTo(url: String, completion: @escaping (NetworkAnswer) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure)
            return
        }
        network.makeRequest(to: url, requestType: .get) { data in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(json)
            }
        }
    }
    
}
