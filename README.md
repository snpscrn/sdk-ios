## Requirements

SnapscreenKit requires at least iOS 8.

## Setup via CocoaPods

Integration via Cocoapods is the easiest way to use SnapscreenKit. Just add the following line to your Podfile.

```
pod 'SnapscreenKit', :git => 'https://github.com/snpscrn/sdk-ios.git'
```

## Manual Setup

SnapscreenKit is provided as an iOS framework and bundles everything necessary for it to operate.


### Add the SnapscreenKit framework

Drag the SnapscreenKit framework to your iOS project and add it as an **Embedded Framework** in your Build Phase (if not done automatically by Xcode).

### Add the SnapscreenKit Resource bundle

Drag SnapscreenKit.bundle to your iOS project to include the necessary resources for SnapscreenKit. If you want to change localizations in SnapscreenKit, you can modify the Localizable.strings files in this bundle.

### Add linker flags

Add the flags **-lc++** and **-ObjC** to the *'Other Linker Flags'* in your projects *Build Settings*.

### Obtain a client ID and secret

Contact Snapscreen to get a clientID and secret for your application.

### Import SnapscreenKit

Add the following line to all classes where you want to access the SnapscreenKit functionality.

```
#import <SnapscreenKit/SnapscreenKit.h>
```

### Add Camera Permission Usage Description if necessary

If you want to access the snapping functionality, starting with iOS 10 it is required by provide a usage description for the camera. This can be done by adding the key **NSCameraUsageDescription** in your application's Info.plist.

### Initialize SnapscreenKit

In order to initialize SnapscreenKit, you need to call the following class method in your AppDelegate in application:didFinishLaunchingWithOptions:

```
[SnapscreenKit sharedSnapscreenKitWithClientID: @"<your-client-id>" clientSecret: @"<your-client-secret>" testEnvironment: NO loggingHandler: nil locationProvider: nil delegate: <delegate>];
```

If you want to provide a Logging Handler or Location Provider, see the documentation for more information on how to do that. Both are not mandatory for SnapscreenKit to function.

Once you have initialized SnapscreenKit, you can also retrieve it by calling

```
[SnapscreenKit sharedSnapscreenKit]
```

## Note about App Store builds

For convenience the framework is a so-called "fat" binary that contains slices for simulator and device architectures. As there is an issue in Xcode that does not correctly strip the unnecessary architectures from a framework you might run into issues when trying to submit your application to the App Store with the framework containing the simulator architecture. To work around this, we recommend to include the following shell script (provided by the Realm project) as a Build Phase in your project to strip the unnecessary slices from your application. 

https://github.com/realm/realm-cocoa/blob/d59c86f11525f346c8e8db277fdbf2d9ff990d98/scripts/strip-frameworks.sh

## Snapping

In order to snap a TV image via SnapscreenKit, you need to first retrieve a SnapscreenSnapViewController by calling

```
SnapscreenSnapViewController* snapViewController = [[SnapscreenKit sharedSnapscreenKit] instantiateSnapscreenSnapViewControllerWithDelegate: self];
```

If you want, you can customize several messages that are shown in the UI via the corresponding properties.

Once you have retrieved the view controller, it's best to present it modally inside a UINavigationController:

```
[self presentViewController: [[UINavigationController alloc] initWithRootViewController: snapViewController] animated: YES completion: nil];
```

The SnapscreenSnapViewController will send callbacks to the delegate you pass and you are responsible for dismissing the ViewController once it's no longer needed. The ViewController does not dismiss itself in any situation.

## Web Search

In order to perform a web search, you simply call the corresponding method for the result type you want to get on the SnapscreenWebSearchService that you can retrieve from SnapscreenKit:

```
[[SnapscreenKit sharedSnapscreenKit].webSearchService searchSitesForSnapscreenTvChannelCode: <channelCode> query: @"<your search query>" timestamp: [SnapscreenKit sharedSnapscreenKit].currentSnapscreenTimestamp page: 0 size: 20 completion:(void (^_Nonnull)(SnapscreenWebSearchResponse<NSArray<SnapscreenWebSearchSiteResult*>*>* _Nullable response)) completionBlock {
        //Response object contains results, metadata and optional error if something went wrong
    }];
```

In case there are multiple pages of results (which is most likely the case), you simply pass the corresponding page number in the method call.

## Displaying Web Search Results

When you are displaying a web search result, you need to use the **visitURL** of the corresponding SnapscreenWebSearchResult to resolve the actual result page and also have Snapscreen track the visit to this result. This is necessary to correctly provide feedback to Snapscreen in order to provide ranking and priorization for the web results.

