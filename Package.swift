// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageExtractor",
	platforms: [.macOS(.v10_14), .iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ImageExtractor",
            targets: ["ImageExtractor"]
		),
		.library(name: "CommandLineTools", targets: ["CommandLineTools"]),
		.executable(
			name: "CommandLineInterface",
			targets: ["CommandLineInterface", "CommandLineTools"]
		)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
		.package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ImageExtractor",
            dependencies: []),
		.target(
			name: "CommandLineTools",
			dependencies: [
				"ImageExtractor",
				.product(name: "ArgumentParser", package: "swift-argument-parser")
			]
		),
		.target(
			name: "CommandLineInterface",
			dependencies: ["CommandLineTools"]
		),
        .testTarget(
            name: "ImageExtractorTests",
            dependencies: ["ImageExtractor"],
			resources: [
				.process("sample.pdf")
			]
		),
		.testTarget(
			name: "CLITests",
			dependencies: ["CommandLineTools"],
			resources: [
				.process("sample.pdf")
			]
		),
    ]
)
