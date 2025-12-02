//
//  AccountOnFileAttribute.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class AccountOnFileAttribute: Codable {

    public var key: String
    public var value: String?
    public var status: AccountOnFileAttributeStatus
    public var mustWriteReason: String?

    public func isEditingAllowed() -> Bool {
        status != .readOnly
    }
}
