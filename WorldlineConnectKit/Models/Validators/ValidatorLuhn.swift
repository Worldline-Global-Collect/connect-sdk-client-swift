//
//  ValidatorLuhn.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class ValidatorLuhn: Validator, ValidationRule {
    internal override init() {
        super.init(messageId: "luhn", validationType: .luhn)
    }

    // periphery:ignore:parameters decoder
    public required init(from decoder: Decoder) throws {
        super.init(messageId: "luhn", validationType: .luhn)
    }

    public func validate(field fieldId: String, in request: PaymentRequest) -> Bool {
        guard let fieldValue = request.getValue(forField: fieldId) else {
            return false
        }

        return validate(value: fieldValue, for: fieldId)
    }

    internal override func validate(value: String, for fieldId: String?) -> Bool {
        self.clearErrors()

        if modulo(of: value, modulo: 10) != 0 {
            let error =
                ValidationErrorLuhn(
                    errorMessage: self.messageId,
                    paymentProductFieldId: fieldId,
                    rule: self
                )
            errors.append(error)

            return false
        }

        return true
    }

    private func modulo(of value: String, modulo: Int) -> Int {
        var evenSum = 0
        var oddSum = 0

        for index in 1 ... value.count {
            let reversedIndex = value.count - index
            guard var digit = Int(value[reversedIndex]) else {
                return 1
            }

            if index % 2 == 1 {
                evenSum += digit
            } else {
                digit *= 2
                digit = (digit % 10) + (digit / 10)
                oddSum += digit
            }
        }

        let total = evenSum + oddSum
        return total % modulo
    }
}
