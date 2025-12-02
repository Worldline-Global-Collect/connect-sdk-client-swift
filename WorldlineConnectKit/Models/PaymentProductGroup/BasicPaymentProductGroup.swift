//
//  BasicPaymentProductGroup.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class BasicPaymentProductGroup: BasicPaymentItem, Codable {

    public var identifier: String
    public var displayHints: PaymentItemDisplayHints
    public var accountsOnFile = AccountsOnFile()
    public var acquirerCountry: String?
    public var deviceFingerprintEnabled = false
    public var allowsInstallments = false

    public var stringFormatter: StringFormatter? {
        get { return accountsOnFile.accountsOnFile.first?.stringFormatter }
        set {
            if let stringFormatter = newValue {
                for accountOnFile in accountsOnFile.accountsOnFile {
                    accountOnFile.stringFormatter = stringFormatter
                }
            }
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id, displayHints, acquirerCountry, deviceFingerprintEnabled, allowsInstallments, accountsOnFile
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(String.self, forKey: .id)
        self.displayHints = try container.decode(PaymentItemDisplayHints.self, forKey: .displayHints)
        self.acquirerCountry = try? container.decodeIfPresent(String.self, forKey: .acquirerCountry)
        self.deviceFingerprintEnabled =
            (try container.decodeIfPresent(Bool.self, forKey: .deviceFingerprintEnabled)) ?? false
        self.allowsInstallments = (try container.decodeIfPresent(Bool.self, forKey: .allowsInstallments)) ?? false

        if let accountsOnFile = try? container.decodeIfPresent([AccountOnFile].self, forKey: .accountsOnFile) {
            for accountOnFile in accountsOnFile {
                self.accountsOnFile.accountsOnFile.append(accountOnFile)
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(identifier, forKey: .id)
        try? container.encode(displayHints, forKey: .displayHints)
        try? container.encodeIfPresent(acquirerCountry, forKey: .acquirerCountry)
        try? container.encode(deviceFingerprintEnabled, forKey: .deviceFingerprintEnabled)
        try? container.encode(allowsInstallments, forKey: .allowsInstallments)
        try? container.encode(accountsOnFile.accountsOnFile, forKey: .accountsOnFile)
    }

    public func accountOnFile(withIdentifier identifier: String) -> AccountOnFile? {
        return accountsOnFile.accountOnFile(withIdentifier: identifier)
    }
}
