// swift-tools-version:5.6
import PackageDescription

let package = Package(
  name: "SplebbosNetworking",
  platforms: [
    .iOS(.v15),
    .macOS(.v10_15),
  ],
  products: [
    .library(
      name: "SplebbosNetworking",
      targets: [
        "SplebbosNetworking",
        "SplebbosNetworkingMocks",
      ]),
  ],
  targets: [
    .target(name: "SplebbosNetworking"),
    .target(name: "SplebbosNetworkingMocks"),
    .testTarget(
      name: "SplebbosNetworkingTests",
      dependencies: [
        "SplebbosNetworking",
        "SplebbosNetworkingMocks",
      ]
    ),
  ]
)
