//
//  ValueMappingItemTestCase.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 11/04/2017.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

import XCTest

@testable import WorldlineConnectKit

class ValueMappingItemTestCase: XCTestCase {

    func testExample() {
        let itemJSON = Data("""
        {
            "displayName": "displayName",
            "value": "value",
        }
        """.utf8)

        guard let item = try? JSONDecoder().decode(ValueMappingItem.self, from: itemJSON) else {
            XCTFail("Not a valid ValueMappingItem")
            return
        }

        XCTAssertTrue(item.displayName == "displayName", "Unexpected")
        XCTAssertTrue(item.value == "value", "Unexpected")
    }
}
