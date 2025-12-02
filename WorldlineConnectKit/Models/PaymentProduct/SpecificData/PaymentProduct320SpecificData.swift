//
//  PaymentProduct320SpecificData.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 20/09/2018.
//  Copyright © 2018 Worldline Global Collect. All rights reserved.
//

import Foundation

public class PaymentProduct320SpecificData: Codable {
    public var gateway: String = ""
    public var networks: [String] = []

    private enum CodingKeys: String, CodingKey {
        case gateway, networks
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gateway = (try? container.decode(String.self, forKey: .gateway)) ?? ""
        self.networks = (try? container.decode([String].self, forKey: .networks)) ?? []
    }
}
