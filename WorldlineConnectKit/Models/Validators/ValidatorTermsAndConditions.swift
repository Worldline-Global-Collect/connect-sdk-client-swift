//
//  ValidatorEmailAddress.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 09/01/2018.
//  Copyright © 2018 Worldline Global Collect. All rights reserved.
//

import Foundation

public class ValidatorTermsAndConditions: Validator, ValidationRule {
    internal override init() {
        super.init(messageId: "termsAndConditions", validationType: .termsAndConditions)
    }

    // periphery:ignore:parameters decoder
    public required init(from decoder: Decoder) throws {
        super.init(messageId: "termsAndConditions", validationType: .termsAndConditions)
    }

    public func validate(field fieldId: String, in request: PaymentRequest) -> Bool {
        guard let fieldValue = request.getValue(forField: fieldId) else {
            return false
        }

        return validate(value: fieldValue, for: fieldId)
    }

    internal override func validate(value: String, for fieldId: String?) -> Bool {
        self.clearErrors()

        if !(Bool(value) ?? false) {
            let error =
                ValidationErrorTermsAndConditions(
                    errorMessage: self.messageId,
                    paymentProductFieldId: fieldId,
                    rule: self
                )
            errors.append(error)

            return false
        }

        return true
    }
}
