//
//  ValidatorRegularExpressionTestCase.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import XCTest
@testable import WorldlineConnectKit

class ValidatorRegularExpressionTestCase: XCTestCase {

    var validator: ValidatorRegularExpression!

    override func setUp() {
        super.setUp()
        guard let regularExpression = try? NSRegularExpression(pattern: "\\d{3}") else {
            XCTFail("ValidatorRegularExpression setup failed")
            return
        }

        validator = ValidatorRegularExpression(regularExpression: regularExpression)
    }

    func testValidateCorrect() {
        let isValid = validator.validate(value: "123", for: "cardholderName")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidateIncorrect() {
        let isValid = validator.validate(value: "abc", for: "cardholderName")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }

}
