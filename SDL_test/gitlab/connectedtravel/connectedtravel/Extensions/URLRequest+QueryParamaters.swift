//
//  URLRequest+QueryParamaters.swift
//  connectedtravel
//
//  Created by Miha Hozjan on 07/11/2019.
//  Copyright © 2019 Tine Purg. All rights reserved.
//

import Foundation

extension URLRequest {

    /// Method for adding a Query parameter to the request
    ///
    /// - Parameters:
    ///     - key: Name of the parameter
    ///     - value: Value of the given parameter
    mutating func addQueryParameter(_ key: String, value: String) {
        if let url = self.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)


            // if query is already set
            var query: String = ""
            if let oldQuery = components?.query {
                query = oldQuery + "&"
            }

            query = query + key + "=" + value
            components?.query = query

            if let newURL = components?.url {
                self.url = newURL
            }
        }
    }
}
