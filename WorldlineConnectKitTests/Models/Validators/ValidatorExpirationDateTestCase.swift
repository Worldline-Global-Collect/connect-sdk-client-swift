//
//  ValidatorExpirationDateTestCase.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import XCTest
@testable import WorldlineConnectKit

class ValidatorExpirationDateTestCase: XCTestCase {

    let gregorianCalendar = Calendar(identifier: .gregorian)
    let validator = ValidatorExpirationDate()

    func testValid() {
        let isValid = validator.validate(value: "1244", for: "expiryDate")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid expiration date considered invalid")
    }

    func testInvalidEmptyString() {
        let isValid = validator.validate(value: "", for: "expiryDate")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered invalid")
    }

    func testInvalidLength() {
        let isValid = validator.validate(value: "13", for: "expiryDate")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered invalid")
    }

    func testInvalidNonNumerical() {
        let isValid = validator.validate(value: "aaaa", for: "expiryDate")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidPartiallyNonNumerical() {
        let isValid = validator.validate(value: "12ab", for: "expiryDate")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidMonth() {
        let isValid = validator.validate(value: "1350", for: "expiryDate")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidYearTooEarly() {
        let isValid = validator.validate(value: "0112", for: "expiryDate")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidYearTooLate() {
        let isValid = validator.validate(value: "1299", for: "expiryDate")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidInputTooLong() {
        let isValid = validator.validate(value: "122044", for: "expiryDate")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidWhitespace() {
        let isValid = validator.validate(value: "12 30", for: "expiryDate")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidSpecialCharacters() {
        let isValid = validator.validate(value: "12-30", for: "expiryDate")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    private var now: Date {
        var components = DateComponents()
        components.year = 2018
        components.month = 9
        components.day = 23
        return self.gregorianCalendar.date(from: components)!
    }

    private var futureDate: Date {
        var components = DateComponents()
        components.year = 2033
        components.month = 9
        components.day = 23
        return self.gregorianCalendar.date(from: components)!
    }

    func testValidLowerSameMonthAndYear() {
        var components = DateComponents()
        components.year = 2018
        components.month = 9
        let testDate = self.gregorianCalendar.date(from: components)!

        XCTAssertTrue(validator.validateDateIsBetween(now: now, futureDate: futureDate, dateToValidate: testDate))
    }

    func testValidLowerNextMonth() {
        var components = DateComponents()
        components.year = 2018
        components.month = 10
        let testDate = self.gregorianCalendar.date(from: components)!

        XCTAssertTrue(validator.validateDateIsBetween(now: now, futureDate: futureDate, dateToValidate: testDate))
    }

    func testInValidLowerMonth() {
        var components = DateComponents()
        components.year = 2018
        components.month = 8
        let testDate = self.gregorianCalendar.date(from: components)!

        XCTAssertFalse(validator.validateDateIsBetween(now: now, futureDate: futureDate, dateToValidate: testDate))
    }

    func testInValidLowerYear() {
        var components = DateComponents()
        components.year = 2017
        components.month = 9
        let testDate = self.gregorianCalendar.date(from: components)!

        XCTAssertFalse(validator.validateDateIsBetween(now: now, futureDate: futureDate, dateToValidate: testDate))
    }

    func testValidUpperSameMonthAndYear() {
        var components = DateComponents()
        components.year = 2033
        components.month = 9
        let testDate = self.gregorianCalendar.date(from: components)!

        XCTAssertTrue(validator.validateDateIsBetween(now: now, futureDate: futureDate, dateToValidate: testDate))
    }

    func testValidUpperHigherMonthSameYear() {
        var components = DateComponents()
        components.year = 2033
        components.month = 11
        let testDate = self.gregorianCalendar.date(from: components)!

        XCTAssertTrue(validator.validateDateIsBetween(now: now, futureDate: futureDate, dateToValidate: testDate))
    }

    func testInValidUpperHigherYear() {
        var components = DateComponents()
        components.year = 2034
        components.month = 1
        let testDate = self.gregorianCalendar.date(from: components)!

        XCTAssertFalse(validator.validateDateIsBetween(now: now, futureDate: futureDate, dateToValidate: testDate))
    }

    func testInValidUpperMuchHigherYear() {
        var components = DateComponents()
        components.year = 2099
        components.month = 1
        let testDate = self.gregorianCalendar.date(from: components)!

        XCTAssertFalse(validator.validateDateIsBetween(now: now, futureDate: futureDate, dateToValidate: testDate))
    }

    /*
     To test calendars other than Gregorian,
     you will need to change the region / calendar of the simulator on which you run the unit tests.
     */
    func testValidationAlternativeCalendars() {
        // Valid expiration date
        var isValid = validator.validate(value: "1226", for: nil)
        XCTAssertTrue(isValid)
        XCTAssertTrue(
            validator.errors.count == 0,
            "Valid expiration date should pass validation with alternative calendar"
        )

        // Invalid expiration date - past
        isValid = validator.validate(value: "0324", for: nil)
        XCTAssertFalse(isValid)
        XCTAssertTrue(
            validator.errors.count > 0,
            "Expired date should fail validation with alternative calendar"
        )

        // Invalid expiration date - future
        isValid = validator.validate(value: "1290", for: nil)
        XCTAssertFalse(isValid)
        XCTAssertTrue(
            validator.errors.count > 0,
            "Date beyond limit should fail validation with alternative calendar"
        )
    }
}
