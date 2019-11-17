//
//  APIManager.swift
//  connectedtravel
//
//  Created by Miha Hozjan on 07/11/2019.
//  Copyright © 2019 Tine Purg. All rights reserved.
//

import UIKit

enum APIError: Error {
    case invalidURL
    case http(Int)
    case generalError
    case empty
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Error: Invalid URL"

        case .http(let status):
            return "Error: HTTP \(status)"

        case .generalError:
            return "Unknown Error"

        case .empty:
            return "No results found"
        }
    }
}

// Ticketmaster Key
#warning("ENTER YOUR TICKETMASTER API KEY")
fileprivate let ticketmasterKey = "7FDHQhlPd0e5aFWJcCRQonYtuKwlksZu"

class APIManager {

    class func getEvents(_ completion: @escaping (Result<Events, Error>) -> ()) {
        guard let url = URL(string: "https://app.ticketmaster.com/discovery/v2/events.json") else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        request.addQueryParameter("countryCode", value: "US")
        request.addQueryParameter("apikey", value: ticketmasterKey)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Events.self, from: data)
                    if result.items.isEmpty {
                        completion(.failure(APIError.empty))
                    } else {
                        completion(.success(result))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            } else if let response = (response as? HTTPURLResponse) {
                completion(.failure(APIError.http(response.statusCode)))
            } else {
                completion(.failure(APIError.generalError))
            }
        }.resume()
    }
    
    
    class func getParkings(_ completion: @escaping (Result<Parkings, Error>) -> ()) {
        guard let url = URL(string: "https://api.parkwhiz.com/v4/quotes") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        request.addQueryParameter("q", value: "coordinates:41.878,-87.626 distance:10")
        request.addQueryParameter("start_time", value: "2015-11-22T16:35:28-06:00")
        request.addQueryParameter("end_time", value: "2015-11-22T19:35:44-06:00")
        request.addQueryParameter("returns", value: "offstreet_bookable")
        
       URLSession.shared.dataTask(with: request) { (data, response, error) in
           if let data = data {
                do {
                    let result = try JSONDecoder().decode(Parkings.self, from: data)
                    if result.isEmpty {
                        completion(.failure(APIError.empty))
                    } else {
                        completion(.success(result))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            } else if let response = (response as? HTTPURLResponse) {
                completion(.failure(APIError.http(response.statusCode)))
            } else {
                completion(.failure(APIError.generalError))
            }
        }.resume()
    }
}
