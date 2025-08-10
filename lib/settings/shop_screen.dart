import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../admod/helper.dart';
import '../home_screen.dart';

const String termsOfUse = "https://sites.google.com/view/lisatermofuse/home";
const String privatePolicy =
    "https://sites.google.com/view/privacypolicylisa/home";
const yearly = "19.99USD";
const monthly = "4.99USD";
const weekly = "2.99USD";

const String _kUpgradeId = 'lisa.offline.weekly';
const String _kSilverSubscriptionId = 'lisa.offline.monthly';
const String _kGoldSubscriptionId = 'lisa.offline.yearly';
const List<String> _kProductIds = <String>[
  _kUpgradeId,
  _kSilverSubscriptionId,
  _kGoldSubscriptionId,
];
final bool _kAutoConsume = Platform.isIOS || true;

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction,
      SKStorefrontWrapper storefront,
      ) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

class AppPurchasePage extends StatefulWidget {
  AppPurchasePage(this.isMain, {super.key});

  bool isMain = false;

  @override
  State<AppPurchasePage> createState() => _AppPurchasePageState();
}

class _AppPurchasePageState extends State<AppPurchasePage> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
          (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (Object error) {
        // handle error here.
      },
    );
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        // _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse = await _inAppPurchase
        .queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        // _notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        // _loading = false;
      });
      print("Error: ${_queryProductError!}");
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        // _notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        // _loading = false;
      });
      print("No products found");
      return;
    }

    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchasePending = false;
      // _loading = false;
    });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = <Widget>[];
    stack.add(
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8E2DE2), // Purple
              Color(0xFF4A00E0), // Indigo
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
    // if (_queryProductError == null) {
    if (true) {
      stack.add(
        ListView(
          children: <Widget>[
            // _buildImage(),
            const SizedBox(height: 100),
            _buildSupportUs(),
            const SizedBox(height: 10),
            _buildProductList(),
            const SizedBox(height: 10),
            _buildRestoreButton(),
            const SizedBox(height: 20),
            _buildTermOfUse(),
            const SizedBox(height: 100),
          ],
        ),
      );
    } else {
      stack.add(Center(child: Text(_queryProductError!)));
    }
    if (_purchasePending) {
      stack.add(
        // TODO(goderbauer): Make this const when that's available on stable.
        // ignore: prefer_const_constructors
        Stack(
          children: const <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(child: CircularProgressIndicator()),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upgrade to Pro",
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (widget.isMain) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 1),
                    pageBuilder: (_, __, ___) =>
                    const HomeScreen(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child:
            widget.isMain
                ? const Icon(Icons.cancel, color: Colors.black45)
                : Container(),
          ),
        ],
        // backgroundColor: Colors.deepOrangeAccent.withOpacity(0.5),
        elevation: 0,
        // title: const Text("",
        //     style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 26,
        //         fontWeight: FontWeight.normal)),
      ),
      body: Stack(children: stack),
    );
  }

  Widget _buildRestoreButton() {
    return InkWell(
      onTap: () {
        _inAppPurchase.restorePurchases();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.deepOrange,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Restore",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermOfUse() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Text(
            "Enjoy full access with auto-renewing plans: Weekly ($weekly), Monthly ($monthly), and Yearly ($yearly). Cancel anytime. New users get priority support.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),

        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () async {
            if (await canLaunchUrl(Uri.parse(termsOfUse))) {
              await launchUrl(Uri.parse(termsOfUse));
            }
          },
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              "Term of Use",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () async {
            if (await canLaunchUrl(Uri.parse(privatePolicy))) {
              await launchUrl(Uri.parse(privatePolicy));
            }
          },
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              "Privacy Policy",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportUs() {
    return Column(
      children: [
        Container(
          height: 40,
          child: const Text(
            "Support us",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        _buildReasonSupport("Unlock all premium tools and features"),
        _buildReasonSupport("Enjoy a clean, ad-free experience"),
        _buildReasonSupport("Support ongoing improvements and innovation"),
      ],
    );
  }

  Widget _buildReasonSupport(String content) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      height: 40,
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 20, color: Colors.green),
          const SizedBox(width: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          image: AssetImage("assets/images/shop.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductList() {
    if (!_isAvailable) {
      return const Card();
    }
    final List<Widget> productList = <Widget>[];

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    final Map<String, PurchaseDetails> purchases =
    Map<String, PurchaseDetails>.fromEntries(
      _purchases.map((PurchaseDetails purchase) {
        if (purchase.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchase);
        }
        return MapEntry<String, PurchaseDetails>(
          purchase.productID,
          purchase,
        );
      }),
    );
    productList.addAll(
      _products.map((ProductDetails productDetails) {
        final PurchaseDetails? previousPurchase = purchases[productDetails.id];
        return InkWell(
          onTap: () {
            late PurchaseParam purchaseParam;
            if (Platform.isIOS) {
              purchaseParam = PurchaseParam(productDetails: productDetails);
            }
            _inAppPurchase
                .buyConsumable(
              purchaseParam: purchaseParam,
              autoConsume: _kAutoConsume,
            )
                .then((value) => {print("$value")});
            // _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.green,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productDetails.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  productDetails.price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
    return Column(children: productList);
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    print("purchase success");
    Helper.saveBool("purchase", true);
    setState(() {
      _purchases.add(purchaseDetails);
      _purchasePending = false;
    });
  }

  void handleError(IAPError error) {
    setState(() {
      print("not buy");
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList,
      ) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("pending UI");
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print("error");
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            print("valid");
            Helper.saveBool("purchase", true);
            unawaited(deliverProduct(purchaseDetails));
          } else {
            print("invalid");
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }

        if (purchaseDetails.pendingCompletePurchase) {
          print("pendingCompletePurchase");
          Helper.saveBool("purchase", true);
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    print("purchase app");
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }
}
