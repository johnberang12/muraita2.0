import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/common_widgets/alert_dialogs.dart';
import '../../../../common_widgets/clear_text_field.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_dropdown_button.dart';
import '../../../../common_widgets/custom_image_input.dart';
import '../../../../common_widgets/custom_text.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/strings.dart';
import '../../data/products_repository.dart';
import '../../domain/product.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _productTitleController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productPriceController = TextEditingController();

  String get productTitle => _productTitleController.text;
  String get productDescription => _productDescriptionController.text;
  String get productPrice => _productPriceController.text;

  final String _selectedCategory = kEmptyString;

  final bool _negotiable = false;

  final auth = FirebaseAuth.instance;
  final database = ProductsRepository();

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submitForm(context) async {
    if (_validateAndSaveForm()) {
      try {
        final id = documentIdFromCurrentDate();
        final listing = Product(
          id: id,
          title: productTitle,
          category: _selectedCategory,
          price: int.tryParse(productPrice)!,
          description: productDescription,
          negotiable: _negotiable,
          ownerId: auth.currentUser!.uid,
          avgRating: 0,
          numRatings: 0,
          success: true,
        );

        await database.setProduct(listing);
        Navigator.of(context).pop();
      } catch (e) {
        showAlertDialog(
            context: context, title: kOperationFailed, content: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              onPressed: () => _submitForm(context)),
        ],
      ),
      body: _BuidContents(
        formKey: _formKey,
        titleController: _productTitleController,
        discriptionController: _productDescriptionController,
        priceController: _productPriceController,
        category: _selectedCategory,
        negotiable: _negotiable,
      ),
    );
  }
}

class _BuidContents extends StatefulWidget {
  _BuidContents({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.discriptionController,
    required this.priceController,
    this.category = kEmptyString,
    this.negotiable = false,
  });
  final GlobalKey formKey;
  final TextEditingController titleController;
  final TextEditingController discriptionController;
  final TextEditingController priceController;
  String category;
  bool negotiable;

  @override
  State<_BuidContents> createState() => _BuidContentsState();
}

class _BuidContentsState extends State<_BuidContents> {
  final String _defaultValue = 'Choose Category';

  _selectCategory(String value) {
    setState(() {
      widget.category = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return CustomBody(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Form(
          key: widget.formKey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Divider(height: 0.5),

              ///comment this image for the sake of setting up save data function

              const CustomImageInput(),
              const Divider(
                height: 0.5,
              ),
              SizedBox(height: height * 0.03),

              ///title field
              ClearTextField(
                controller: widget.titleController,
                label: kListingTitleLabel,
              ),
              const Divider(
                height: 0.5,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomDropdownButton(
                defaultHint:
                    widget.category == '' ? _defaultValue : widget.category,
                listItems: kListingCategories,
                verticalPadding: height * 0.03,
                onChanged: (value) => _selectCategory(value!),
              ),
              const Divider(
                height: 0.5,
              ),
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  ClearTextField(
                    controller: widget.priceController,
                    label: kPriceLabel,
                    width: width * 0.6,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        fillColor: primaryMaterailColor,
                        value: widget.negotiable,
                        shape: const CircleBorder(),
                        onChanged: (bool? value) => setState(() {
                          widget.negotiable = value!;
                        }),
                      ),
                      const CustomText(
                        'Negotiable',
                        color: kBlack40,
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
                controller: widget.discriptionController,
                label: kListingDescriptionLabel,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
