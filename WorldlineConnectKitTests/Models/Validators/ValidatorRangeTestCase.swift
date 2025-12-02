//
//  ValidatorRangeTestCase.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import XCTest
@testable import WorldlineConnectKit

class ValidatorRangeTestCase: XCTestCase {

    let validator = ValidatorRange(minValue: 40, maxValue: 50)

    func testValidateCorrect1() {
        let isValid = validator.validate(value: "40", for: "ccv")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidateCorrect2() {
        let isValid = validator.validate(value: "45", for: "ccv")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidateCorrect3() {
        let isValid = validator.validate(value: "50", for: "ccv")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidateIncorrect1() {
        let isValid = validator.validate(value: "aaa", for: "ccv")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }

    func testValidateIncorrect2() {
        let isValid = validator.validate(value: "39", for: "ccv")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }

    func testValidateIncorrect3() {
        let isValid = validator.validate(value: "51", for: "ccv")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }
}
