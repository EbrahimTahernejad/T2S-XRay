// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MyLibrary",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "T2SXray",
            targets: ["T2SXray", "Tun2socks"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "T2SXray"
        ),
        .binaryTarget(
            name: "Tun2socks",
            path: "Tun2socks.xcframework"
        )
    ]
)
