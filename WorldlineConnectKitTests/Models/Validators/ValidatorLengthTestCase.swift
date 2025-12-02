//
//  ValidatorLengthTestCase.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import XCTest
@testable import WorldlineConnectKit

class ValidatorLengthTestCase: XCTestCase {

    let validator = ValidatorLength(minLength: 1, maxLength: 3)

    func testValidateCorrect1() {
        let isValid = validator.validate(value: "1", for: "ccv")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidateCorrect2() {
        let isValid = validator.validate(value: "12", for: "ccv")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidateCorrect3() {
        let isValid = validator.validate(value: "123", for: "ccv")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidateIncorrect1() {
        let isValid = validator.validate(value: "", for: "ccv")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }

    func testValidateIncorrect2() {
        let isValid = validator.validate(value: "1234", for: "ccv")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }

}
