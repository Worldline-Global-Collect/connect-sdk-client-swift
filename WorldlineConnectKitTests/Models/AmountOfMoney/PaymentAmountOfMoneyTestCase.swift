//
//  PaymentAmountOfMoneyTestCase.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 11/04/2017.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

import XCTest
@testable import WorldlineConnectKit

class PaymentAmountOfMoneyTestCase: XCTestCase {

    func testPaymentAmountOfMoneyUnknown() {
        let amount = PaymentAmountOfMoney(totalAmount: 3, currencyCode: "EUR")
        XCTAssertEqual(amount.description, "3-EUR")
    }

}
