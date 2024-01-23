import 'package:firebase_core/firebase_core.dart';

class AppConfig {
  late final String apiBaseUrl;

  static AppConfig? _instance;

  factory AppConfig() {
    if (_instance == null) {
      throw UnimplementedError('AppConfig must be initialized first.');
    }

    return _instance!;
  }

  static Future<void> initialize() async {
    // setup Firebase
    await Firebase.initializeApp();

    // await FirebaseAppCheck.instance.activate(
    //   // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    //   // argument for `webProvider`
    //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    //   // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    //   // your preferred provider. Choose from:
    //   // 1. Debug provider
    //   // 2. Safety Net provider
    //   // 3. Play Integrity provider
    //   androidProvider: AndroidProvider.debug,
    //   // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    //   // your preferred provider. Choose from:
    //   // 1. Debug provider
    //   // 2. Device Check provider
    //   // 3. App Attest provider
    //   // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    //   appleProvider: AppleProvider.appAttest,
    // );

    _instance = AppConfig._internal(
      apiBaseUrl: "https://dev-api.fortiusys.com/api",
    );
  }

  AppConfig._internal({
    required this.apiBaseUrl,
  });

  static AppConfig get instance => AppConfig();
}
