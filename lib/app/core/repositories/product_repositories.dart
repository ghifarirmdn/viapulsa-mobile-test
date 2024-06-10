import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:viapulsa_mobile_test/app/constants/endpoints.dart';
import 'package:viapulsa_mobile_test/app/core/models/product_model.dart';

class ProductRepository {
  final dio = Dio();

  Future<List<ProductModel>> getAllProduct() async {
    try {
      final res = await dio.get(Endpoints.products);

      if (res.statusCode == 200 || res.statusCode == 201) {
        return (res.data as List).map((e) => ProductModel.fromJson(e)).toList();
      }
    } catch (e) {
      log("error repositories: $e");
      return [];
    }
    return [];
  }

  Future<ProductModel?> addProduct({
    required String productName,
    required String productDescription,
  }) async {
    final Map<String, dynamic> data = {
      'name': productName,
      'description': productDescription
    };
    try {
      final res = await dio.post(Endpoints.products, data: data);

      if (res.statusCode == 200 || res.statusCode == 201) {
        log(res.toString());
        return ProductModel.fromJson(res.data);
      }
    } catch (e) {
      log("error repositories: $e");
    }
    return null;
  }

  Future<ProductModel?> getProductById(String id) async {
    try {
      final res = await dio.get(Endpoints.detailProduct.replaceAll("id", id));

      if (res.statusCode == 200 || res.statusCode == 201) {
        return ProductModel.fromJson(res.data);
      }
    } catch (e) {
      log("error repositories: $e");
    }
    return null;
  }

  Future<ProductModel?> updateProduct({
    required String id,
    String? productName,
    String? productDescription,
  }) async {
    final Map<String, dynamic> data = {
      'name': productName,
      'description': productDescription
    };
    try {
      final res = await dio.put(Endpoints.detailProduct.replaceAll("id", id),
          data: data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return ProductModel.fromJson(res.data);
      }
    } catch (e) {
      log("error repositories: $e");
    }
    return null;
  }

  Future<ProductModel?> deleteProduct(String id) async {
    try {
      final res =
          await dio.delete(Endpoints.detailProduct.replaceAll("id", id));

      if (res.statusCode == 200 || res.statusCode == 201) {
        return ProductModel.fromJson(res.data);
      }
    } catch (e) {
      log("error repositories: $e");
    }
    return null;
  }
}
