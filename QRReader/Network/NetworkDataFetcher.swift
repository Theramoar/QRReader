//
//  NetworkDataFetcher.swift
//  QRReader
//
//  Created by MihailsKuznecovs on 28/01/2021.
//

import Foundation

enum NetworkAnswer: String {
    case successfulCheckIn = "Checked In!"
    case alreadyCheckedIn = "Already checked in!"
    case wrongAPIKey = "Please verify your API key is correctly entered on the settings page"
    case failure = "Something went wrong!"
}

class NetworkDataFetcher {
    private let network = NetworkService()
    private var userData: UserData = .shared
    
    func sendAPIKeyTo(url: String, completion: @escaping (NetworkAnswer, String?) -> Void) {
        guard let url = URL(string: url.withoutUrlEncoding()) else {
            completion(.failure, "Incorrect URL")
            return
        }
        
        guard let finalUrl = url.refactorForForAPIKey() else {
            completion(.failure, "Incorrect URL")
            return
        }
        network.makeRequest(to: finalUrl, requestType: .get) { [weak self] data, httpCode in
            if let data = data, let code = httpCode {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: String] else {
                    print("Could not read json")
                    completion(.failure, "Received incorrect message!")
                    return
                }
                
                self?.checkReceivedResults(json, httpStatus: code, completion: completion)
            }
        }
    }
    
    
    private func checkReceivedResults(_ results: [String: String], httpStatus: Int, completion: @escaping (NetworkAnswer, String?) -> Void) {
        switch httpStatus {
        case 201:
            completion(.successfulCheckIn, results["msg"])
        case 403:
            completion(.alreadyCheckedIn, results["msg"])
        case 400:
            completion(.wrongAPIKey, nil)
        default:
            completion(.failure, nil)
        }
    }
}
