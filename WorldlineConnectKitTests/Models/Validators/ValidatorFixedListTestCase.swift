//
//  ValidatorFixedListTestCase.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import XCTest
@testable import WorldlineConnectKit

class ValidatorFixedListTestCase: XCTestCase {

    let validator = ValidatorFixedList.init(allowedValues: ["1"])

    func testValidateCorrect() {
        let isValid = validator.validate(value: "1", for: "fixedList")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidateIncorrect() {
        var isValid = validator.validate(value: "999", for: "fixedList")
        XCTAssertFalse(isValid)
        XCTAssertEqual(validator.errors.count, 1, "Invalid value considered valid")

        isValid = validator.validate(value: "X", for: "fixedList")
        XCTAssertFalse(isValid)
        XCTAssertEqual(validator.errors.count, 1, "Invalid value considered valid")
    }

}
