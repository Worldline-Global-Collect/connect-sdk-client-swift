//
//  ValidatorBoletoBancarioRequiredness.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

public class ValidatorBoletoBancarioRequiredness: Validator, ValidationRule {
    public var fiscalNumberLength: Int

    private enum CodingKeys: String, CodingKey {
        case fiscalNumberLength, fiscalNumberLengthToValidate
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let fiscalNumberLengthFromApi = try? container.decode(Int.self, forKey: .fiscalNumberLength) {
            self.fiscalNumberLength = fiscalNumberLengthFromApi
        } else {
            self.fiscalNumberLength = try container.decode(Int.self, forKey: .fiscalNumberLengthToValidate)
        }

        super.init(messageId: "fiscalNumberBoletoBancario", validationType: .boletoBancarioRequiredness)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(fiscalNumberLength, forKey: .fiscalNumberLengthToValidate)

        try? super.encode(to: encoder)
    }

    public func validate(field fieldId: String, in request: PaymentRequest) -> Bool {
        let fieldValue = request.getValue(forField: fieldId) ?? ""

        return validate(value: fieldValue, for: fieldId, in: request)
    }

    private func validate(value: String, for fieldId: String?, in request: PaymentRequest) -> Bool {
        self.clearErrors()

        let fiscalNumber = request.unmaskedValue(forField: "fiscalNumber")

        if fiscalNumber?.count == fiscalNumberLength && value.isEmpty {
            let error =
                ValidationErrorIsRequired(
                    errorMessage: "required",
                    paymentProductFieldId: fieldId,
                    rule: nil
                )
            errors.append(error)
            return false
        }

        return true
    }
}
