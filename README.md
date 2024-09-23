Worldline Connect Swift SDK
=======================

The Worldline Connect Swift SDK provides a convenient way to support a large number of payment methods inside your iOS app.
It supports iOS 12.0 and up out-of-the-box.
The Swift SDK comes with an [UIKit example app](https://github.com/Worldline-Global-Collect/connect-sdk-client-swift-example) and a [SwiftUI example app](https://github.com/Worldline-Global-Collect/connect-sdk-client-swift-example-swiftui) that illustrate the use of the SDK and the services provided by Worldline Global Collect on the Worldline Global Collect platform.

See the [Worldline Connect Developer Hub](https://docs.connect.worldline-solutions.com/documentation/sdk/mobile/swift/) for more information on how to use the SDK.


Use the SDK with Carthage or CocoaPods
---------------------------------------
The Worldline Connect Swift SDK is available via the following package managers: [CocoaPods](https://cocoapods.org/), [Carthage](https://github.com/Carthage/Carthage) and [Swift Package Manager](https://github.com/apple/swift-package-manager).

### CocoaPods

You can add the Swift SDK as a pod to your project by adding the following to your `Podfile`:

```
$ pod 'WorldlineConnectKit'
```

Afterwards, run the following command:

```
$ pod install
```

### Carthage

You can add the Swift SDK with Carthage, by adding the following to your `Cartfile`:

```
$ github "Worldline-Global-Collect/connect-sdk-client-swift"
```

Afterwards, run the following command:

```
$ carthage update --platform ios --use-xcframeworks
```

Navigate to the `Carthage/Build` directory, which was created in the same directory as where the `.xcodeproj` or `.xcworkspace` is. Inside this directory the `.xcframework` bundle is stored. Drag the `.xcframework` into the "Framework, Libraries and Embedded Content" section of the desired target. Make sure that it is set to "Embed & Sign". 

### Swift Package Manager

You can add the Swift SDK with Swift Package Manager, by configuring your project as following:

1. Go to your project's settings and click the 'Package Dependencies' tab.
2. Click the '+' to add a new Swift Package dependency.
3. Enter the Github URL in the search bar: `https://github.com/Worldline-Global-Collect/connect-sdk-client-swift`
4. Additionally, you can also set a version of the package that you wish to include. The default option is to select the latest version from the master branch.
5. Click 'Add package'

When the package has successfully been added, it will automatically be added as a dependency to your targets as well.

Run the SDK locally
------------

To obtain the Swift SDK, first clone the code from GitHub:

```
$ git clone https://github.com/Worldline-Global-Collect/connect-sdk-client-swift.git
```

Open the Xcode project that is included to test the SDK.
