// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "AOC2015",
    platforms: [.macOS(.v11)],
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "AOC",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "AOCTests",
                dependencies: ["AOC"]
        )
    ]
)
