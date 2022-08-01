// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpaceX",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "Core", targets: ["Core"]),
        .library(name: "Assemblies", targets: ["Assemblies"]),
        .library(name: "DependencyResolver", targets: ["DependencyResolver"]),
        .library(name: "UseCases", targets: ["UseCases"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "Extensions", targets: ["Extensions"]),
        .library(name: "Utils", targets: ["Utils"]),
        .library(name: "QueryFilterBuilder", targets: ["QueryFilterBuilder"]),
        .library(name: "ImageDownloader", targets: ["ImageDownloader"]),
        .library(name: "MVVM", targets: ["MVVM"]),
        .library(name: "Coordinators", targets: ["Coordinators"]),
        .library(name: "SceneLaunches", targets: ["SceneLaunches"]),
        .library(name: "SceneWebBrowser", targets: ["SceneWebBrowser"])
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.6.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.6.1"),
        .package(url: "https://github.com/onevcat/Kingfisher", exact: "7.0.0"),
        .package(url: "https://github.com/konkab/AlamofireNetworkActivityLogger.git", exact: "3.4.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", exact: "2.8.0")
    ],
    targets: [
        .target(name: "Core"),
        
        .target(name: "Assemblies", dependencies: [
            "Swinject",
            "Networking",
            "UseCases"
        ]),
        
        .target(name: "DependencyResolver"),
        
        .target(name: "UseCases", dependencies: [
            "Networking",
            "Core",
            "QueryFilterBuilder"
        ]),
        
        .target(name: "Networking", dependencies: [
            "Core",
            "Alamofire",
            "AlamofireNetworkActivityLogger"
        ]),
        
        .target(name: "Extensions"),
        
        .target(name: "Utils"),
        
        .target(name: "QueryFilterBuilder", dependencies: [
            "Core"
        ]),
        
        .target(name: "ImageDownloader", dependencies: [
            "Kingfisher"
        ]),
        
        .target(name: "MVVM"),
        
        .target(name: "Coordinators", dependencies: [
            "UseCases",
            "Core",
            "Networking",
            "SceneLaunches",
            "SceneWebBrowser",
            "DependencyResolver"
        ]),
        
        .target(name: "SceneLaunches", dependencies: [
            "MVVM",
            "Extensions",
            "Utils",
            "SnapKit",
            "ImageDownloader",
            "UseCases"
        ]),
        
        .target(name: "SceneWebBrowser", dependencies: [
            "MVVM",
            "Extensions",
            "SnapKit"
        ]),
    ]
    
)
