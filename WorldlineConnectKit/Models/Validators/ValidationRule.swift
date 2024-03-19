//
//  ValidationRule.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 18/12/2023.
//  Copyright © 2023 Worldline Global Collect. All rights reserved.
//

import Foundation

public protocol ValidationRule {
    func validate(field fieldId: String, in request: PaymentRequest) -> Bool
}
