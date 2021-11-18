// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "SplebbosNetworking",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
  ],
  products: [
    .library(
      name: "SplebbosNetworking",
      targets: ["SplebbosNetworking"]),
  ],
  targets: [
    .target(
      name: "SplebbosNetworking",
      dependencies: []),
    .testTarget(
      name: "SplebbosNetworkingTests",
      dependencies: ["SplebbosNetworking"]),
  ]
)
