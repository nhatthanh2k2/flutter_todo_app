import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:realm/realm.dart';
import 'package:todo_app/entities/category_realm_entity.dart';

class CreateOrEditCategory extends StatefulWidget {
  final String? categoryId;
  const CreateOrEditCategory({super.key, this.categoryId});

  @override
  State<CreateOrEditCategory> createState() => _CreateOrEditCategoryState();
}

class _CreateOrEditCategoryState extends State<CreateOrEditCategory> {
  final _nameCategoryTextController = TextEditingController();
  //final List<Color> _colorDataSource = [];
  Color _colorBackgroundSelected = const Color(0xFFC9CC41);
  Color _colorIconAndTextSelected = const Color(0xFF21A300);
  IconData? _iconSelected;
  bool get isEdit {
    return widget.categoryId != null;
  }

  @override
  void initState() {
    super.initState();
    final storagePath = Configuration.defaultRealmPath;
    debugPrint('Realm path: $storagePath');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isEdit) {
        _findCategory(widget.categoryId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title:
            Text(
              isEdit
                  ? "edit_category_page_title"
                  : "create_category_page_title",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).tr(),
      ),
      body: _buildBodyPageScreen(),
    );
  }

  Widget _buildBodyPageScreen() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoryNameField(),
                _buildCategoryChooseIconField(),
                _buildCategoryChooseIconAndTextColorField(),
                _buildCategoryChooseBackgroundColorField(),
                _buildCategoryPreview(),
              ],
            ),
          ),
          _buildCancelOrCreateCategoryButton(),
        ],
      ),
    );
  }

  Widget _buildCategoryNameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleField("create_category_form_category_name_label".tr()),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _nameCategoryTextController,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                hintText: "create_category_form_category_name_placeholder".tr(),
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFAFAFAF),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(width: 1, color: Color(0xFF979797)),
                ),
              ),
              onChanged: (String? value) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChooseIconField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleField("create_category_form_category_icon_label".tr()),
          GestureDetector(
            onTap: _chooseIcon,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(0xFFFFFFFF).withValues(alpha: 0.21),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child:
                    _iconSelected != null
                        ? Icon(_iconSelected, color: Colors.white, size: 26)
                        : Text(
                          "create_category_form_category_icon_placeholder",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ).tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChooseIconAndTextColorField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleField(
            "create_category_form_category_icon_and_text_color_label".tr(),
          ),
          GestureDetector(
            onTap: _onChooseCategoryIconAndTextColor,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36 / 2),
                color: _colorIconAndTextSelected ?? Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChooseBackgroundColorField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleField(
            "create_category_form_category_background_color_label".tr(),
          ),
          GestureDetector(
            onTap: _onChooseCategoryBackgroundColor,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36 / 2),
                color: _colorBackgroundSelected ?? Colors.white,
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 10),
          //   width: double.infinity,
          //   height: 36,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       final color = _colorDataSource.elementAt(index);
          //       final isSelected = _colorSelected == color;
          //       return GestureDetector(
          //         onTap: () {
          //           print("Color in index $index");
          //           setState(() {
          //             _colorSelected = color;
          //           });
          //         },
          //         child: Container(
          //           margin: const EdgeInsets.only(right: 12),
          //           width: 36,
          //           height: 36,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(36 / 2),
          //             color: color,
          //           ),
          //           child:
          //               isSelected
          //                   ? Icon(Icons.check, color: Colors.white, size: 20)
          //                   : null,
          //         ),
          //       );
          //     },
          //     itemCount: _colorDataSource.length,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildCancelOrCreateCategoryButton() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
      ).copyWith(top: 20, bottom: 24),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child:
                Text(
                  "common_cancel",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato",
                    color: Colors.white.withValues(alpha: 0.44),
                  ),
                ).tr(),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              if (isEdit) {
                _editCategory();
              } else {
                _onHandleCreateCategory();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFF8875FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child:
                Text(
                  isEdit
                      ? "edit_category_edit_button"
                      : "create_category_create_button",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato",
                    color: Colors.white,
                  ),
                ).tr(),
          ),
        ],
      ),
    );
  }

  void _onHandleCreateCategory() async {
    try {
      final categoryName = _nameCategoryTextController.text;
      if (categoryName.isEmpty) {
        _showAlert("Validation", "Category name is required!");
        return;
      }
      if (_iconSelected == null) {
        _showAlert("Validation", "Category icon is required!");
        return;
      }
      // mo realm de cbi luu du lieu
      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);

      var category = CategoryRealmEntity(
        ObjectId(),
        categoryName,
        iconCodePoint: _iconSelected?.codePoint,
        backgroundColorHex: colorToHex(_colorBackgroundSelected),
        iconColorHex: colorToHex(_colorIconAndTextSelected),
      );
      await realm.writeAsync(() {
        realm.add(category);
      });
      _nameCategoryTextController.text = "";
      _colorBackgroundSelected = const Color(0xFFC9CC41);
      _colorIconAndTextSelected = const Color(0xFF21A300);
      _iconSelected = null;
      setState(() {});
      await _showAlert("Successfully", "Create category success!");
      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      //print(e);
      _showAlert("Failure", "Create category failure!");
    }
  }

  Future<void> _showAlert(String title, String message) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _findCategory(String id) {
    final config = Configuration.local([CategoryRealmEntity.schema]);
    final realm = Realm(config);

    final category = realm.find<CategoryRealmEntity>(
      ObjectId.fromHexString(id),
    );

    if (category == null) {
      return;
    }

    _nameCategoryTextController.text = category.name;
    if (category.iconCodePoint != null) {
      _iconSelected = IconData(
        category.iconCodePoint!,
        fontFamily: "MaterialIcons",
      );
    }
    if (category.backgroundColorHex != null) {
      // print("bg: ${category.backgroundColorHex}");
      _colorBackgroundSelected = category.backgroundColorHex!.toColor()!;
    }
    if (category.iconColorHex != null) {
      // print("icon: ${category.iconColorHex}");
      _colorIconAndTextSelected = category.iconColorHex!.toColor()!;
    }
    setState(() {});
  }

  Future<void> _editCategory() async {
    try {
      final categoryName = _nameCategoryTextController.text;
      if (categoryName.isEmpty) {
        _showAlert("Validation", "Category name is required!");
        return;
      }
      if (_iconSelected == null) {
        _showAlert("Validation", "Category icon is required!");
        return;
      }
      // mo realm de cbi luu du lieu
      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);

      final category = realm.find<CategoryRealmEntity>(
        ObjectId.fromHexString(widget.categoryId!),
      );
      if (category == null) {
        return;
      }

      await realm.writeAsync(() {
        category.name = categoryName;
        category.iconCodePoint = _iconSelected?.codePoint;
        category.iconColorHex = colorToHex(_colorIconAndTextSelected);
        category.backgroundColorHex = colorToHex(_colorBackgroundSelected);
        realm.add(category);
      });
      _nameCategoryTextController.text = "";
      _colorBackgroundSelected = const Color(0xFFC9CC41);
      _colorIconAndTextSelected = const Color(0xFF21A300);
      _iconSelected = null;
      setState(() {});
      await _showAlert("Successfully", "Edit category success!");
      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      //print(e);
      _showAlert("Failure", "Edit category failure!");
    }
  }

  void _chooseIcon() async {
    IconPickerIcon? icon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconPackModes: [IconPack.material],
        backgroundColor: Colors.white, // <-- set màu nền sáng dễ nhìn icon
        searchIcon: Icon(Icons.search, color: Colors.black), // màu search icon
      ),
    );

    if (icon != null) {
      setState(() {
        _iconSelected = icon.data;
      });
    }
  }

  void _onChooseCategoryIconAndTextColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: _colorIconAndTextSelected,
              onColorChanged: (Color newColor) {
                setState(() {
                  _colorIconAndTextSelected = newColor;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _onChooseCategoryBackgroundColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: _colorBackgroundSelected,
              onColorChanged: (Color newColor) {
                setState(() {
                  _colorBackgroundSelected = newColor;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryPreview() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleField("create_category_form_category_preview".tr()),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _colorBackgroundSelected,
                ),
                child: Icon(
                  _iconSelected,
                  color: _colorIconAndTextSelected,
                  size: 30,
                ),
              ),
              Text(
                _nameCategoryTextController.text,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField(String titleLabel) {
    return Text(
      titleLabel,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white.withValues(alpha: 0.87),
      ),
    );
  }
}
