//
//  Parkings.swift
//  connectedtravel
//
//  Created by Tine Purg on 07/11/2019.
//  Copyright © 2019 Tine Purg. All rights reserved.
//
import Foundation

typealias Parkings = [Parking]


// MARK: - Parking
struct Parking: Codable {
    private let embedded: Embedded
    private let purchaseOptions: [PurchaseOption]
    
    var name: String {
        embedded.pwLocation.name
    }
    var usd:String{
        purchaseOptions.first?.basePrice.usd ?? "10.00$"
    }
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case purchaseOptions = "purchase_options"
    }
    
}

// MARK: - Embedded
struct Embedded: Codable {
    let pwLocation: PwLocation
    
    enum CodingKeys: String, CodingKey {
        case pwLocation = "pw:location"
    }
}


// MARK: - PwLocation
struct PwLocation: Codable {
    let id, name, address1: String
}

struct PurchaseOption:Codable {
    let basePrice, price: BasePriceClass
    
    enum CodingKeys: String, CodingKey {
        case basePrice = "base_price"
        case price
    }
    
}

// MARK: - BasePriceClass
struct BasePriceClass: Codable {
    let usd: String

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}



