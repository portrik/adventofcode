// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "AOC",
    platforms: [.macOS(.v11)],
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "AOC2015",
            dependencies: [],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "AOC2015Tests",
            dependencies: ["AOC2015"]
        ),
    ]
)
