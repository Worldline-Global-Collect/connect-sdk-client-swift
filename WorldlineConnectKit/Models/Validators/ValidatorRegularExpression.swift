//
//  ValidatorRegularExpression.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class ValidatorRegularExpression: Validator, ValidationRule {

    public var regularExpression: NSRegularExpression

    internal init(regularExpression: NSRegularExpression) {
        self.regularExpression = regularExpression

        super.init(messageId: "regularExpression", validationType: .regularExpression)
    }

    private enum CodingKeys: String, CodingKey {
        case regularExpression, regex
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let regularExpressionInput = try?
                container.decodeIfPresent(String.self, forKey: .regularExpression) ??
                container.decodeIfPresent(String.self, forKey: .regex),
              let regularExpression = try? NSRegularExpression(pattern: regularExpressionInput) else {
            throw ConnectSDKError.invalidRegularExpression
        }
        self.regularExpression = regularExpression

        super.init(messageId: "regularExpression", validationType: .regularExpression)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(regularExpression.pattern, forKey: .regex)

        try? super.encode(to: encoder)
    }

    public func validate(field fieldId: String, in request: PaymentRequest) -> Bool {
        guard let fieldValue = request.getValue(forField: fieldId) else {
            return false
        }

        return validate(value: fieldValue, for: fieldId)
    }

    internal override func validate(value: String, for fieldId: String?) -> Bool {
        self.clearErrors()

        let numberOfMatches =
            regularExpression.numberOfMatches(in: value, range: NSRange(location: 0, length: value.count))
        if numberOfMatches != 1 {
            let error =
                ValidationErrorRegularExpression(
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
