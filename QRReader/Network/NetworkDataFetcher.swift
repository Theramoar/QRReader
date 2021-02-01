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
        network.makeRequest(to: finalUrl, requestType: .get) { [weak self] data in
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: String] else {
                    print("Could not read json")
                    completion(.failure, "Something went wrong!")
                    return
                }
                self?.checkReceivedResults(json, completion: completion)
            }
        }
    }
    
    
    private func checkReceivedResults(_ results: [String: String], completion: @escaping (NetworkAnswer, String?) -> Void) {
        if let msg = results["msg"] {
            switch msg {
            case NetworkAnswer.alreadyCheckedIn.rawValue:
                completion(.alreadyCheckedIn, msg)
            case NetworkAnswer.successfulCheckIn.rawValue:
                completion(.successfulCheckIn, msg)
            default:
                completion(.failure, nil)
            }
        }
        
        else if let _ = results["security_code"] {
            completion(.wrongAPIKey, nil)
        }
        else {
            completion(.failure, nil)
        }
    }
}
