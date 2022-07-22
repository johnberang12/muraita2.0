import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/alert_dialogs.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/data/fire_storage_repository.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/presentation/edit_profile_screen_controller.dart';
import 'package:muraita_2_0/src/services/api_path.dart';
import '../../../../common_widgets/clear_text_field.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_dropdown_button.dart';
import '../../../../common_widgets/image_display_tab.dart';
import '../../../../common_widgets/custom_text.dart';
import '../../../../constants/app_colors.dart';

import '../../../../constants/strings.dart';
import '../../data/products_repository.dart';
import '../../domain/product.dart';
import 'add_product_camera_controller.dart';
import 'add_product_screen_controller.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();
DateTime currentDateTime() => DateTime.now().toUtc();

class AddProductScreen extends ConsumerWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  ///to be supplied with location from api

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    final controller = ref.watch(addProductScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          kAddListingTitle,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          TextButton(
              child: const Text(
                kDone,
              ),
              onPressed: () => controller.submitForm(context, ref)),
        ],
      ),
      body: const _BuidContents(
          // formKey: _formKey,
          // titleController: _productTitleController,
          // discriptionController: _productDescriptionController,
          // priceController: _productPriceController,
          ),
    );
  }
}

class _BuidContents extends ConsumerWidget {
  const _BuidContents(
      // required this.formKey,
      // required this.titleController,
      // required this.discriptionController,
      // required this.priceController,
      );
  // final GlobalKey formKey;
  // final TextEditingController titleController;
  // final TextEditingController discriptionController;
  // final TextEditingController priceController;

  final String _defaultValue = 'Choose Category';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final selectedCategory = ref.watch(productCategoryProvider.state).state;
    final controller = ref.watch(addProductScreenControllerProvider);
    final isSubmitted = ref.watch(isProductSubmittedProvider.state).state;

    return CustomBody(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Divider(height: 0.5),

              ///comment this image for the sake of setting up save data function

              const ImageDisplayTab(),
              const Divider(
                height: 0.5,
              ),
              SizedBox(height: height * 0.03),

              ///title field
              ClearTextField(
                controller: controller.productTitleController,
                label: kListingTitleLabel,
                autovalidateMode: AutovalidateMode.always,
                validator: (title) => !isSubmitted
                    ? null
                    : controller.titleErrorText(title ?? ''),
              ),
              const Divider(
                height: 0.5,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomDropdownButton(
                defaultHint:
                    selectedCategory == '' ? _defaultValue : selectedCategory,
                listItems: kListingCategories,
                verticalPadding: height * 0.03,
                onChanged: (value) =>
                    ref.read(productCategoryProvider.state).state = value!,
              ),
              const Divider(
                height: 0.5,
              ),
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  ClearTextField(
                      controller: controller.productPriceController,
                      label: kPriceLabel,
                      width: width * 0.6,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (price) => !isSubmitted
                          ? null
                          : controller.priceErrorText(price ?? '')),
                  Row(
                    children: [
                      Checkbox(
                          fillColor: primaryMaterailColor,
                          value:
                              ref.watch(negotiableToggleProvider.state).state,
                          shape: const CircleBorder(),
                          onChanged: (bool? value) => ref
                              .read(negotiableToggleProvider.state)
                              .state = value!),
                      const CustomText(
                        'Negotiable',
                        color: AppColors.black40,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              const Divider(
                height: 0.5,
              ),
              ClearTextField(
                controller: controller.productDescriptionController,
                label: kListingDescriptionLabel,
                autovalidateMode: AutovalidateMode.always,
                validator: (description) => !isSubmitted
                    ? null
                    : controller.descriptionErrorText(description!),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
