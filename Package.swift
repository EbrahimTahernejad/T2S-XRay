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
            url: "https://github.com/EbrahimTahernejad/T2SXRay/releases/download/v0.2.1/Tun2socks.xcframework.zip",
            checksum: "cdfba88559263dbf23327aa57fef7c1237984bc4a6bfb1debef513733cbf25ab"
        )
    ]
)
