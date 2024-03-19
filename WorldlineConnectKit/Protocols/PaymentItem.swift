//
//  PaymentItem.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public protocol PaymentItem: BasicPaymentItem {
    var fields: PaymentProductFields { get set }

    func paymentProductField(withId paymentProductFieldId: String) -> PaymentProductField?
}
