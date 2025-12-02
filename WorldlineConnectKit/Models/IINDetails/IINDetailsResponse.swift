//
//  IINDetailsResponse.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class IINDetailsResponse: Codable {

    public var paymentProductId: String?
    public var status: IINStatus = .supported
    public var coBrands = [IINDetail]()
    public var countryCode: String?
    public var allowedInContext = false

    private init() {}

    private enum CodingKeys: String, CodingKey {
        case paymentProductId, coBrands, countryCode, isAllowedInContext, status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let allowedInContext = try? container.decodeIfPresent(Bool.self, forKey: .isAllowedInContext) {
            self.allowedInContext = allowedInContext
        }

        if let paymentProductId = try? container.decodeIfPresent(Int.self, forKey: .paymentProductId) {
            self.paymentProductId = "\(paymentProductId)"
            if !allowedInContext {
                status = .existingButNotAllowed
            }
        } else {
            status = .unknown
        }

        if let countryCode = try? container.decodeIfPresent(String.self, forKey: .countryCode) {
            self.countryCode = countryCode
        }

        if let coBrands = try? container.decodeIfPresent([IINDetail].self, forKey: .coBrands) {
            self.coBrands = coBrands
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encodeIfPresent(paymentProductId, forKey: .paymentProductId)
        try? container.encode(status, forKey: .status)
        try? container.encode(coBrands, forKey: .coBrands)
        try? container.encodeIfPresent(countryCode, forKey: .countryCode)
        try? container.encode(allowedInContext, forKey: .isAllowedInContext)
    }

    convenience internal init(status: IINStatus) {
        self.init()
        self.status = status
    }
}
