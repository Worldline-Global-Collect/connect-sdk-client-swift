//
//  ValidatorLuhnTestCase.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import XCTest
@testable import WorldlineConnectKit

class ValidatorLuhnTestCase: XCTestCase {

    let validator = ValidatorLuhn()

    func testValidateCorrect() {
        let isValid = validator.validate(value: "4242424242424242", for: "cardnumber")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidateIncorrect() {
        let isValid = validator.validate(value: "1111", for: "cardnumber")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }

}
