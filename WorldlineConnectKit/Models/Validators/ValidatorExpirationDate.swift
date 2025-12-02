//
//  ValidatorExpirationDate.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class ValidatorExpirationDate: Validator, ValidationRule {
    private let gregorianCalendar = Calendar(identifier: .gregorian)
    public var dateFormatter = DateFormatter()
    private var fullYearDateFormatter = DateFormatter()
    private var monthAndFullYearDateFormatter = DateFormatter()

    internal override init() {
        dateFormatter.dateFormat = "MMyy"
        dateFormatter.calendar = gregorianCalendar

        fullYearDateFormatter.dateFormat = "yyyy"
        fullYearDateFormatter.calendar = gregorianCalendar

        monthAndFullYearDateFormatter.dateFormat = "MMyyyy"
        monthAndFullYearDateFormatter.calendar = gregorianCalendar

        super.init(messageId: "expirationDate", validationType: .expirationDate)
    }

    // periphery:ignore:parameters decoder
    public required init(from decoder: Decoder) throws {
        dateFormatter.dateFormat = "MMyy"
        dateFormatter.calendar = gregorianCalendar

        fullYearDateFormatter.dateFormat = "yyyy"
        fullYearDateFormatter.calendar = gregorianCalendar

        monthAndFullYearDateFormatter.dateFormat = "MMyyyy"
        monthAndFullYearDateFormatter.calendar = gregorianCalendar

        super.init(messageId: "expirationDate", validationType: .expirationDate)
    }

    public func validate(field fieldId: String, in request: PaymentRequest) -> Bool {
        guard let fieldValue = request.getValue(forField: fieldId) else {
            return false
        }

        return validate(value: fieldValue, for: fieldId)
    }

    internal override func validate(value: String, for fieldId: String?) -> Bool {
        self.clearErrors()

        if value.isEmpty || value.count != 4 {
            addExpirationDateError(fieldId: fieldId)
            return false
        }

        // Test whether the date can be parsed normally
        guard dateFormatter.date(from: value) != nil else {
            addExpirationDateError(fieldId: fieldId)
            return false
        }

        let enteredDate = obtainEnteredDateFromValue(value: value, fieldId: fieldId)

        let currentDateComponents = self.gregorianCalendar.dateComponents([.year, .month], from: Date())

        guard let currentDate = self.gregorianCalendar.date(from: currentDateComponents),
              let futureDate = obtainFutureDate(basedOn: currentDate) else {
            addExpirationDateError(fieldId: fieldId)
            return false
        }

        if !validateDateIsBetween(now: currentDate, futureDate: futureDate, dateToValidate: enteredDate) {
            addExpirationDateError(fieldId: fieldId)
            return false
        }

        return true
    }

    private func addExpirationDateError(fieldId: String?) {
        let error =
            ValidationErrorExpirationDate(
                errorMessage: self.messageId,
                paymentProductFieldId: fieldId,
                rule: self
            )
        errors.append(error)
    }

    internal func obtainEnteredDateFromValue(value: String, fieldId: String?) -> Date {
        let year = fullYearDateFormatter.string(from: Date())
        let valueWithCentury = value.substring(to: 2) + year.substring(to: 2) + value.substring(from: 2)
        guard let dateMonthAndFullYear = monthAndFullYearDateFormatter.date(from: valueWithCentury) else {
            addExpirationDateError(fieldId: fieldId)
            return Date()
        }

        return dateMonthAndFullYear
    }

    private func obtainFutureDate(basedOn currentDate: Date) -> Date? {
        var componentsForFutureDate = DateComponents()
        componentsForFutureDate.year = self.gregorianCalendar.component(.year, from: currentDate) + 25

        return self.gregorianCalendar.date(from: componentsForFutureDate)
    }

    internal func validateDateIsBetween(now: Date, futureDate: Date, dateToValidate: Date) -> Bool {
        let lowerBoundComparison = self.gregorianCalendar.compare(now, to: dateToValidate, toGranularity: .month)
        if lowerBoundComparison == ComparisonResult.orderedDescending {
            return false
        }

        let upperBoundComparison = self.gregorianCalendar.compare(futureDate, to: dateToValidate, toGranularity: .year)
        if upperBoundComparison == ComparisonResult.orderedAscending {
            return false
        }

        return true
    }
}
