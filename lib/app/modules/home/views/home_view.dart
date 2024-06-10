import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:viapulsa_mobile_test/app/constants/app_colors.dart';
import 'package:viapulsa_mobile_test/app/core/models/product_model.dart';
import 'package:viapulsa_mobile_test/app/routes/app_pages.dart';
import 'package:viapulsa_mobile_test/app/widgets/form_input_widget.dart';
import 'package:viapulsa_mobile_test/app/widgets/snakebar_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('HomeView'),
            centerTitle: true,
          ),
          body: controller.products?.isNotEmpty ?? false
              ? Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      MyFormInput(
                        hintText: 'Search product...',
                        onChanged: (value) {
                          controller.searchProduct(value);
                        },
                        suffixIcon: const Icon(Icons.search),
                        // controller: controller.productNameController,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.foundedProduct?.length ?? 0,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                Get.dialog(const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ));
                                ProductModel? data =
                                    await controller.getProductById(
                                        controller.foundedProduct?[index].id ??
                                            "");
                                Get.back();
                                Get.toNamed(
                                  Routes.EDIT_PRODUCT,
                                  arguments: data,
                                );
                              },
                              child: ListTile(
                                title: Text(
                                    controller.foundedProduct?[index].name ??
                                        ''),
                                subtitle: Text(controller
                                        .foundedProduct?[index].description
                                        .toString() ??
                                    ''),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColor.red,
                                  ),
                                  onPressed: () {
                                    Get.dialog(
                                      Theme(
                                        data: ThemeData(
                                          cardColor: Colors.white,
                                        ),
                                        child: AlertDialog(
                                          alignment: Alignment.center,
                                          title: const Text(
                                            "Are you sure to delete this item?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text(
                                                "No",
                                                style: TextStyle(
                                                  color: AppColor.grey300,
                                                ),
                                              ),
                                              onPressed: () => Get.back(),
                                            ),
                                            TextButton(
                                              child: const Text(
                                                "Yes",
                                                style: TextStyle(
                                                  color: AppColor.primary,
                                                ),
                                              ),
                                              onPressed: () {
                                                controller
                                                    .deleteProduct(controller
                                                            .foundedProduct?[
                                                                index]
                                                            .id ??
                                                        "")
                                                    .then((value) async {
                                                  Get.back();
                                                  MySnakebar.success(
                                                      title: "Success",
                                                      subtitle:
                                                          "Success delete product!");
                                                  await controller
                                                      .getAllProducts();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 12,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      key: const ValueKey<int>(1),
                      baseColor: Colors.grey.shade200,
                      direction: ShimmerDirection.ltr,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        width: Get.width * 0.8,
                        height: 40,
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.resetAll();
              Get.toNamed(Routes.ADD_PRODUCT);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
