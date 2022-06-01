//
//  MockSKProduct.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 12/27/20.
//

import StoreKit

class MockSKProductSubscriptionPeriod: SKProductSubscriptionPeriod {
    private let _numberOfUnits: Int
    private let _unit: SKProduct.PeriodUnit

    init(numberOfUnits: Int = 1, unit: SKProduct.PeriodUnit = .year) {
        _numberOfUnits = numberOfUnits
        _unit = unit
    }

    override var numberOfUnits: Int {
        self._numberOfUnits
    }

    override var unit: SKProduct.PeriodUnit {
        self._unit
    }
}

class MockSKProduct: SKProduct {
    private var _priceLocal: Locale
    private var _price: NSDecimalNumber

    init(priceLocal: Locale = .current, price: NSDecimalNumber = 0.99) {
        _priceLocal = priceLocal
        _price = price
    }

    override var priceLocale: Locale {
        get {
            _priceLocal
        }
    }
    
    override var price: NSDecimalNumber {
        get {
            _price
        }
    }
}
