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
First, add license file to your project by dragging and dropping it to the project view in the left pane of the Xcode.
Next, initialize the SDK for example in your AppDelegate's `application:didFinishLaunchingWithOptions:` method:
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
                print("Failed to initialize CertnIDMobileSDK: \(error.localizedDescription)")
            }
        } else {
            print("Failed to initialize CertnIDMobileSDK: License not found.")
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

// Face capture
"dot_face.face_auto_capture.instruction.face_not_detected" = "Position your face into the circle";
"dot_face.face_auto_capture.instruction.face_out_of_bounds" = "Center your face";
"dot_face.face_auto_capture.instruction.size_too_large" = "Move back";
"dot_face.face_auto_capture.instruction.size_too_small" = "Move closer";
"dot_face.face_auto_capture.instruction.brightness_too_high" = "Turn towards light";
"dot_face.face_auto_capture.instruction.brightness_too_low" = "Turn towards light";
"dot_face.face_auto_capture.instruction.contrast_too_high" = "Turn towards light";
"dot_face.face_auto_capture.instruction.contrast_too_low" = "Turn towards light";
"dot_face.face_auto_capture.instruction.shadow_too_high" = "Turn towards light";
"dot_face.face_auto_capture.instruction.sharpness_too_low" = "Turn towards light";
"dot_face.face_auto_capture.instruction.unique_intensity_levels_too_low" = "Turn towards light";
"dot_face.face_auto_capture.instruction.glasses_present" = "Remove glasses";
"dot_face.face_auto_capture.instruction.background_nonuniform" = "Plain background required";
"dot_face.face_auto_capture.instruction.expression_neutral_too_high" = "Smile :)";
"dot_face.face_auto_capture.instruction.expression_neutral_too_low" = "Keep neutral expression";
"dot_face.face_auto_capture.instruction.pitch_too_high" = "Lower your chin";
"dot_face.face_auto_capture.instruction.pitch_too_low" = "Lift your chin";
"dot_face.face_auto_capture.instruction.yaw_too_right" = "Look left";
"dot_face.face_auto_capture.instruction.yaw_too_left" = "Look right";
"dot_face.face_auto_capture.instruction.eyes_too_closed" = "Open your eyes";
"dot_face.face_auto_capture.instruction.mouth_too_open" = "Close your mouth";
"dot_face.face_auto_capture.instruction.mask_present" = "Remove mask";
"dot_face.face_auto_capture.instruction.candidate_selection" = "Stay still...";
"dot_face.face_auto_capture.instruction.device_pitch_too_high" = "Hold your phone at eye level";
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
        super.viewWillAppear(animated)
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

## Face Capture

The `CertnIDFaceAutoCaptureViewController` class provides face capture functionality.
You can configure `CertnIDFaceAutoCaptureViewController` using `CertnIDFaceAutoCaptureConfiguration` and set the custom style using `CertnIDFaceAutoCaptureStyle` class.

### Camera permission
In order SDK to have an access to camera, set the following permission in Info.plist:

```swift
<key>NSCameraUsageDescription</key>
	<string>Your usage description</string>
```

### Sample implementation

Add `CertnIDFaceAutoCaptureViewController` as a child view controller to your view and setup a delegate for callbacks. Run `viewController.start()` to start the auto capture process. Once you are done execute `viewController.stopAsync(onStopped: @escaping () -> Void)` command to stop auto capturing process.

```swift
import CertnIDMobileSDK
import UIKit

class FaceCaptureViewController: UIViewController {
    fileprivate let viewController = CertnIDFaceAutoCaptureViewController(configuration: .init(), style: .init())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewController.start()
    }

    private func setupSubviews() {
        view.backgroundColor = UIColor.systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        viewController.delegate = self
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension FaceCaptureViewController: CertnIDFaceAutoCaptureViewControllerDelegate {
    func faceAutoCaptureViewController(
        _ viewController: CertnIDMobileSDK.CertnIDFaceAutoCaptureViewController,
        captured result: CertnIDMobileSDK.CertnIDFaceAutoCaptureResult
    ) {
        viewController.stopAsync {
//            Process result
        }
    }
}
```

### CertnIDFaceAutoCaptureConfiguration
You can configure face capture process with following parameters: 
```swift
@objc final public class CertnIDFaceAutoCaptureConfiguration : NSObject {

    /// Configure thresholds for the quality attributes of the face auto capture result.
    /// If the threshold property is set to nil, the corresponding quality attribute will not be validated.
    @objc final public class CertnIDQualityAttributeThresholds : NSObject {

        /// Minimal valid confidence of the detected face.
        /// Value 0.0 represents low confidence.
        /// Vaue 1.0 represents high confidence.
        final public let minConfidence: Double?

        /// Valid interval of size of the detected face.
        /// Value 0.0 represents small size.
        /// Vaue 1.0 represents large size.
        final public let sizeInterval: CertnIDMobileSDK.IntervalDouble?

        /// Valid interval of rotation of the pitch of the detected face.
        /// Value -90.0 represents down rotated pitch of the detected face.
        /// Vaue 90.0 represents up rotated pitch of the detected face.
        final public let pitchAngleInterval: CertnIDMobileSDK.IntervalFloat?

        /// Valid interval of rotation of the yaw of the detected face.
        /// Value -90.0 represents left rotated yaw of the detected face.
        /// Vaue 90.0 represents right rotated yaw of the detected face.
        final public let yawAngleInterval: CertnIDMobileSDK.IntervalFloat?

        /// Minimal valid sharpness of the detected face.
        /// Value 0.0 represents blurry face.
        /// Vaue 1.0 represents sharp face.
        final public let minSharpness: Double?

        /// Valid interval of brightness of the detected face.
        /// Value 0.0 represents low brightness.
        /// Vaue 1.0 represents high brightness.
        final public let brightnessInterval: CertnIDMobileSDK.IntervalDouble?

        /// Valid interval of contrast of the detected face.
        /// Value 0.0 represents low contrast.
        /// Vaue 1.0 represents high contrast.
        final public let contrastInterval: CertnIDMobileSDK.IntervalDouble?

        /// Minimal valid unique intensity levels of the detected face.
        /// Value 0.0 represents low unique intensity levels.
        /// Vaue 1.0 represents high unique intensity levels.
        final public let minUniqueIntensityLevels: Double?

        /// Maximal valid glasses presence score of the detected face.
        /// Value 0.0 represents face with no glasses.
        /// Vaue 1.0 represents face with glasses.
        final public let maxGlassesPresenceScore: Double?

        /// Maximal valid mask presence score of the detected face.
        /// Value 0.0 represents face with no mask.
        /// Vaue 1.0 represents face with mask.
        final public let maxMaskPresenceScore: Double?

        /// Minimal valid mouth status score of the detected face.
        /// Value 0.0 represents face with mouth opened.
        /// Vaue 1.0 represents face with mouth closed.
        final public let minMouthStatusScore: Double?

        /// Minimal valid eyes status score of the detected face.
        /// Value 0.0 represents face with eyes closed.
        /// Vaue 1.0 represents face with eyes opened.
        final public let minEyesStatusScore: Double?

        /// Maximal valid shadow of the detected face.
        /// Value 0.0 represents face without shadows.
        /// Vaue 1.0 represents face with shadows.
        final public let maxShadow: Double?

        /// Maximal pitch angle of the device.
        /// Valid closed interval of angle values is from 0.0 to 90.0 degrees.
        final public let maxDevicePitchAngle: Float?
    }
    /// Interval used for calculating minimal and maximal face size in image in range [0.0, 1.0]. Default is `[0.1, 0.3]`.
    @objc final public let faceSizeRatioInterval: CertnIDMobileSDK.IntervalDouble

    /// Customize thresholds for the quality attributes of the face auto capture result.
    @objc final public let qualityAttributeThresholds: CertnIDMobileSDK.CertnIDFaceAutoCaptureConfiguration.CertnIDQualityAttributeThresholds

    /// Use this flag to show or hide detection circle during the face auto capture process. Default is `false`.
    @objc final public let isDetectionLayerVisible: Bool

    /// Use this flag to turn the torch on or off during the face auto capture process.
    /// Torch will be turned on only if ``cameraFacing`` property is set to `.back`. Default is `false`.
    @objc final public let isTorchEnabled: Bool

    /// Specify camera facing. Default is `.front`.
    @objc final public let cameraFacing: CertnIDMobileSDK.CertnIDCameraFacing

    /// Specify camera preview scale type. Default is `.fit`.
    @objc final public let cameraPreviewScaleType: CertnIDMobileSDK.CertnIDCameraPreviewScaleType
```

### CertnIDFaceAutoCaptureStyle
`CertnIDFaceAutoCaptureStyle` is used to customize UI as needed. It has following parameters:
```swift
/// Background color of top level view.
    @objc final public let backgroundColor: UIColor

    /// Instruction label font.
    @objc final public let instructionFont: UIFont

    /// Instruction label text color.
    @objc final public let instructionTextColor: UIColor

    /// Instruction label text color during candidate selection phase.
    @objc final public let instructionCandidateSelectionTextColor: UIColor

    /// Instruction background color.
    @objc final public let instructionBackgroundColor: UIColor

    /// Instruction background color during candidate selection phase.
    @objc final public let instructionCandidateSelectionBackgroundColor: UIColor

    /// Placeholder color.
    @objc final public let placeholderColor: UIColor

    /// Placeholder color during candidate selection phase.
    @objc final public let placeholderCandidateSelectionColor: UIColor

    /// Detection layer color.
    @objc final public let detectionLayerColor: UIColor

    /// Placeholder overlay color, semi-transparent color is recommended.
    @objc final public let placeholderOverlayColor: UIColor
```

### CertnIDFaceAutoCaptureResult
The result of the auto capture is represented by `CertnIDFaceAutoCaptureResult` class. It contains following data:
```swift
    /// Face image.
    final public var image: UIImage { get }

    /// Binary content for server-side evaluation.
    @objc final public let content: Data
```

### CertnIDFaceAutoCaptureViewControllerDelegate
Protocol `CertnIDFaceAutoCaptureViewControllerDelegate` is used to handle the autocapture process and declares following functions:
```swift
    @objc optional func faceAutoCaptureViewControllerNoCameraPermission(_ viewController: CertnIDMobileSDK.CertnIDFaceAutoCaptureViewController)

    /// Tells the delegate that the new detection was processed.
    @objc optional func faceAutoCaptureViewController(_ viewController: CertnIDMobileSDK.CertnIDFaceAutoCaptureViewController, processed detection: CertnIDMobileSDK.CertnIDFaceAutoCaptureDetection)

    /// Tells the delegate that the face was captured. This callback is called after the component has stopped.
    @objc optional func faceAutoCaptureViewController(_ viewController: CertnIDMobileSDK.CertnIDFaceAutoCaptureViewController, captured result: CertnIDMobileSDK.CertnIDFaceAutoCaptureResult)
```

## NFC Reading

CertnID SDK NFC module provides a component for NFC reading which is easy to integrate into an iOS application. Supported documents are those which implement [ICAO Doc 9303: Machine Readable Travel Documents] (https://www.icao.int/publications/pages/publication.aspx?docnum=9303) as specified by International Civil Aviation Organization (ICAO).

## Permissions

1. First, add capability `Near Field Communication Tag Reading` to your Xcode target
2. Second, add following to your `Info.plist`:
```swift
<key>NFCReaderUsageDescription</key>
<string>NFC tag to read NDEF messages into the application</string>

<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
<array>
	<string>A0000002471001</string>
</array>
```

### Sample implementation

Core of the NFC reading module is `CertnIDNfcTravelDocumentReader` which reads NFC data from a document and provides `CertnIDTravelDocument` result and information about the reading status. You need `CertnIDNfcTravelDocumentReader` to be initialized with a
`CertnIDNfcTravelDocumentReaderConfiguration` which contains `authorityCertificatesUrl` -- file URL with Country Signing Certificate Authority (CSCA) certificates in `PEM` format. After `CertnIDNfcTravelDocumentReader` is initilized, you can setup its delegate using `setDelegate(_ delegate: (any CertnIDMobileSDK.CertnIDNfcTravelDocumentReaderDelegate)?, queue: DispatchQueue? = .main)` function and start NFC data reading with it, by calling `read(nfcKey: CertnIDNfcKey, activeAuthenticationChallenge: Data? = nil)`, where `CertnIDNfcKey` is an NFC key created from the document number, date of expiry and date of birth. `CertnIDNfcTravelDocumentReaderDelegate` then will receive status updates.

```swift
import CertnIDMobileSDK
import UIKit

class NfcViewController: UIViewController {
    private let nfcKey: CertnIDNfcKey?
    private let nfcReader: CertnIDNfcTravelDocumentReader

    init() {
        self.nfcKey = try? CertnIDNfcKey(
            documentNumber: "PASTE DOCUMENT NUMBER HERE",
            dateOfExpiry: "PASTE DATE OF EXPIRY HERE",
            dateOfBirth: "PASTE DATE OF BIRTH HERE"
        )

        let authorityCertificatesUrl = Bundle.main.url(forResource: "authority_certificates", withExtension: "pem")
        let configuration = CertnIDNfcTravelDocumentReaderConfiguration(authorityCertificatesUrl: authorityCertificatesUrl)
        self.nfcReader = CertnIDNfcTravelDocumentReader(configuration: configuration)
        super.init(nibName: nil, bundle: nil)
        nfcReader.setDelegate(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }

    func start() {
        guard let nfcKey else {
            print("Failed to init NFC Key")
            return
        }

        nfcReader.read(
            nfcKey: nfcKey
        )
    }
}

extension NfcViewController: CertnIDNfcTravelDocumentReaderDelegate {
    func nfcTravelDocumentReader(
        _ nfcTravelDocumentReader: CertnIDMobileSDK.CertnIDNfcTravelDocumentReader,
        succeeded travelDocument: CertnIDMobileSDK.CertnIDTravelDocument
    ) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encoded = try? encoder.encode(travelDocument) {
            print(String(data: encoded, encoding: .utf8) ?? "Failed to encode data")
        }
    }

    func nfcTravelDocumentReader(
        _ nfcTravelDocumentReader: CertnIDMobileSDK.CertnIDNfcTravelDocumentReader,
        failed error: String
    ) {
        print(error)
    }

    func nfcTravelDocumentReaderCanceled(
        _ nfcTravelDocumentReader: CertnIDMobileSDK.CertnIDNfcTravelDocumentReader
    ) {
        print("User cancelled NFC reading")
    }
}
```

### CertnIDNfcTravelDocumentReader

`CertnIDNfcTravelDocumentReader` is used to start the process of reading NFC data. It should be initialized with `CertnIDNfcTravelDocumentReaderConfiguration` and a `CertnIDNfcTravelDocumentReaderDelegate` should be properly set up to get the callbacks from a reader. After initializing and setting up delegate, start reading data by calling `read(nfcKey: CertnIDMobileSDK.CertnIDNfcKey, activeAuthenticationChallenge: Data? = nil)` function. See the description of `CertnIDNfcKey` and `activeAuthenticationChallenge` below.

```swift
    /// Current configuration.
    @objc final public let configuration: CertnIDMobileSDK.CertnIDNfcTravelDocumentReaderConfiguration

    /// Initialize and configure `CertnIDNfcTravelDocumentReader`.
    @objc public init(configuration: CertnIDMobileSDK.CertnIDNfcTravelDocumentReaderConfiguration)

    /// Set delegate and `DispatchQueue` on which you want to recieve the delegate callbacks. `CertnIDNfcTravelDocumentReader` will hold weak reference to `delegate` and `queue`.
    @objc final public func setDelegate(_ delegate: (any CertnIDMobileSDK.CertnIDNfcTravelDocumentReaderDelegate)?, queue: DispatchQueue? = .main)

    /// Read passport using NFC key.
    ///
    /// You can handle success or failure of NFC reading by implementing the delegate methods.
    ///
    /// - Parameter nfcKey: NFC key created from the document number, date of expiry and date of birth.
    /// - Parameter activeAuthenticationChallenge: Random 8 bytes. If the Active Authentication challenge is set, Active Authentication protocol will be used for the authentication of the chip (if supported by the chip). Response (signature) will be returned in the result of the read operation. This response should be validated by the application server to verify the authenticity of the chip. In case when the Active Authentication protocol is not supported by the chip, the chip will be authenticated the same way as if the argument `activeAuthenticationChallenge` is not set.
    @objc final public func read(nfcKey: CertnIDMobileSDK.CertnIDNfcKey, activeAuthenticationChallenge: Data? = nil)
```

### CertnIDNfcTravelDocumentReaderConfiguration

`CertnIDNfcTravelDocumentReaderConfiguration` is used to provide an information about the location of Country Signing Certificate Authority (CSCA) certificates in `PEM` format file. It has only one parameter:
```swift
 @objc final public let authorityCertificatesUrl: URL?
 ```

### CertnIDNfcKey

`CertnIDNfcKey` is the access key to NFC data:
```swift
    /// Document number in MRZ format.
    @objc final public let documentNumber: String

    /// Date of expiry in MRZ format [yyMMdd].
    @objc final public let dateOfExpiry: String

    /// Date of birth in MRZ format [yyMMdd].
    @objc final public let dateOfBirth: String
```

### ActiveAuthenticationChallenge

`ActiveAuthenticationChallenge` is used in case, when server-side authentication of the chip is required. If the Active Authentication protocol is supported by the chip, it will be used for the authentication of the chip and the response (signature) will be returned in TravelDocument class.

### CertnIDNfcTravelDocumentReaderDelegate

`CertnIDNfcTravelDocumentReaderDelegate` is a protocol which allows back communication with the app, it sends the status and result of NFC reading:
```swift
    /// Tells the delegate that NFC reading has finished successfully with travel document as a result.
    @objc func nfcTravelDocumentReader(_ nfcTravelDocumentReader: CertnIDMobileSDK.CertnIDNfcTravelDocumentReader, succeeded travelDocument: CertnIDMobileSDK.CertnIDTravelDocument)

    /// Tells the delegate that NFC reading has failed with an error.
    @objc func nfcTravelDocumentReader(_ nfcTravelDocumentReader: CertnIDMobileSDK.CertnIDNfcTravelDocumentReader, failed error: String)

    /// Tells the delegate that NFC reading has been canceled by the system dialog cancel button on click event.
    @objc func nfcTravelDocumentReaderCanceled(_ nfcTravelDocumentReader: CertnIDMobileSDK.CertnIDNfcTravelDocumentReader)
```

### CertnIDTravelDocument

`CertnIDTravelDocument` is an Encodable object which you can encode and send the data to server for processing. It has following available parameters:

```swift
public let ldsVersion: String
public let accessControlProtocolUsed: CertnIDAccessControlProtocol?
public let authenticationStatus: CertnIDAuthenticationStatus
public let faceImageBase: String?
public let machineReadableZone: CertnIDMachineReadableZone
public let dataGroups: [CertnIDDataGroup]?
```

## Support and Documentation

For detailed documentation and support, visit the [TrustmaticMobileSDK Documentation](https://demo.trustmatic.io/documentation/) or contact support at [support@trustmatic.com](mailto:support@trustmatic.com).

## License

CertnIDMobileSDK is available under a commercial license. For more information, please refer to the official website or contact the sales team.

## Version history

- 0.0.5: 02.10.2024
* New NFC data structure
- 0.0.4: 25.09.2024 
* Initial version
