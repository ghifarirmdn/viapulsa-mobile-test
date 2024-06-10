import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viapulsa_mobile_test/app/core/models/product_model.dart';
import 'package:viapulsa_mobile_test/app/core/repositories/product_repositories.dart';

class HomeController extends GetxController {
  final productRepository = ProductRepository();
  final key = GlobalKey<FormState>();

  List<ProductModel>? products;
  RxList<ProductModel>? foundedProduct = <ProductModel>[].obs;
  // final RxList<ProductModel>? foundedProduct = <ProductModel>[].obs;

  RxBool isLoading = false.obs;

  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
  }

  void resetAll() {
    productNameController.clear();
    productDescriptionController.clear();
    update();
  }

  Future<List<ProductModel>> searchProduct(String query) async {
    foundedProduct?.value = products!
        .where((product) =>
            product.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    update();
    return foundedProduct!.toList();
  }

  Future<List<ProductModel>> getAllProducts() async {
    final res = await productRepository.getAllProduct();
    if (res.isNotEmpty) {
      products = res;
      foundedProduct?.value = res.cast<ProductModel>();
    }
    update();
    return res;
  }

  Future<ProductModel?> addProduct({
    required String productName,
    required String productDescription,
  }) async {
    final res = await productRepository.addProduct(
      productName: productName,
      productDescription: productDescription,
    );
    update();
    return res;
  }

  Future<ProductModel?> getProductById(String id) async {
    final res = await productRepository.getProductById(id);
    update();
    return res;
  }

  Future<ProductModel?> updateProduct(
    String id,
    String productName,
    String productDescription,
  ) async {
    final res = await productRepository.updateProduct(
      id: id,
      productName: productName,
      productDescription: productDescription,
    );
    log(res!.name.toString());
    update();
    return res;
  }

  Future<void> deleteProduct(String id) async {
    await productRepository.deleteProduct(id);
    update();
  }
}
