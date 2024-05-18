import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_example_config/firebase_options_dev.dart' as dev;
import 'package:flavor_example_config/firebase_options_prod.dart' as prod;

enum FlavorTypes { dev, prod }

class Flavor {
  Flavor._instance();

  static late FlavorTypes flavorType;

  static String get flavorMessage {
    switch (flavorType) {
      case FlavorTypes.dev:
        return 'Development';
      case FlavorTypes.prod:
        return 'Production';
      default:
        return 'Development';
    }
  }

  static String get apiBaseUrl {
    switch (flavorType) {
      case FlavorTypes.dev:
        return 'apiUrlBaseDev';
      case FlavorTypes.prod:
        return 'apiUrlBaseProd';
      default:
        return 'apiUrlBaseDev';
    }
  }

  static bool isProduction() => flavorType == FlavorTypes.prod;
  static bool isDevelopment() => flavorType == FlavorTypes.dev;

  static FirebaseOptions get firebaseConfigOptions {
    switch (flavorType) {
      case FlavorTypes.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case FlavorTypes.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
      default:
        return dev.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
