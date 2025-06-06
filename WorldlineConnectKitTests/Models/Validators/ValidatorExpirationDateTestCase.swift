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
    var request: PaymentRequest!

    override func setUp() {
        super.setUp()

        let paymentProductJSON = Data("""
        {
            "fields": [
                {
                    "id": "expiryDate",
                    "type": "expirydate",
                    "displayHints": {
                        "displayOrder": 0,
                        "formElement": {}
                    }
                }
            ],
            "id": 1,
            "paymentMethod": "card",
            "displayHints": {
                "displayOrder": 20,
                "label": "Visa",
                "logo": "/templates/master/global/css/img/ppimages/pp_logo_1_v1.png"
            },
            "usesRedirectionTo3rdParty": false
        }
        """.utf8)

        guard let paymentProduct = try? JSONDecoder().decode(PaymentProduct.self, from: paymentProductJSON) else {
            XCTFail("Not a valid PaymentProduct")
            return
        }

        request = PaymentRequest(paymentProduct: paymentProduct)
    }

    func testValid() {
        validator.validate(value: "1244", for: request)
        XCTAssertEqual(validator.errors.count, 0, "Valid expiration date considered invalid")
    }

    func testInvalidEmptyString() {
        validator.validate(value: "", for: request)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered invalid")
    }

    func testInvalidLength() {
        validator.validate(value: "13", for: request)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered invalid")
    }

    func testInvalidNonNumerical() {
        validator.validate(value: "aaaa", for: request)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidPartiallyNonNumerical() {
        validator.validate(value: "12ab", for: request)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidMonth() {
        validator.validate(value: "1350", for: request)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidYearTooEarly() {
        validator.validate(value: "0112", for: request)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidYearTooLate() {
        validator.validate(value: "1299", for: request)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidInputTooLong() {
        validator.validate(value: "122044", for: request)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidWhitespace() {
        validator.validate(value: "12 30", for: request)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid expiration date considered valid")
    }

    func testInvalidSpecialCharacters() {
        validator.validate(value: "12-30", for: request)
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
