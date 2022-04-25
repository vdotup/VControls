// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VControls",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "HalfSheet", targets: ["HalfSheet"]),
        .library(name: "Popover", targets: ["Popover"]),
        .library(name: "RoundedCorner", targets: ["RoundedCorner"]),
        .library(name: "VFormField", targets: ["VFormField"]),
        .library(name: "VFormPicker", targets: ["VFormPicker"]),
        .library(name: "VListButton", targets: ["VListButton"]),
        .library(name: "VListConfirmationButton", targets: ["VListConfirmationButton"]),
        .library(name: "VTextField", targets: ["VTextField"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "HalfSheet", dependencies: [], path: "Sources/HalfSheet"),
        .target(name: "Popover", dependencies: [], path: "Sources/Popover"),
        .target(name: "RoundedCorner", dependencies: [], path: "Sources/RoundedCorner"),
        .target(name: "VFormField", dependencies: [], path: "Sources/VFormField"),
        .target(name: "VFormPicker", dependencies: [], path: "Sources/VFormPicker"),
        .target(name: "VListButton", dependencies: [], path: "Sources/VListButton"),
        .target(name: "VListConfirmationButton", dependencies: [], path: "Sources/VListConfirmationButton"),
        .target(name: "VTextField", dependencies: [], path: "Sources/VTextField"),
    ]
)
