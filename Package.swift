// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VControls",
    platforms: [.iOS(.v15)],
    products: [
//         Products define the executables and libraries a package produces, and make them visible to other packages.
//        .library(name: "HalfSheet", targets: ["HalfSheet"]),
//        .library(name: "ImagePicker", targets: ["ImagePicker"]),
//        .library(name: "Popover", targets: ["Popover"]),
        .library(name: "RoundedCorner", type: .dynamic, targets: ["RoundedCorner"]),
        .library(name: "VFormField", targets: ["VFormField"]),
//        .library(name: "VFormPicker", targets: ["VFormPicker"]),
//        .library(name: "VListButton", targets: ["VListButton"]),
//        .library(name: "VListConfirmationButton", targets: ["VListConfirmationButton"]),
//        .library(name: "VTextField", targets: ["VTextField"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "HalfSheet", dependencies: []),
        .target(name: "ImagePicker", dependencies: []),
        .target(name: "Popover", dependencies: []),
        .target(name: "RoundedCorner", dependencies: []),
        .target(name: "VFormField", dependencies: []),
        .target(name: "VFormPicker", dependencies: []),
        .target(name: "VListButton", dependencies: []),
        .target(name: "VListConfirmationButton", dependencies: []),
        .target(name: "VTextField", dependencies: []),
    ]
)
