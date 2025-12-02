//
//  PaymentProductFieldDisplayHints.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class PaymentProductFieldDisplayHints: Codable {

    public var alwaysShow = false
    public var displayOrder: Int?
    public var formElement: FormElement
    public var mask: String?
    public var obfuscate = false
    public var placeholderLabel: String?
    public var tooltip: ToolTip?
    public var label: String?
    public var link: URL?
    public var preferredInputType: PreferredInputType = .noKeyboard

    private enum CodingKeys: String, CodingKey {
        case alwaysShow, displayOrder, formElement, mask, obfuscate, placeholderLabel, tooltip, label,
             link, preferredInputType
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.formElement = try container.decode(FormElement.self, forKey: .formElement)
        self.alwaysShow = (try? container.decodeIfPresent(Bool.self, forKey: .alwaysShow)) ?? false
        self.displayOrder = try? container.decodeIfPresent(Int.self, forKey: .displayOrder)
        self.mask = try? container.decodeIfPresent(String.self, forKey: .mask)
        self.obfuscate = (try? container.decodeIfPresent(Bool.self, forKey: .obfuscate)) ?? false
        self.placeholderLabel = try? container.decodeIfPresent(String.self, forKey: .placeholderLabel)
        self.label = try? container.decodeIfPresent(String.self, forKey: .label)
        if let linkString = try? container.decodeIfPresent(String.self, forKey: .link) {
            self.link = URL(string: linkString)
        }
        self.preferredInputType =
            (try? container.decodeIfPresent(PreferredInputType.self, forKey: .preferredInputType)) ?? .noKeyboard
        self.tooltip = try? container.decodeIfPresent(ToolTip.self, forKey: .tooltip)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(formElement, forKey: .formElement)
        try? container.encode(alwaysShow, forKey: .alwaysShow)
        try? container.encodeIfPresent(displayOrder, forKey: .displayOrder)
        try? container.encodeIfPresent(mask, forKey: .mask)
        try? container.encode(obfuscate, forKey: .obfuscate)
        try? container.encodeIfPresent(placeholderLabel, forKey: .placeholderLabel)
        try? container.encodeIfPresent(label, forKey: .label)
        try? container.encodeIfPresent(link?.absoluteString, forKey: .link)
        try? container.encode(preferredInputType.rawValue, forKey: .preferredInputType)
        try? container.encodeIfPresent(tooltip, forKey: .tooltip)
    }
}
