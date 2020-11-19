import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

enum SubscriptionStatus { Subscribed, Expire, NotSubscribed }
enum ServiceStatus { PremiumService, AdvanceService, NotPurchased }

class IAPService with ChangeNotifier {
  InAppPurchaseConnection _conntetion;
  StreamSubscription<List<PurchaseDetails>> _controller;

  List<PurchaseDetails> _purchasesList = [];
  PurchaseStatus _monthlySubscriptionStatus = PurchaseStatus.pending;
  ServiceStatus _serviceStatus = ServiceStatus.NotPurchased;

  // Get all values
  PurchaseStatus get monthlySubscriptionStatus => _monthlySubscriptionStatus;
  ServiceStatus get serviceStatus => _serviceStatus;

  // IAPService.instance() : _conntetion = InAppPurchaseConnection.instance {
  //   _conntetion.purchaseUpdatedStream.listen(onUpdate);
  // }

  IAPService() {
    startService();
  }

  startService() async {
    try {
      _conntetion = InAppPurchaseConnection.instance;
      _controller = _conntetion.purchaseUpdatedStream.listen(onUpdate);
      if (await serviceAvailable()) {
        await loadPreviousPurchases();
      } else {
        printError(info: "Service not available");
      }
    } catch (e) {
      Get.snackbar('Error!', "$e");
    }
  }

  Future<bool> serviceAvailable() async {
    final bool available = await InAppPurchaseConnection.instance.isAvailable();
    return available;
  }

  Future<ProductDetails> getProductDetails(String id) async {
    ProductDetailsResponse response;
    try {
      final Set<String> _kIds = {'$id'};
      response = await _conntetion.queryProductDetails(_kIds);
      if (response.notFoundIDs.isNotEmpty) {
        Get.snackbar('Not Found', "${response.notFoundIDs.toString()}");
      }
    } catch (e) {
      Get.snackbar('Error', "$e}");
    }
    return response.productDetails.first;
  }

  Future<bool> purchaseItem(String id, {bool isConsumable = true}) async {
    ProductDetails product = await getProductDetails('$id');
    return await _processPurchaseItem(product, isConsumable);
  }

  Future<bool> consumeItem(String id) async {
    int index = _purchasesList.indexWhere((element) => element.productID == id);
    if (index >= 0) {
      await _conntetion.consumePurchase(_purchasesList[index]);
      await loadPreviousPurchases();
      return true;
    }
    return false;
  }

  PurchaseDetails getPurchaseItemFromData(String id) {
    int index = _purchasesList.indexWhere((element) => element.productID == id);
    if (index >= 0) {
      return _purchasesList[index];
    }
    return null;
  }

  Future loadPreviousPurchases() async {
    final QueryPurchaseDetailsResponse response =
        await _conntetion.queryPastPurchases();
    if (response.error != null) {
      printError(info: "Query PastPurchase Error : ${response.error.message}");
    }
    // if (response.pastPurchases.isEmpty) {
    //   ProductDetails product = await getProductDetails('month_subscription');
    //   await purchaseItem(product);
    // }
    printInfo(info: "Past Purchase Length : ${response.pastPurchases.length}");
    _purchasesList = [];
    _purchasesList.addAll(response.pastPurchases);
    updateIAPStates();
    // for (PurchaseDetails purchase in response.pastPurchases) {
    //   printInfo(
    //       info:
    //           "Privous Purchase : ${purchase.purchaseID} => ${purchase.status}, ${purchase.productID}");
    //           purchasesList.add(value)
    //   if (Platform.isIOS) {
    //     InAppPurchaseConnection.instance.completePurchase(purchase);
    //   }
    // }
  }

  Future<bool> _processPurchaseItem(
      ProductDetails item, bool isConsumable) async {
    final ProductDetails productDetails =
        item; // Saved earlier from queryPastPurchases().
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    bool isPurchased;
    if (isConsumable) {
      isPurchased = await _conntetion.buyConsumable(
          purchaseParam: purchaseParam, autoConsume: false);
    } else {
      isPurchased =
          await _conntetion.buyNonConsumable(purchaseParam: purchaseParam);
    }
    return isPurchased;
  }

  onUpdate(List<PurchaseDetails> details) async {
    // _purchasesList = [];
    printInfo(info: "ONUPDATE PURCHSE : ${details.length} ");
    // _purchasesList.addAll(details);
    await loadPreviousPurchases();
  }

  updateIAPStates() {
    if (_purchasesList.isEmpty) return;
    try {
      _purchasesList.forEach((e) {
        printInfo(info: "${e.productID} => ${e.status}");
      });
      int subscriptionIndex = _purchasesList
          .indexWhere((element) => element.productID == 'month_subscription');
      if (subscriptionIndex >= 0) {
        _monthlySubscriptionStatus = _purchasesList[subscriptionIndex].status;
      }

      int premiumServiceIndex = _purchasesList
          .indexWhere((element) => element.productID == 'premium_service');
      if (premiumServiceIndex >= 0) {
        _serviceStatus = ServiceStatus.PremiumService;
      }

      int advanceServiceIndex = _purchasesList
          .indexWhere((element) => element.productID == 'advance_service');
      if (advanceServiceIndex >= 0) {
        _serviceStatus = ServiceStatus.AdvanceService;
      }
      if (advanceServiceIndex < 0 && premiumServiceIndex < 0) {
        _serviceStatus = ServiceStatus.NotPurchased;
      }
    } catch (e) {
      Get.snackbar('Error!', 'Error IAP update states : $e');
    }
    printInfo(info: 'Subscription Status $_monthlySubscriptionStatus ');
    printInfo(info: 'Service Status $_serviceStatus ');

    notifyListeners();
  }
}
