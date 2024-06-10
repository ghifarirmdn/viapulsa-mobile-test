import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viapulsa_mobile_test/app/constants/app_colors.dart';
import 'package:viapulsa_mobile_test/app/widgets/button_widget.dart';
import 'package:viapulsa_mobile_test/app/widgets/form_input_widget.dart';
import 'package:viapulsa_mobile_test/app/widgets/label_form_widget.dart';
import 'package:viapulsa_mobile_test/app/widgets/snakebar_widget.dart';

import '../controllers/home_controller.dart';

class AddProductView extends GetView<HomeController> {
  const AddProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Add Product View'),
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
                    text: "Submit",
                    onTap: () async {
                      if (!controller.key.currentState!.validate()) {
                        return;
                      }
                      await controller
                          .addProduct(
                        productName: controller.productNameController.text,
                        productDescription:
                            controller.productDescriptionController.text,
                      )
                          .then(
                        (value) async {
                          if (value != null) {
                            Get.back();
                            controller.resetAll();
                            MySnakebar.success(
                              title: "Success",
                              subtitle: "Success add product!",
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
