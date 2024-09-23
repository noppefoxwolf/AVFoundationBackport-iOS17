// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AVFoundationBackport-iOS17",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "AVFoundationBackport-iOS17",
            targets: ["AVFoundationBackport-iOS17"]
        ),
    ],
    targets: [
        .target(
            name: "AVFoundationBackport-iOS17"),
        .testTarget(
            name: "AVFoundationBackport-iOS17Tests",
            dependencies: ["AVFoundationBackport-iOS17"]
        ),
    ]
)
