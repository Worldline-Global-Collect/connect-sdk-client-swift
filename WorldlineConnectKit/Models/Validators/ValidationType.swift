//
//  ValidationType.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 18/12/2023.
//  Copyright © 2023 Worldline Global Collect. All rights reserved.
//

import Foundation

public enum ValidationType: String, Codable {
    case expirationDate = "EXPIRATIONDATE"
    case emailAddress = "EMAILADDRESS"
    case fixedList = "FIXEDLIST"
    case iban = "IBAN"
    case length = "LENGTH"
    case luhn = "LUHN"
    case range = "RANGE"
    case regularExpression = "REGULAREXPRESSION"
    case required = "REQUIRED"
    case type = "TYPE"
    case boletoBancarioRequiredness = "BOLETOBANCARIOREQUIREDNESS"
    case termsAndConditions = "TERMSANDCONDITIONS"
    case residentIdNumber = "RESIDENTIDNUMBER"
}
