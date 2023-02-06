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
            url: "https://github.com/EbrahimTahernejad/T2SXRay/releases/download/v0.1.0/Tun2socks.xcframework.zip",
            checksum: "1d0e0b029228b78d666deaf1b5e199a1ddb981d27dc78f2b033409e0efc2c375"
        )
    ]
)
