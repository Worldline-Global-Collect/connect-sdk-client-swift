//
//  PaymentProduct302SpecificData.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 20/09/2018.
//  Copyright © 2018 Worldline Global Collect. All rights reserved.
//

import Foundation

public class PaymentProduct302SpecificData: Codable {
    public var networks: [String] = []

    @available(*, deprecated, message: "In a future release, this initializer will be removed.")
    public required init?(json: [String: Any]) {
        if let networks = json["networks"] as? [String] {
            self.networks = networks
        }
    }

    private enum CodingKeys: String, CodingKey {
        case networks
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.networks = (try? container.decode([String].self, forKey: .networks)) ?? []
    }
}
