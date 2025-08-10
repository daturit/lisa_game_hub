import 'dart:io';

bool isRemoveAds = false;
const int maxFailedLoadAttempts = 3;

class AdHelper {
  static final _bannerAdUnitIds = {
    PlatformType.android: '',
    PlatformType.ios: '',
  };

  static final _interstitialAdUnitIds = {
    PlatformType.android: 'ca-app-pub-7457151700317461/8904687066',
    // PlatformType.ios: 'ca-app-pub-3940256099942544/4411468910',
    PlatformType.ios: 'ca-app-pub-7457151700317461/8904687066',
  };

  // static final _rewardInterstitialAdUnitIds = {
  //   PlatformType.android: 'ca-app-pub-7457151700317461/4621310206',
  //   // PlatformType.ios: 'ca-app-pub-3940256099942544/6978759866',
  //   PlatformType.ios: 'ca-app-pub-7457151700317461/4621310206',
  // };
  //
  // static final _rewardedAdUnitIds = {
  //   PlatformType.android: 'ca-app-pub-7457151700317461/9929994124',
  //   // PlatformType.ios: 'ca-app-pub-3940256099942544/1712485313',
  //   PlatformType.ios: 'ca-app-pub-7457151700317461/9929994124',
  // };

  static final _openAdUnitIds = {
    PlatformType.android: 'ca-app-pub-7457151700317461/2441869421',
    // PlatformType.ios: 'ca-app-pub-3940256099942544/5575463023',
    PlatformType.ios: 'ca-app-pub-7457151700317461/2441869421',
  };

  static String get bannerAdUnitId => _getAdUnitId(_bannerAdUnitIds);
  static String get interstitialAdUnitId => _getAdUnitId(_interstitialAdUnitIds);
  // static String get rewardInterstitialAdUnitId => _getAdUnitId(_rewardInterstitialAdUnitIds);
  // static String get rewardedAdUnitId => _getAdUnitId(_rewardedAdUnitIds);
  static String get openAdUnitId => _getAdUnitId(_openAdUnitIds);

  static String _getAdUnitId(Map<PlatformType, String> adMap) {
    final platform = Platform.isAndroid
        ? PlatformType.android
        : Platform.isIOS
        ? PlatformType.ios
        : null;

    if (platform == null || !adMap.containsKey(platform)) {
      throw UnsupportedError('Unsupported platform');
    }

    return adMap[platform]!;
  }
}

enum PlatformType { android, ios }
