//
//  Events.swift
//  connectedtravel
//
//  Created by Miha Hozjan on 07/11/2019.
//  Copyright © 2019 Tine Purg. All rights reserved.
//

import Foundation

// MARK: - Events
struct Events: Codable {
    private let embedded: EventsEmbedded

    var items: [Event] {
        return embedded.events
    }

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

// MARK: - EventsEmbedded
struct EventsEmbedded: Codable {
    let events: [Event]
}

// MARK: - Event
struct Event: Codable {
    let name: String
    let type: String
    let id: String
    let url: String
}
