//
//  IINDetailsResponse.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class IINDetailsResponse: ResponseObjectSerializable, Codable {

    public var paymentProductId: String?
    public var status: IINStatus = .supported
    public var coBrands = [IINDetail]()
    public var countryCode: String?
    @available(*, deprecated, message: "In a future release, this property will be removed. Use countryCode instead.")
    public var countryCodeString: String?
    public var allowedInContext = false

    private init() {
    }

    @available(*, deprecated, message: "In a future release, this initializer will be removed.")
    required public init(json: [String: Any]) {
        if let input = json["isAllowedInContext"] as? Bool {
            allowedInContext = input
        }

        if let input = json["paymentProductId"] as? Int {
            paymentProductId = "\(input)"
            if !allowedInContext {
                status = .existingButNotAllowed
            }
        } else {
            status = .unknown
        }

        if let input = json["countryCode"] as? String {
            countryCode = input
            countryCodeString = input
        }

        if let input = json["coBrands"] as? [[String: Any]] {
            coBrands = []
            for detailInput in input {
                if let detail = IINDetail(json: detailInput) {
                    coBrands.append(detail)
                }
            }
        }
    }

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
            self.countryCodeString = countryCode
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

    @available(*, deprecated, message: "In a future release, this initializer will become internal to the SDK.")
    convenience public init(status: IINStatus) {
        self.init()
        self.status = status
    }

    @available(*, deprecated, message: "In a future release, this initializer will become internal to the SDK.")
    convenience public init(
        paymentProductId: String,
        status: IINStatus,
        coBrands: [IINDetail],
        countryCode: String,
        allowedInContext: Bool
    ) {
        self.init()
        self.paymentProductId = paymentProductId
        self.status = status
        self.coBrands = coBrands
        self.countryCode = countryCode
        self.countryCodeString = countryCode
        self.allowedInContext = allowedInContext
    }
}
