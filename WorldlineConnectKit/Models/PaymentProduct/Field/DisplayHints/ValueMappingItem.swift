//
//  ValueMappingItem.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class ValueMappingItem: Codable {

    public var displayName: String?
    public var displayElements: [DisplayElement] = []
    public var value: String

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(String.self, forKey: .value)

        self.displayElements = (try? container.decodeIfPresent([DisplayElement].self, forKey: .displayElements)) ?? []

        if let displayName = try? container.decodeIfPresent(String.self, forKey: .displayName) {
            self.displayName = displayName
            if self.displayElements.filter({ $0.id == "displayName" }).count == 0 && displayName != "" {
                let newElement = DisplayElement(id: "displayName", type: .string, value: displayName)
                self.displayElements.append(newElement)
            }
        } else {
            let displayNames = self.displayElements.filter { $0.id == "displayName" }
            if displayNames.count > 0 {
                self.displayName = displayNames.first?.value
            }
        }
    }
}
