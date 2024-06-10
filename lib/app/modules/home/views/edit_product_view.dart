import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viapulsa_mobile_test/app/constants/app_colors.dart';
import 'package:viapulsa_mobile_test/app/core/models/product_model.dart';
import 'package:viapulsa_mobile_test/app/widgets/button_widget.dart';
import 'package:viapulsa_mobile_test/app/widgets/form_input_widget.dart';
import 'package:viapulsa_mobile_test/app/widgets/label_form_widget.dart';
import 'package:viapulsa_mobile_test/app/widgets/snakebar_widget.dart';

import '../controllers/home_controller.dart';

class EditProductView extends GetView<HomeController> {
  const EditProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        ProductModel? product = Get.arguments;
        controller.productNameController.text = product?.name ?? "";
        controller.productDescriptionController.text =
            product?.description ?? "";
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Edit Product ${product?.name}',
              ),
              centerTitle: true,
            ),
            body: Form(
              key: controller.key,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                children: [
                  const MyLabelForm(text: "Product name"),
                  MyFormInput(
                    hintText: 'Enter product name',
                    validator: (p0) {
                      if (p0!.isEmpty && p0 == "") {
                        return "Product name cannot be empty!";
                      }
                      return null;
                    },
                    controller: controller.productNameController,
                  ),
                  const MyLabelForm(text: "Product description"),
                  MyFormInput(
                    hintText: 'Enter product description',
                    controller: controller.productDescriptionController,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Product description cannot be empty!";
                      }
                      return null;
                    },
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    color: AppColor.primary,
                    text: "Edit",
                    onTap: () async {
                      if (!controller.key.currentState!.validate()) {
                        return;
                      }
                      await controller
                          .updateProduct(
                              product!.id.toString(),
                              controller.productNameController.text,
                              controller.productDescriptionController.text)
                          .then(
                        (value) async {
                          if (value != null) {
                            Get.back();
                            controller.resetAll();
                            MySnakebar.success(
                              title: "Success",
                              subtitle: "Success edit product!",
                            );
                            await controller.getAllProducts();
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ));
      },
    );
  }
}
