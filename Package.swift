// swift-tools-version:5.5
// Do not remove or alter the notices in this preamble.
// Created for Worldline Global Collect on 16/09/2024.
// Copyright © 2024 Worldline Global Collect. All rights reserved.
//
import Foundation
import PackageDescription

let package = Package(
    name: "WorldlineConnectKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "WorldlineConnectKit",
            targets: ["WorldlineConnectKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.9.1"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", .exact("1.8.4")),
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs", from: "9.1.0")
    ],
    targets: [
        .target(
            name: "WorldlineConnectKit",
            dependencies: ["Alamofire", "CryptoSwift"],
            path: "WorldlineConnectKit",
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .testTarget(
            name: "WorldlineConnectKitTests",
            dependencies: [
                "WorldlineConnectKit",
                .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs"),
                .product(name: "OHHTTPStubs", package: "OHHTTPStubs")
            ],
            path: "WorldlineConnectKitTests"
        )
    ]
)
