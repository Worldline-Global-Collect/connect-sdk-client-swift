//
//  ConnectSDKConfiguration.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 24/11/2023.
//  Copyright © 2023 Worldline Global Collect. All rights reserved.
//

public class ConnectSDKConfiguration: Decodable {
    public let sessionConfiguration: SessionConfiguration
    public let enableNetworkLogs: Bool
    public let applicationId: String?
    public let ipAddress: String?
    public let preLoadImages: Bool
    public let sdkIdentifier: String

    public init(
        sessionConfiguration: SessionConfiguration,
        enableNetworkLogs: Bool = false,
        applicationId: String? = nil,
        ipAddress: String? = nil,
        preLoadImages: Bool = true
    ) {
        self.sessionConfiguration = sessionConfiguration
        self.enableNetworkLogs = enableNetworkLogs
        self.applicationId = applicationId
        self.ipAddress = ipAddress
        self.preLoadImages = preLoadImages
        self.sdkIdentifier = SDKConstants.kSDKIdentifier
    }

    private enum CodingKeys: String, CodingKey {
        case sessionConfiguration, enableNetworkLogs, applicationId, ipAddress, preLoadImages, sdkIdentifier
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.sessionConfiguration = try container.decode(SessionConfiguration.self, forKey: .sessionConfiguration)
        self.enableNetworkLogs = try container.decode(Bool.self, forKey: .enableNetworkLogs)
        self.applicationId = try? container.decodeIfPresent(String.self, forKey: .applicationId)
        self.ipAddress = try? container.decodeIfPresent(String.self, forKey: .ipAddress)
        self.preLoadImages = try container.decode(Bool.self, forKey: .preLoadImages)

        self.sdkIdentifier = ConnectSDKConfiguration.getValidSdkIdentifier(
            identifier: try? container.decodeIfPresent(String.self, forKey: .sdkIdentifier)
        )
    }

    private static func getValidSdkIdentifier(identifier: String?) -> String {
        guard let identifier else {
            return SDKConstants.kSDKIdentifier
        }

        let identifierParts = identifier.split(separator: "/")

        if identifierParts.count == 2
            && identifierParts[0] == "FlutterClientSDK"
            && identifierParts[1].hasPrefix("v") {
            let versionParts = identifierParts[1].replacingOccurrences(of: "v", with: "").split(separator: ".")

            if versionParts.count == 3 && versionParts.allSatisfy({ Int($0) != nil }) {
                return identifier
            }
        }

        return SDKConstants.kSDKIdentifier
    }
}
