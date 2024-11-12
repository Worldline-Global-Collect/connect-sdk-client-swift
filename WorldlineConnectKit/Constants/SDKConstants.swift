//
//  SDKConstants.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation
import UIKit

public class SDKConstants {

    public static let kSDKLocalizable = "WCSDKLocalizable"
    public static let kImageMapping = "kImageMapping"
    public static let kImageMappingInitialized = "kImageMappingInitialized"
    public static let kIINMapping = "kIINMapping"

    public static let kAndroidPayIdentifier = "320"
    public static let kApplePayIdentifier = "302"

    public static let kApiVersion = "client/v1"
    public static let kSDKIdentifier = "SwiftClientSDK/v6.1.1"
#if SWIFT_PACKAGE
    public static var kSDKBundlePath = Bundle.module.path(forResource: "WorldlineConnectKit", ofType: "bundle")
#elseif COCOAPODS
    public static let kSDKBundleIdentifier = "org.cocoapods.WorldlineConnectKit"
    public static var kSDKBundlePath =
        Bundle(identifier: SDKConstants.kSDKBundleIdentifier)?.path(
            forResource: "WorldlineConnectKit",
            ofType: "bundle"
        )
#else
    private static let kSDKBundleIdentifier = "com.worldline.connect.WorldlineConnectKit"
    public static var kSDKBundlePath =
        Bundle(identifier: SDKConstants.kSDKBundleIdentifier)?.path(
            forResource: "WorldlineConnectKit",
            ofType: "bundle"
        )
#endif

    // swiftlint:disable identifier_name
    public static func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v: String) -> Bool {
        return UIDevice.current.systemVersion.compare(v, options: String.CompareOptions.numeric) != .orderedAscending
    }
    // swiftlint:enable identifier_name
}
