//
//  ResponseObjectSerializable.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "In a future release, this protocol will be removed.")
public protocol ResponseObjectSerializable {
    init?(json: [String: Any])
}
