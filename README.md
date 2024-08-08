# ``CertnIDMobileSDK``

CertnIDMobileSDK is a powerful iOS library designed to streamline and secure the digital onboarding process. This SDK offers robust features for verifying identities, capturing documents, face and NFC data, ensuring compliance with regulatory requirements.

## Key Features
- **Document Capture:** Supports capturing high-quality images of identity documents to be recognized on server side.
- **Face Capture:** Easy to use face auto capture component.
- **NFC Reading:** Provides an API for secure reading of NFC data.
- **User-Friendly Interface:** Provides a seamless and intuitive user experience with customizable UI elements.

## Installation
To integrate CertnIDMobileSDK into your iOS project, follow these steps:

### Using CocoaPods
1. Add the following line to your `Podfile`:
    ```ruby
    source 'https://github.com/certn-id-mobile-sdk/ios-sdk'

    pod 'CertnIDMobileSDK'
    ```
2. Run `pod install` to install the SDK.

## Overview

The `CertnIDMobileSdk` is a mobile SDK for identity verification, allowing integration of various verification features like document scanning, face recognition, and NFC (Near Field Communication). The initialization of this SDK is done using the `initialize` method with a configuration object.

## Initialization
Initialize the SDK for example in your AppDelegate's `application:didFinishLaunchingWithOptions:` method:
```swift
import CertnIDMobileSDK

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    if let url = Bundle.main.url(forResource: "license", withExtension: "lic") {
            do {
                let license = try Data(contentsOf: url)
                try CertnIDMobileSdk.shared.initialize(
                    CertnIDSDKConfiguration(
                        licenseData: license,
                        libraries: [
                            .document,
                            .faceBalanced, // Or .faceFast
                            .nfc
                        ]
                    )
                )
            } catch {
                print("Failed to initialize DotSdk: \(error.localizedDescription)")
            }
        } else {
            print("Failed to initialize DotSdk: License not found.")
        }
        if CertnIDMobileSdk.shared.isInitialized {
            print("CertnIDMobileSdk is ready to use")
        }
    return true
}
```

### Parameters

#### `CertnIDSDKConfiguration`

The `CertnIDSDKConfiguration` class is used to configure the SDK. It takes the following parameters:

- `licenseData`: Contains the license information required to authenticate and use the SDK. This is usually provided by Certn.
- `libraries`: An array of libraries to be initialized within the SDK. This determines the features that will be available for use.

#### `libraries`

The `libraries` parameter is an array that specifies the different modules to be included in the SDK. The available options are:

- `.document`: Enables document scanning capabilities.
- `.faceBalanced`: Enables face recognition with balanced performance and accuracy.
- `.faceFast`: Enables faster face recognition with potentially lower accuracy compared to `faceBalanced`.
- `.nfc`: Enables NFC functionality for reading NFC-enabled documents.

## Deinitialization

When you have finished using the `CertnIDMobileSdk`, it is usually a good practice to deinitialize it in order to free the memory. You can deinitialize `CertnIDMobileSdk` only after the complete process is finished and not within the life cycle of individual components. This can be performed using the ```try? CertnIDMobileSdk.shared.deinitialize()``` method.

## Localization

String resources can be overridden in your application and alternative strings for supported languages can be provided following these two steps:
1. Add your own `Localizable.strings` file to your project using standard iOS localization mechanism. To change a specific text override corresponding key in this `Localizable.strings` file.
2. Set the localization bundle to the bundle of your application (preferably during the application launch in your `AppDelegate`).

### Localizable.strings

```swift
"dot_document.document_auto_capture.instruction.brightness_too_high" = "Less light needed";
"dot_document.document_auto_capture.instruction.brightness_too_low" = "More light needed";
"dot_document.document_auto_capture.instruction.document_out_of_bounds" = "Center document";
"dot_document.document_auto_capture.instruction.document_does_not_fit_placeholder" = "Center document";
"dot_document.document_auto_capture.instruction.document_not_detected" = "Scan document";
"dot_document.document_auto_capture.instruction.size_too_small" = "Move closer";
"dot_document.document_auto_capture.instruction.hotspots_score_too_high" = "Avoid reflections";
"dot_document.document_auto_capture.instruction.mrz_not_present" = "Scan valid machine readable document";
"dot_document.document_auto_capture.instruction.mrz_not_valid" = "Scan valid machine readable document";
"dot_document.document_auto_capture.instruction.sharpness_too_low" = "More light needed";
"dot_document.document_auto_capture.instruction.candidate_selection" = "Hold still...";
```

## Document Auto Capture

The `CertnIDDocumentAutoCaptureViewController` class provides a stateful document auto capture functionality.
You can configure `CertnIDDocumentAutoCaptureViewController` using `CertnIDDocumentAutoCaptureConfiguration` and set the custom style using `CertnIDDocumentAutoCaptureStyle` class.

### Camera permission
In order SDK to have an access to camera, set the following permission in Info.plist:

```swift
<key>NSCameraUsageDescription</key>
	<string>Your usage description</string>
```

If the camera permission is not determined the view controller will use iOS API - AVCaptureDevice.requestAccess(for: .video) method to request the camera permission. This method will present the system dialog to the user of the app. T

### Sample implementation

Next add `CertnIDDocumentAutoCaptureViewController` as a child view controller to your view and setup a delegate for callbacks. Run `viewController.start()` to start the auto capture process. Once you are done execute `viewController.stop()` command to stop auto capturing process.

```swift
import UIKit
import CertnIDMobileSDK

class DocumentCaptureViewController: UIViewController {
    let viewController = CertnIDDocumentAutoCaptureViewController(configuration: .init(), style: .init())

    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.delegate = self
        setupSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewController.start()
    }

    private func setupSubviews() {
        view.backgroundColor = UIColor.systemBackground
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension DocumentCaptureViewController: CertnIDDocumentAutoCaptureDelegate {
    func documentAutoCaptureViewController(_ viewController: CertnIDMobileSDK.CertnIDDocumentAutoCaptureViewController, captured result: CertnIDMobileSDK.CertnIDDocumentAutoCaptureResult) {
        // Stop document capture
        viewController.stopAsync { [weak self] in
        // Process the result here
        }
    }
}
```

### CertnIDDocumentAutoCaptureConfiguration
You can configure auto capture process with following parameters: 

```swift
/// Customize thresholds for the quality attributes of the document auto capture result.
    @objc final public let qualityAttributeThresholds: CertnIDQualityAttributeThresholds

    /// Specify validation mode. Default is `.standard`.
    @objc final public let validationMode: CertnIDValidationMode

    /// Specify MRZ validation. Default is `.none`.
    @objc final public let mrzValidation: CertnIDMrzValidation

    /// Use this flag to show or hide detection rectangle during the document auto capture process. Default is `false`.
    @objc final public let isDetectionLayerVisible: Bool

    /// Use this flag to turn the torch on or off during the document auto capture process.
    /// Torch will be turned on only if ``cameraFacing`` property is set to `.back`. Default is `false`.
    @objc final public let isTorchEnabled: Bool

    /// Specify camera facing. Default is `.back`.
    @objc final public let cameraFacing: CertnIDCameraFacing

    /// Specify camera preview scale type. Default is `.fit`.
    @objc final public let cameraPreviewScaleType: CertnIDCameraPreviewScaleType

    /// Specify the type of placeholder used in document auto-capture UI. Default is `.cornersOnly`.
    @objc final public let placeholderType: CertnIDPlaceholderType
```

### CertnIDDocumentAutoCaptureStyle
`CertnIDDocumentAutoCaptureStyle` is used to customize UI as needed. It has following parameters:

```swift
    /// Background color of top level view.
    @objc public let backgroundColor: UIColor

    /// Instruction label font.
    @objc public let instructionFont: UIFont

    /// Instruction label text color.
    @objc public let instructionTextColor: UIColor

    /// Instruction label text color during candidate selection phase.
    @objc public let instructionCandidateSelectionTextColor: UIColor

    /// Instruction background color.
    @objc public let instructionBackgroundColor: UIColor

    /// Instruction background color during candidate selection phase.
    @objc public let instructionCandidateSelectionBackgroundColor: UIColor

    /// Placeholder color.
    @objc public let placeholderColor: UIColor

    /// Placeholder color during candidate selection phase.
    @objc public let placeholderCandidateSelectionColor: UIColor

    /// Detection layer color.
    @objc public let detectionLayerColor: UIColor

    /// Placeholder overlay color, semi-transparent color is recommended.
    @objc public let placeholderOverlayColor: UIColor
```

### CertnIDDocumentAutoCaptureResult
The result of the auto capture is represented by `CertnIDDocumentAutoCaptureResult` class. It contains following data:

```swift
    /// Document image.
    final public var image: UIImage

    /// The result of the document detection.
    @objc final public var document: CertnIDDocument?

    /// Binary content for server-side evaluation.
    @objc final public let content: Data

    /// Resolved travel document type.
    public var travelDocumentType: CertnIDTravelDocumentType?
```

### CertnIDDocumentAutoCaptureDelegate
Protocol `CertnIDDocumentAutoCaptureDelegate` is used to handle the autocapture process and declares following functions:
```swift
    /// Tells the delegate that the document was captured. This callback is called after the component has stopped.
    @objc func documentAutoCaptureViewController(
        _ viewController: CertnIDDocumentAutoCaptureViewController,
        captured result: CertnIDDocumentAutoCaptureResult
    )

    /// Tells the delegate that the new detection was processed.
    @objc optional func documentAutoCaptureViewController(
        _ viewController: CertnIDDocumentAutoCaptureViewController,
        processed detection: CertnIDDocumentAutoCaptureDetection
    )

    /// Tells the delegate that you have no permission for camera usage.
    @objc optional func documentAutoCaptureViewControllerNoCameraPermission(_ viewController: CertnIDDocumentAutoCaptureViewController)
```


## Support and Documentation
For detailed documentation and support, visit the [TrustmaticMobileSDK Documentation] (https://demo.trustmatic.io/documentation/) or contact support at [support@trustmatic.com](mailto:support@trustmatic.com).

## License
CertnIDMobileSDK is available under a commercial license. For more information, please refer to the official website or contact the sales team.
