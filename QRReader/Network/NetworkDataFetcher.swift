//
//  NetworkDataFetcher.swift
//  QRReader
//
//  Created by MihailsKuznecovs on 28/01/2021.
//

import Foundation

enum NetworkAnswer: String {
    case successfulCheckIn = "Checked in!"
    case alreadyCheckedIn = "Already checked in!"
    case wrongAPIKey = "Please verify your API key is correctly entered on the settings page"
    case failure = "Something went wrong!"
}

class NetworkDataFetcher {
    private let network = NetworkService()
    private var userData: UserData = .shared
    
    func sendAPIKeyTo(url: String, completion: @escaping (NetworkAnswer, String?) -> Void) {
        let apiKeyQuery = "&api_key=" + userData.savedAPIKey
        let fullUrl = url + apiKeyQuery
        guard let url = URL(string: fullUrl) else {
            completion(.failure, "Incorrect URL")
            return
        }
        print(url)
        network.makeRequest(to: url, requestType: .get) { [weak self] data in
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: String] else {
                    completion(.failure, "Something went wrong!")
                    return
                }
                self?.checkReceivedResults(json, completion: completion)
            }
        }
    }
    
    
    private func checkReceivedResults(_ results: [String: String], completion: @escaping (NetworkAnswer, String?) -> Void) {
        if let status = results["status"] {
            if status == "1" {
                completion(.successfulCheckIn, results["msg"])
            } else if status == "2" {
                completion(.alreadyCheckedIn, results["msg"])
            } else {
                completion(.failure, nil)
            }
        } else if let securityCode = results["security_code"] {
            if securityCode == "1" {
                completion(.wrongAPIKey, nil)
            } else {
                completion(.failure, nil)
            }
        }
    }
}
