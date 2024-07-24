# ``CertnIDMobileSDK``

CertnIDMobileSDK is a powerful iOS library designed to streamline and secure the digital onboarding process. This SDK offers robust features for verifying identities, capturing and validating documents, and ensuring compliance with regulatory requirements.

## Key Features
- **Identity Verification:** Uses advanced algorithms to verify user identities through biometric recognition and document analysis.
- **Document Capture and Validation:** Supports capturing high-quality images of identity documents and validates them against various security features.
- **Liveness Detection:** Ensures that the user is physically present during the onboarding process through liveness detection techniques.
- **Regulatory Compliance:** Helps businesses stay compliant with KYC (Know Your Customer) and AML (Anti-Money Laundering) regulations.
- **User-Friendly Interface:** Provides a seamless and intuitive user experience with customizable UI elements.
- **Data Security:** Ensures the highest level of data security with end-to-end encryption.

## Installation
To integrate CertnIDMobileSDK into your iOS project, follow these steps:

### Using CocoaPods
1. Add the following line to your `Podfile`:
    ```ruby
    source 'https://github.com/certn-id-mobile-sdk/ios-sdk'
    pod 'CertnIDMobileSDK'
    ```
2. Run `pod install` to install the SDK.

### Manual Installation
1. Download the CertnIDMobileSDK framework from the official website.
2. Drag and drop the framework into your Xcode project.
3. Ensure the framework is included in the "Linked Frameworks and Libraries" section of your target's settings.

## Usage
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
                            .faceBalanced,
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

## Support and Documentation
For detailed documentation and support, visit the [TrustmaticMobileSDK Documentation] (https://demo.trustmatic.io/documentation/) or contact support at [support@trustmatic.com](mailto:support@trustmatic.com).

## License
CertnIDMobileSDK is available under a commercial license. For more information, please refer to the official website or contact the sales team.
