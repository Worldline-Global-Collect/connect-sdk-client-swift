//
//  DirectoryEntries.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class DirectoryEntries: Codable {
    public var directoryEntries: [DirectoryEntry] = []

    internal init() {}

    private enum CodingKeys: String, CodingKey {
        case entries
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.directoryEntries = (try? container.decodeIfPresent([DirectoryEntry].self, forKey: .entries)) ?? []
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(directoryEntries, forKey: .entries)
    }
}
