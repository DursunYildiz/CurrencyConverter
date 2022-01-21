//
//  Extensions.swift
//  CurrencyConverter
//
//  Created by A101Mac on 20.01.2022.
//

import Foundation
import SwiftUI
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}


extension ApiPath {
 

    func withBaseUrl(baseUrl : BaseUrls) -> String {
      
        return "\(baseUrl.rawValue)/\(rawValue)"
    }

}
extension HTTPURLResponse {
    var status: HTTPStatusCode? {
        return HTTPStatusCode(rawValue: statusCode)
    }
}
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
extension Color {

    static var backg: Color { return Color(UIColor.backg) }

}

// MARK: UICOLOR

extension UIColor {
  
    static var backg: UIColor { return UIColor(named: "Background")! }
 
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        windows
            .filter { $0.isKeyWindow }
            .first?
            .endEditing(force)
    }
}
extension String {
    func convertMoney (money:String) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency

        currencyFormatter.currencyCode =  money
        currencyFormatter.currencySymbol = ""
        
        
        return  currencyFormatter.string(from: NSNumber(value: Double(self) ?? 0)) ?? String(format: "%.2f", Double(self) ?? 0)
     
    
}
}
