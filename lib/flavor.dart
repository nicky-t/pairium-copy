import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';

enum FlavorType { dev, stg, prod }

enum BuildMode { release, debug }

final flavorProvider = Provider((ref) => Flavor());

class Flavor {
  Flavor() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      switch (packageInfo.packageName) {
        case 'com.shift-share.dev':
          current = FlavorType.dev;
          break;
        case 'com.nicky.shift-share.dev':
          current = FlavorType.dev;
          break;
        case 'com.shift-share.stg':
          current = FlavorType.stg;
          break;
        case 'com.nicky.shift-share.stg':
          current = FlavorType.stg;
          break;
        case 'com.shift-share.prod':
          current = FlavorType.prod;
          break;
        case 'com.nicky.shift-share.prod':
          current = FlavorType.prod;
          break;
        default:
          current = FlavorType.dev;
      }
      const bool.fromEnvironment('dart.vm.product')
          ? buildMode = BuildMode.release
          : buildMode = BuildMode.debug;
    });
  }

  FlavorType? current;
  late BuildMode buildMode;
}
