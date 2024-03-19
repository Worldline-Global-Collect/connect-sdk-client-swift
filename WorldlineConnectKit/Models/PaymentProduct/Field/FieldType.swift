//
//  Type.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

public enum FieldType: String, Codable {
    case string = "string"
    case integer = "integer"
    case expirationDate = "expirydate"
    case numericString = "numericstring"
    case boolString = "boolean"
    case dateString = "date"
}
