//
//  PaymentItemDisplayHints.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation
import UIKit

public class PaymentItemDisplayHints: Codable {

    public var displayOrder: Int?
    public var label: String?
    public var logoPath: String
    public var logoImage: UIImage?

    private enum CodingKeys: String, CodingKey {
        case displayOrder, label, logo
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try? container.decodeIfPresent(String.self, forKey: .label)
        self.logoPath = try container.decode(String.self, forKey: .logo)
        self.displayOrder = try? container.decodeIfPresent(Int.self, forKey: .displayOrder)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encodeIfPresent(label, forKey: .label)
        try? container.encode(logoPath, forKey: .logo)
        try? container.encodeIfPresent(displayOrder, forKey: .displayOrder)
    }
}
