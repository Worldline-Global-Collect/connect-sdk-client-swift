//
//  FormElement.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class FormElement: Codable {
    public var type: FormElementType
    public var valueMapping = [ValueMappingItem]()

    private enum CodingKeys: String, CodingKey {
        case type, valueMapping
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(FormElementType.self, forKey: .type)

        self.valueMapping =
            (try? container.decodeIfPresent([ValueMappingItem].self, forKey: .valueMapping)) ?? [ValueMappingItem]()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(type.rawValue, forKey: .type)
        try? container.encode(valueMapping, forKey: .valueMapping)
    }
}
