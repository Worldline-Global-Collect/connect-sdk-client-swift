//
//  C2SCommunicatorConfiguration.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

@available(
    *,
    deprecated,
    message:
        """
        In a future release, this class, its functions and its properties will become internal to the SDK.
        """
)
public class C2SCommunicatorConfiguration {
    let clientSessionId: String
    let customerId: String
    public var assetsBaseURL: String
    let util: Util
    let appIdentifier: String
    let ipAddress: String?
    internal var loggingEnabled: Bool

    public init(
        clientSessionId: String,
        customerId: String,
        baseURL: String,
        assetBaseURL: String,
        appIdentifier: String,
        util: Util? = nil,
        loggingEnabled: Bool = false
    ) {
        self.clientSessionId = clientSessionId
        self.customerId = customerId
        self.util = util ?? Util.shared
        self.appIdentifier = appIdentifier
        self.ipAddress = nil
        self.loggingEnabled = loggingEnabled
        self.assetsBaseURL = assetBaseURL
        self.baseURL = baseURL
    }

    public init(
        clientSessionId: String,
        customerId: String,
        baseURL: String,
        assetBaseURL: String,
        appIdentifier: String,
        ipAddress: String?,
        util: Util? = nil,
        loggingEnabled: Bool = false
    ) {
        self.clientSessionId = clientSessionId
        self.customerId = customerId
        self.util = util ?? Util.shared
        self.appIdentifier = appIdentifier
        self.ipAddress = ipAddress
        self.loggingEnabled = loggingEnabled
        self.assetsBaseURL = assetBaseURL
        self.baseURL = baseURL
    }

    @available(
        *,
        deprecated,
        message:
            """
            In a future release, this property will become private to this class. Use baseURL instead.
            """
    )
    // swiftlint:disable identifier_name
    public var _baseURL: String?
    // swiftlint:enable identifier_name

    /// New base URL should be a valid URL
    public var baseURL: String {
        get {
            return _baseURL ?? ""
        }
        set {
            _baseURL = fixURL(url: newValue)
        }
    }

    private func fixURL(url: String) -> String? {
        // Assume valid URL
        if var finalComponents = URLComponents(string: url) {
            var components = finalComponents.path.split(separator: "/").map { String($0)}
            let versionComponents = (SDKConstants.kApiVersion as NSString).pathComponents
            let error = {
                fatalError(
                    """
                    This version of the connectSDK is only compatible with \(versionComponents.joined(separator: "/")),
                    you supplied: '\(components.joined(separator: "/"))'
                    """
                )
            }

            switch components.count {
            case 0:
                components = versionComponents
            case 1:
                if components[0] != versionComponents[0] {
                    error()
                }
                components[0] = components[0]
                components.append(versionComponents[1])
            case 2:
                if components[0] != versionComponents[0] {
                    error()
                }
                if components[1] != versionComponents[1] {
                    error()
                }
            default:
                error()

            }
            finalComponents.path = "/" + components.joined(separator: "/")
            return finalComponents.url?.absoluteString
        }
        return nil
    }

    public var base64EncodedClientMetaInfo: String? {
        return util.base64EncodedClientMetaInfo(withAppIdentifier: appIdentifier, ipAddress: ipAddress)
    }
}
