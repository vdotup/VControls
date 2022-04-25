// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VControls",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "HalfSheet", targets: ["HalfSheetTarget"]),
        .library(name: "Popover", targets: ["PopoverTarget"]),
        .library(name: "RoundedCorner", targets: ["RoundedCornerTarget"]),
        .library(name: "VFormField", targets: ["VFormFieldTarget"]),
        .library(name: "VFormPicker", targets: ["VFormPickerTarget"]),
        .library(name: "VListButton", targets: ["VListButtonTarget"]),
        .library(name: "VListConfirmationButton", targets: ["VListConfirmationButtonTarget"]),
        .library(name: "VTextField", targets: ["VTextFieldTarget"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "HalfSheetTarget", dependencies: []),
        .target(name: "PopoverTarget", dependencies: []),
        .target(name: "RoundedCornerTarget", dependencies: []),
        .target(name: "VFormFieldTarget", dependencies: []),
        .target(name: "VFormPickerTarget", dependencies: []),
        .target(name: "VListButtonTarget", dependencies: []),
        .target(name: "VListConfirmationButtonTarget", dependencies: []),
        .target(name: "VTextFieldTarget", dependencies: []),
    ]
)
