//
//  PreparedPaymentRequest.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 06/04/2017.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

import XCTest
@testable import WorldlineConnectKit

class PreparedPaymentRequestTestCase: XCTestCase {

    func testPreparedPaymentRequest() {
        let encrypted = "encrypted"
        let meta = "Meta info"
        let request = PreparedPaymentRequest(encryptedFields: encrypted, encodedClientMetaInfo: meta)
        XCTAssertTrue(request.encodedClientMetaInfo == meta, "Meta info was incorrect.")
        XCTAssertTrue(request.encryptedFields == encrypted, "Encrypted was incorrect.")

        request.encryptedFields = "encrypted1"
        XCTAssertTrue(request.encryptedFields == "encrypted1", "Encrypted was incorrect.")
    }

}
