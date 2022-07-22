// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:muraita_2_0/src/features/products/data/products_repository.dart';

import '../../../../common_widgets/alert_dialogs.dart';
import '../../../../constants/strings.dart';
import '../../../../services/api_path.dart';
import '../../../authentication/presentation/account/presentation/edit_profile/data/fire_storage_repository.dart';
import '../../domain/product.dart';
import 'add_product_camera_controller.dart';
import 'add_product_screen.dart';

class AddProductScreenController {
  AddProductScreenController({
    required this.ref,
  });
  Ref ref;

  final formKey = GlobalKey<FormState>();

  final StringValidator stringValidator = NonEmptyStringValidator();

  final productTitleController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();

  String get productTitle => productTitleController.text;
  String get productDescription => productDescriptionController.text;
  String get productPrice => productPriceController.text;
  final _location = 'Untracked';
  List<String> _imageUrls = [];

  bool _validateAndSaveForm() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      return true;
    }

    return false;
  }

  Future<void> submitForm(BuildContext context, WidgetRef ref) async {
    ref.read(isProductSubmittedProvider.state).state = true;
    print('submitted');

    final controller = ref.watch(addProductScreenControllerProvider);
    final imageList = ref.watch(productImageListProvider.state).state;
    if (controller.canSubmitTitle(productTitle) &&
        controller.canSubmitPrice(productPrice) &&
        controller.canSubmitDescription(productDescription) &&
        imageList.isNotEmpty) {
      print('valid');
      if (_validateAndSaveForm()) {
        print('success');
        print('success');
        final dialog = await showAlertDialog(
            context: context,
            title: 'Please confirm submission',
            cancelActionText: 'Cancle',
            defaultActionText: 'Submit');
        if (dialog == true) {
          EasyLoading.show(
            status: 'Saving in progress...',
          );
          _imageUrls = await _uploadImages(ref);
          if (_imageUrls.isNotEmpty) {
            await _saveProduct(context);
          } else {
            EasyLoading.showError('operation failed');
          }
        }
      }
    } else {
      EasyLoading.showError('operation failed');
    }
  }

  Future<void> _saveProduct(BuildContext context) async {
    final auth = ref.read(authRepositoryProvider);
    final database = ref.read(productsRepositoryProvider);
    final selectedCategory = ref.read(productCategoryProvider.state).state;
    final negotiable = ref.read(negotiableToggleProvider.state).state;

    final listing = Product(
      id: documentIdFromCurrentDate(),
      title: productTitle,
      photos: _imageUrls,
      category: selectedCategory,
      price: int.tryParse(productPrice)!,
      description: productDescription,
      location: _location,
      negotiable: negotiable,
      ownerId: auth.currentUser!.uid,
    );
    try {
      await database.setProduct(listing);
      EasyLoading.showSuccess('Success');
      Navigator.of(context).pop();
    } catch (e) {
      EasyLoading.dismiss();
      showAlertDialog(
          context: context, title: kOperationFailed, content: e.toString());
    }
  }

  Future<List<String>> _uploadImages(WidgetRef ref) async {
    final repository = ref.read(fireStorageRopositoryProvider);
    final imageList = ref.read(productImageListProvider.state).state;
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    final category = ref.read(productCategoryProvider.state).state;
    final dateTime = DateTime.now().toString();
    final List<String> urls = [];
    for (int i = 0; i < imageList.length; i++) {
      final file = imageList[i];

      var url = await repository.uploadImageFile(
          file, APIPath.productImagePath(userId!, category, dateTime));
      urls.add(url);
    }
    return urls;
  }
}

final addProductScreenControllerProvider = Provider<AddProductScreenController>(
    (ref) => AddProductScreenController(ref: ref));

final negotiableToggleProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final productCategoryProvider = StateProvider.autoDispose<String>((ref) {
  return kEmptyString;
});

final isProductSubmittedProvider =
    StateProvider.autoDispose<bool>((ref) => false);

extension AddProductScreenControllerX on AddProductScreenController {
  bool canSubmitTitle(String title) {
    return stringValidator.isValid(title);
  }

  bool canSubmitPrice(String price) {
    return stringValidator.isValid(price);
  }

  bool canSubmitDescription(String description) {
    return stringValidator.isValid(description);
  }

  String? titleErrorText(String title) {
    final bool showErrorText = !canSubmitTitle(title);
    final String errorText =
        title.isEmpty ? 'Title can\'t be empty' : 'Invalid title';
    return showErrorText ? errorText : null;
  }

  String? priceErrorText(String price) {
    final bool showErrorText = !canSubmitPrice(price);
    final String errorText =
        price.isEmpty ? 'Price can\'t be empty' : 'Invalid price';
    return showErrorText ? errorText : null;
  }

  String? descriptionErrorText(String description) {
    final bool showErrorText = !canSubmitDescription(description);
    final String errorText = description.isEmpty
        ? 'Description can\'t be empty'
        : 'Invalid description';
    return showErrorText ? errorText : null;
  }
}
