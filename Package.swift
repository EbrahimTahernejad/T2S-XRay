// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "T2SXRay",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "T2SXRay",
            targets: ["T2SXRay", "Tun2socks"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "T2SXRay",
            dependencies: ["Tun2socks"]
        ),
        .binaryTarget(
            name: "Tun2socks",
            url: "https://github.com/EbrahimTahernejad/T2SXRay/releases/download/v0.2.0/Tun2socks.xcframework.zip",
            checksum: "e000b4683a350833dd721300353b8cc0213847234c9dfe4e26c770bebe5b9c0a"
        )
    ]
)
