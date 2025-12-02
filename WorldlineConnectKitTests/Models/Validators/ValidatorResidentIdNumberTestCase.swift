//
//  ValidatorResidentIdNumberTestCase.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 7/10/2020.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import XCTest
@testable import WorldlineConnectKit

class ValidatorResidentIdNumberTestCase: XCTestCase {

    let validator = ValidatorResidentIdNumber()

    // - MARK: Valid ID Tests

    func testValidate15CharacterId() {
        let isValid = validator.validate(value: "123456789101112", for: "residentIdNumber")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidate18CharacterId() {
        let isValid = validator.validate(value: "110101202009235416", for: "residentIdNumber")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    func testValidateIdEndingInX() {
        let isValid = validator.validate(value: "11010120200922993X", for: "residentIdNumber")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid value considered invalid")
    }

    // - MARK: Invalid ID Tests

    func test16CharacterId() {
        let isValid = validator.validate(value: "1234567890123451", for: "residentIdNumber")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }

    func test17CharacterId() {
        let isValid = validator.validate(value: "1234567890123451X", for: "residentIdNumber")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }

    func testValidateTooShortId() {
        let isValid = validator.validate(value: "1", for: "residentIdNumber")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }

    func testValidateTooLongId() {
        let isValid = validator.validate(value: "110101202009224733110101202009224733", for: "residentIdNumber")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }

    func testValidateInvalidChecksum() {
        let isValid = validator.validate(value: "110101202009224734", for: "residentIdNumber")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid value considered valid")
    }
}
