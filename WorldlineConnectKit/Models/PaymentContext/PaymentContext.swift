//
//  PaymentContext.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class PaymentContext: Decodable {
    public var countryCode: String
    @available(*, deprecated, message: "In a future release, this property will be removed. Use countryCode instead.")
    public var countryCodeString: String
    public var locale: String?
    public var forceBasicFlow: Bool?
    public var amountOfMoney: PaymentAmountOfMoney
    public var isRecurring: Bool

    public init(amountOfMoney: PaymentAmountOfMoney, isRecurring: Bool, countryCode: String) {
        self.amountOfMoney = amountOfMoney
        self.isRecurring = isRecurring
        self.countryCode = countryCode
        self.countryCodeString = countryCode

        if let languageCode = Locale.current.languageCode {
            self.locale = languageCode.appending("_")
        }
        if let regionCode = Locale.current.regionCode, self.locale != nil {
            self.locale = self.locale!.appending(regionCode)
        }
    }

    enum CodingKeys: CodingKey {
        case countryCode, forceBasicFlow, amountOfMoney, isRecurring
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let countryCode = try? container.decodeIfPresent(String.self, forKey: .countryCode) {
            self.countryCodeString = countryCode
            self.countryCode = countryCode
        } else {
            self.countryCodeString = "US"
            self.countryCode = "US"
        }

        if let forceBasicFlow = try? container.decodeIfPresent(Bool.self, forKey: .forceBasicFlow) {
            self.forceBasicFlow = forceBasicFlow
        }

        self.amountOfMoney = try container.decode(PaymentAmountOfMoney.self, forKey: .amountOfMoney)

        self.isRecurring = try container.decodeIfPresent(Bool.self, forKey: .isRecurring) ?? false

        if let languageCode = Locale.current.languageCode {
            self.locale = languageCode.appending("_")
        }
        if let regionCode = Locale.current.regionCode,
           let locale = self.locale {
            self.locale = locale.appending(regionCode)
        }
    }

    public var description: String {
        return "\(amountOfMoney.description)-\(countryCode)-\(isRecurring ? "YES" : "NO")"
    }
}
