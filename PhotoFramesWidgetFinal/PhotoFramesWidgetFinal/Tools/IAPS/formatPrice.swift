//
//  appleprice.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 12/27/20.
//

import Foundation
import StoreKit

extension SKProduct {
    func getFormattedPrice() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
}
