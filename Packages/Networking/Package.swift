// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.9.1")
        )
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"],
            path: "Tests"
        )
    ]
)
