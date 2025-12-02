//
//  DirectoryEntry.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class DirectoryEntry: Codable {
    public var issuerIdentifier: String
    public var issuerList: String
    public var issuerName: String
    public var countryNames: [String] = []

    private enum CodingKeys: String, CodingKey {
        case issuerId, issuerList, issuerName, countryNames
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.issuerIdentifier = try container.decode(String.self, forKey: .issuerId)
        self.issuerList = try container.decode(String.self, forKey: .issuerList)
        self.issuerName = try container.decode(String.self, forKey: .issuerName)
        self.countryNames = (try? container.decodeIfPresent([String].self, forKey: .countryNames)) ?? []
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(issuerIdentifier, forKey: .issuerId)
        try? container.encode(issuerList, forKey: .issuerList)
        try? container.encode(issuerName, forKey: .issuerName)
        try? container.encode(countryNames, forKey: .countryNames)
    }
}
