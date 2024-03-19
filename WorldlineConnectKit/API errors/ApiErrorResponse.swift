//
//  ApiErrorResponse.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 22/11/2023.
//  Copyright © 2023 Worldline Global Collect. All rights reserved.
//

import Foundation

public class ApiErrorResponse: NSObject, Codable {
    public let errorId: String
    public let errors: [ApiErrorItem]
}
