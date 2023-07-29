// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OkHttpClient",
    platforms: [.macOS(.v10_14), .iOS(.v13), .tvOS(.v13), .watchOS(.v8)],
    products: [.library(name: "OkHttpClient", targets: ["OkHttpClient"]),],
    targets: [
        .target(name: "OkHttpClient"),
        .testTarget(
            name: "OkHttpClientTests",
            dependencies: ["OkHttpClient"]),
    ]
)
