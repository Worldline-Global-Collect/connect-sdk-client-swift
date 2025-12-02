//
//  IINDetail.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class IINDetail: Codable {
    public var paymentProductId: String
    public var allowedInContext: Bool = false

    internal init(paymentProductId: String, allowedInContext: Bool) {
        self.paymentProductId = paymentProductId
        self.allowedInContext = allowedInContext
    }

    private enum CodingKeys: String, CodingKey {
        case paymentProductId, isAllowedInContext
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let paymentProductIdInt = try container.decode(Int.self, forKey: .paymentProductId)
        self.paymentProductId = "\(paymentProductIdInt)"
        if let allowedInContext = try? container.decodeIfPresent(Bool.self, forKey: .isAllowedInContext) {
            self.allowedInContext = allowedInContext
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(paymentProductId, forKey: .paymentProductId)
        try? container.encode(allowedInContext, forKey: .isAllowedInContext)
    }
}
