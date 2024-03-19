//
//  PaymentConfiguration.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 24/11/2023.
//  Copyright © 2023 Worldline Global Collect. All rights reserved.
//

public class PaymentConfiguration: Decodable {
    public let paymentContext: PaymentContext
    public let groupPaymentProducts: Bool

    public init(paymentContext: PaymentContext, groupPaymentProducts: Bool = false) {
        self.paymentContext = paymentContext
        self.groupPaymentProducts = groupPaymentProducts
    }
}
