//
//  PaymentProductField.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class PaymentProductField: Codable {

    public var identifier: String
    public var usedForLookup: Bool = false
    public var dataRestrictions = DataRestrictions()
    public var displayHints: PaymentProductFieldDisplayHints?
    public var type: FieldType

    private var numberFormatter = NumberFormatter()
    private let stringFormatter = StringFormatter()

    public var errorMessageIds: [ValidationError] = []

    private enum CodingKeys: String, CodingKey {
        case id, displayHints, dataRestrictions, usedForLookup, type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(String.self, forKey: .id)
        self.displayHints = try container.decodeIfPresent(PaymentProductFieldDisplayHints.self, forKey: .displayHints)
        self.dataRestrictions =
            (try? container.decodeIfPresent(DataRestrictions.self, forKey: .dataRestrictions)) ?? DataRestrictions()
        self.usedForLookup = (try? container.decodeIfPresent(Bool.self, forKey: .usedForLookup)) ?? false
        self.type = (try? container.decodeIfPresent(FieldType.self, forKey: .type)) ?? .string

        self.numberFormatter.numberStyle = .decimal
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(identifier, forKey: .id)
        try? container.encodeIfPresent(displayHints, forKey: .displayHints)
        try? container.encode(dataRestrictions, forKey: .dataRestrictions)
        try? container.encode(usedForLookup, forKey: .usedForLookup)
        try? container.encode(type, forKey: .type)
    }

    public func validateValue(for request: PaymentRequest) -> [ValidationError] {
        guard let value = request.getValue(forField: identifier) else {
            return validateValue(value: "")
        }

        return validateValue(value: value)
    }

    public func validateValue(value: String) -> [ValidationError] {
        errorMessageIds.removeAll()

        if dataRestrictions.isRequired && value.isEqual("") {
            let error =
                ValidationErrorIsRequired(
                    errorMessage: "required",
                    paymentProductFieldId: identifier,
                    rule: nil
                )
            errorMessageIds.append(error)
        } else if dataRestrictions.isRequired ||
                    !value.isEqual("") ||
                    dataRestrictions.validators.variableRequiredness {
            for rule in dataRestrictions.validators.validators {
                _ = rule.validate(value: value, for: identifier)
                errorMessageIds.append(contentsOf: rule.errors)
            }
        }

        return errorMessageIds
    }

    public func applyMask(value: String) -> String {
        if let mask = displayHints?.mask {
            return stringFormatter.formatString(string: value, mask: mask)
        }

        return value
    }

    public func removeMask(value: String) -> String {
        if let mask = displayHints?.mask {
            return stringFormatter.unformatString(string: value, mask: mask)
        }

        return value
    }
}
