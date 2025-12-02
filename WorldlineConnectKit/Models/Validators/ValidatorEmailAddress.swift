//
//  ValidatorEmailAddress.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class ValidatorEmailAddress: Validator, ValidationRule {
    private let regexString = "^[^@\\.]+(\\.[^@\\.]+)*@([^@\\.]+\\.)*[^@\\.]+\\.[^@\\.][^@\\.]+$"
    public var expression: NSRegularExpression

    internal override init() {
        guard let regex = try? NSRegularExpression(pattern: regexString) else {
            fatalError("Could not create Regular Expression")
        }
        expression = regex

        super.init(messageId: "emailAddress", validationType: .emailAddress)
    }

    // periphery:ignore:parameters decoder
    public required init(from decoder: Decoder) throws {
        guard let regex = try? NSRegularExpression(pattern: regexString) else {
            fatalError("Could not create Regular Expression")
        }
        expression = regex

        super.init(messageId: "emailAddress", validationType: .emailAddress)
    }

    public func validate(field fieldId: String, in request: PaymentRequest) -> Bool {
        guard let fieldValue = request.getValue(forField: fieldId) else {
            return false
        }

        return validate(value: fieldValue, for: fieldId)
    }

    internal override func validate(value: String, for fieldId: String?) -> Bool {
        self.clearErrors()

        let numberOfMatches = expression.numberOfMatches(in: value, range: NSRange(location: 0, length: value.count))
        if numberOfMatches != 1 {
            let error =
                ValidationErrorEmailAddress(
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
