//
//  PaymentAmountOfMoney.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class PaymentAmountOfMoney: Decodable {
    public var totalAmount = 0
    public var currencyCode: String
    @available(*, deprecated, message: "In a future release, this property will be removed. Use currencyCode instead.")
    public var currencyCodeString: String

    public init(totalAmount: Int, currencyCode: String) {
        self.totalAmount = totalAmount
        self.currencyCode = currencyCode
        self.currencyCodeString = currencyCode
    }

    enum CodingKeys: CodingKey {
        case amount, currencyCode
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.totalAmount = try container.decode(Int.self, forKey: .amount)

        if let currencyCode = try? container.decodeIfPresent(String.self, forKey: .currencyCode) {
            self.currencyCodeString = currencyCode
            self.currencyCode = currencyCode
        } else {
            self.currencyCodeString = "USD"
            self.currencyCode = "USD"
        }
    }

    public var description: String {
        return "\(totalAmount)-\(currencyCode)"
    }

}
