//
//  AccountOnFileAttributeStatus.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

public enum AccountOnFileAttributeStatus: String, Codable {
    case readOnly = "READ_ONLY"
    case canWrite = "CAN_WRITE"
    case mustWrite = "MUST_WRITE"
}
