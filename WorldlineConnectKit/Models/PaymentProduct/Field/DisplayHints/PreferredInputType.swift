//
//  PreferredInputType.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

public enum PreferredInputType: String, Codable {
    case stringKeyboard = "StringKeyboard"
    case integerKeyboard = "IntegerKeyboard"
    case emailAddressKeyboard = "EmailAddressKeyboard"
    case phoneNumberKeyboard = "PhoneNumberKeyboard"
    case dateKeyboard = "DateKeyboard"
    case noKeyboard = "NoKeyboard"
}
