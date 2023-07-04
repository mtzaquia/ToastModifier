// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ToastModifier",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "ToastModifier",
            targets: ["ToastModifier"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mtzaquia/UIKitPresentationModifier.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "ToastModifier",
            dependencies: [
                "UIKitPresentationModifier"
            ])
    ]
)
