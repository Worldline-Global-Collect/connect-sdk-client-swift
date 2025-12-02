//
//  ValidatorEmailAddressTestCase.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import XCTest
@testable import WorldlineConnectKit

class ValidatorEmailAddressTestCase: XCTestCase {

    let validator = ValidatorEmailAddress()

    func testValidateCorrect1() {
        let isValid = validator.validate(value: "test@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateCorrect3() {
        let isValid = validator.validate(value: "\"Fred Bloggs\"@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateCorrect4() {
        let isValid = validator.validate(value: "\"Joe\\Blow\"@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateCorrect6() {
        let isValid = validator.validate(value: "customer/department=shipping@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateCorrect7() {
        let isValid = validator.validate(value: "$A12345@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateCorrect8() {
        let isValid = validator.validate(value: "!def!xyz%abc@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateCorrect9() {
        let isValid = validator.validate(value: "_somename@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateCorrect10() {
        let isValid = validator.validate(value: "\"b(c)d,e:f;g<h>i[j\\k]l@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateCorrect11() {
        let isValid = validator.validate(value: "just\"not\"right@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateCorrect12() {
        let isValid = validator.validate(value: "this is\"not\"allowed@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateCorrect13() {
        let isValid = validator.validate(value: "this\\ still\"not\\allowed@example.com", for: "email")
        XCTAssertTrue(isValid)
        XCTAssertEqual(validator.errors.count, 0, "Valid address is considered invalid")
    }

    func testValidateIncorrect1() {
        let isValid = validator.validate(value: "Abc.example.com", for: "email")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid address is considered valid")
    }

    func testValidateIncorrect2() {
        let isValid = validator.validate(value: "A@b@c@example.com", for: "email")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid address is considered valid")
    }

    func testValidateIncorrect7() {
        let isValid = validator.validate(value: "\"Abc@def\"@example.com", for: "email")
        XCTAssertFalse(isValid)
        XCTAssertNotEqual(validator.errors.count, 0, "Invalid address is considered valid")
    }
}
