//
//  BasicPaymentProducts.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class BasicPaymentProducts: Equatable, Codable {
    public var paymentProducts = [BasicPaymentProduct]()
    public var stringFormatter: StringFormatter? {
        get { return paymentProducts.first?.stringFormatter }
        set {
            if let stringFormatter = newValue {
                for basicProduct in paymentProducts {
                    basicProduct.stringFormatter = stringFormatter
                }
            }
        }
    }

    public var hasAccountsOnFile: Bool {
        for product in paymentProducts
            where product.accountsOnFile.accountsOnFile.count > 0 {
                return true
        }

        return false
    }

    public var accountsOnFile: [AccountOnFile] {
        var accountsOnFile = [AccountOnFile]()

        for product in paymentProducts {
            accountsOnFile.append(contentsOf: product.accountsOnFile.accountsOnFile)
        }

        return accountsOnFile
    }

    internal init() {}

    private enum CodingKeys: String, CodingKey {
        case paymentProducts
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.paymentProducts =
            (try? container.decodeIfPresent([BasicPaymentProduct].self, forKey: .paymentProducts)) ??
                [BasicPaymentProduct]()
    }

    public func logoPath(forPaymentProduct identifier: String) -> String? {
        let product = paymentProduct(withIdentifier: identifier)
        return product?.displayHints.logoPath
    }

    public func paymentProduct(withIdentifier identifier: String) -> BasicPaymentProduct? {
        for product in paymentProducts where product.identifier.isEqual(identifier) {
            return product
        }
        return nil
    }

    public func sort() {
        paymentProducts = paymentProducts.sorted {
            guard let displayOrder0 = $0.displayHints.displayOrder,
                  let displayOrder1 = $1.displayHints.displayOrder else {
                return false
            }
            return displayOrder0 < displayOrder1
        }
    }

    public static func == (lhs: BasicPaymentProducts, rhs: BasicPaymentProducts) -> Bool {
        if lhs.paymentProducts.count != rhs.paymentProducts.count {
            return false
        }

        for index in 0..<lhs.paymentProducts.count where lhs.paymentProducts[index] != rhs.paymentProducts[index] {
            return false
        }
        return true
    }
}
