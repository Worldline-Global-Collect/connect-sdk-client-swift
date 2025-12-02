//
//  ValidatorFixedList.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class ValidatorFixedList: Validator, ValidationRule {
    public var allowedValues: [String] = []

    internal init(allowedValues: [String]) {
        self.allowedValues = allowedValues

        super.init(messageId: "fixedList", validationType: .fixedList)
    }

    private enum CodingKeys: String, CodingKey {
        case allowedValues
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let allowedValues = try? container.decodeIfPresent([String].self, forKey: .allowedValues) {
            self.allowedValues = allowedValues
        }

        super.init(messageId: "fixedList", validationType: .fixedList)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(allowedValues, forKey: .allowedValues)

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

        for allowedValue in allowedValues where allowedValue.isEqual(value) {
            return true
        }

        let error =
            ValidationErrorFixedList(
                errorMessage: self.messageId,
                paymentProductFieldId: fieldId,
                rule: self
            )
        errors.append(error)

        return false
    }
}
