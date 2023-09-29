import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterquiz/features/profileManagement/cubits/userDetailsCubit.dart';
import 'package:flutterquiz/features/systemConfig/cubits/systemConfigCubit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

AppOpenAd? openAd;
bool adOpened = false;

abstract class InterstitialAdState {}

class InterstitialAdInitial extends InterstitialAdState {}

class InterstitialAdLoaded extends InterstitialAdState {}

class InterstitialAdLoadInProgress extends InterstitialAdState {}

class InterstitialAdFailToLoad extends InterstitialAdState {}

class InterstitialAdCubit extends Cubit<InterstitialAdState> {
  InterstitialAdCubit() : super(InterstitialAdInitial());

  InterstitialAd? _interstitialAd;

  InterstitialAd? get interstitialAd => _interstitialAd;

  void _createGoogleInterstitialAd(BuildContext context) {
    InterstitialAd.load(
      adUnitId: context.read<SystemConfigCubit>().googleInterstitialAdId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print("InterstitialAd Ad loaded successfully");
          _interstitialAd = ad;
          emit(InterstitialAdLoaded());
        },
        onAdFailedToLoad: (err) {
          print(err);
          emit(InterstitialAdFailToLoad());
        },
      ),
    );
  }

  void _createUnityAds() {
    UnityAds.load(
      placementId: unityInterstitialPlacement(),
      onComplete: (placementId) => emit(InterstitialAdLoaded()),
      onFailed: (placementId, err, msg) => emit(InterstitialAdFailToLoad()),
    );
  }

  void createInterstitialAd(BuildContext context) {
    final systemConfigCubit = context.read<SystemConfigCubit>();
    if (systemConfigCubit.isAdsEnable() &&
        !context.read<UserDetailsCubit>().removeAds()) {
      emit(InterstitialAdLoadInProgress());
      final adsType = systemConfigCubit.adsType();
      if (adsType == 1) {
        _createGoogleInterstitialAd(context);
      } else {
        _createUnityAds();
      }
    }
  }

  void showAd(BuildContext context) {
    //if ad is enable
    final sysConfigCubit = context.read<SystemConfigCubit>();
    if (sysConfigCubit.isAdsEnable() &&
        !context.read<UserDetailsCubit>().removeAds()) {
      //if ad loaded succesfully
      if (state is InterstitialAdLoaded) {
        //show google interstitial ad
        final adsType = sysConfigCubit.adsType();
        if (adsType == 1) {
          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) {},
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              createInterstitialAd(context);
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              createInterstitialAd(context);
            },
          );
          interstitialAd?.show();
        } else {
          //show Unity interstitial ad
          UnityAds.showVideoAd(
            placementId: unityInterstitialPlacement(),
            onComplete: (placementId) => createInterstitialAd(context),
            onFailed: (placementId, error, message) =>
                print('Video Ad $placementId failed: $error $message'),
            onStart: (placementId) => print('Video Ad $placementId started'),
            onClick: (placementId) => print('Video Ad $placementId click'),
            onSkipped: (placementId) => createInterstitialAd(context),
          );
        }
      } else if (state is InterstitialAdFailToLoad) {
        createInterstitialAd(context);
      }
    }
  }

  Future<void> loadOpenAd() async {
    await AppOpenAd.load(
        adUnitId: "ca-app-pub-4828471636798994/3300014048",
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
          print('ad is loaded');
          openAd = ad;
          openAd!.show();
          //openAd!.show();
        }, onAdFailedToLoad: (error) {
          print('ad failed to load $error');
        }),
        orientation: AppOpenAd.orientationPortrait);
  }

  void showOpenAd() {
    if (openAd == null) {
      print('trying tto show before loading');
      loadOpenAd();
      return;
    }
    openAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        print('failed to load $error');
        openAd = null;
        loadOpenAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        print('dismissed');
        openAd = null;
        loadOpenAd();
      },
    );

    openAd!.show();
  }

  String unityInterstitialPlacement() {
    if (Platform.isAndroid) {
      return "Interstitial_Android";
    }
    if (Platform.isIOS) {
      return "Interstitial_iOS";
    }

    return "";
  }

  @override
  Future<void> close() async {
    _interstitialAd?.dispose();

    return super.close();
  }
}
