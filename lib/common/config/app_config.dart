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
    // await Firebase.initializeApp();

    // setup Crashlytics
    // await CrashlyticsLogger.init();

    _instance = AppConfig._internal(
      apiBaseUrl: "asdasd",
    );
  }

  AppConfig._internal({
    required this.apiBaseUrl,
  });

  static AppConfig get instance => AppConfig();
}
