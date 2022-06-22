import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';
import '../../../../common_widgets/clear_text_field.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_dropdown_button.dart';
import '../../../../common_widgets/custom_image_input.dart';
import '../../../../common_widgets/custom_text.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/strings.dart';

class AddListingScreen extends StatelessWidget {
  AddListingScreen({Key? key}) : super(key: key);

  void _submitForm() {}

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
              onPressed: () => _submitForm()),
        ],
      ),
      body: _BuidContents(),
    );
  }
}

class _BuidContents extends StatefulWidget {
  @override
  State<_BuidContents> createState() => _BuidContentsState();
}

class _BuidContentsState extends State<_BuidContents> {
  final _formKey = GlobalKey<FormState>();

  final _listingTitleController = TextEditingController();

  final _listingdescriptionController = TextEditingController();

  final _listingpriceController = TextEditingController();

  String get listingTitle => _listingTitleController.text;

  String get listingdescription => _listingdescriptionController.text;

  String get listingprice => _listingpriceController.text;

  final String _defaultValue = 'Choose Category';
  String _selectedCategory = kEmptyString;

  bool _negotiable = false;

  // Image _imageTaken;
  final int _maxImageCount = 100;

  final int _imageTaken = 0;

  void _chooseCategory() {}

  void _takeImage() {}

  _selectCategory(String value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(_selectedCategory);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: CustomBody(
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Divider(height: 0.5),
            CustomImageInput(
              onTap: () => _takeImage(),
              height: height * imageInputSize,
              verticalPadding: height * 0.015,
            ),
            const Divider(
              height: 0.5,
            ),
            SizedBox(height: height * 0.03),
            ClearTextField(
              controller: _listingTitleController,
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
                  _selectedCategory == '' ? _defaultValue : _selectedCategory,
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
                  controller: _listingpriceController,
                  label: kPriceLabel,
                  width: width * 0.6,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _negotiable,
                      shape: const CircleBorder(),
                      onChanged: (bool? value) => setState(() {
                        _negotiable = value!;
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
              controller: _listingdescriptionController,
              label: kListingDescriptionLabel,
            ),
          ]),
        ),
      ),
    );
  }
}
