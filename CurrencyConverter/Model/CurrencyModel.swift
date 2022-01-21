//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by A101Mac on 20.01.2022.
//

import Foundation
struct CurrencyModel: Codable  {

    
    let success: Bool?
    let timestamp: Int?
    let base, date: String?
    let rates: [String: Double]?
}
