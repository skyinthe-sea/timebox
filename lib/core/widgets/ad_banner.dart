import 'package:flutter/material.dart';

/// 광고 배너 위젯
///
/// 화면 상단에 표시되는 AdMob 배너 광고
///
/// 기능:
/// - 광고 로드 상태 관리
/// - 로드 실패 시 공간 축소
/// - 테스트 모드 지원
class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  // TODO: BannerAd 인스턴스 추가
  // BannerAd? _bannerAd;
  // ignore: prefer_final_fields - will be modified when AdMob is implemented
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    // TODO: AdMob 배너 광고 로드 구현
    // _bannerAd = BannerAd(
    //   adUnitId: Platform.isAndroid
    //       ? 'ca-app-pub-xxxxx/xxxxx'
    //       : 'ca-app-pub-xxxxx/xxxxx',
    //   size: AdSize.banner,
    //   request: const AdRequest(),
    //   listener: BannerAdListener(
    //     onAdLoaded: (ad) => setState(() => _isLoaded = true),
    //     onAdFailedToLoad: (ad, error) {
    //       ad.dispose();
    //       setState(() => _isLoaded = false);
    //     },
    //   ),
    // )..load();
  }

  @override
  void dispose() {
    // TODO: _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const SizedBox.shrink();
    }

    // TODO: AdWidget 반환
    // return SizedBox(
    //   height: _bannerAd!.size.height.toDouble(),
    //   child: AdWidget(ad: _bannerAd!),
    // );

    return Container(
      height: 50,
      color: Colors.grey[200],
      child: const Center(
        child: Text('Ad Placeholder'),
      ),
    );
  }
}
