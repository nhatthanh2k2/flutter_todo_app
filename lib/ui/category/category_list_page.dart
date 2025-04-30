import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:todo_app/entities/category_realm_entity.dart';
import 'package:todo_app/models/category_model.dart';
import 'package:todo_app/ui/category/create_or_edit_category.dart';
import 'package:todo_app/utils/color_extension.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<CategoryModel> categoryListDataSource = [];
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCategoryList();
    });

    // WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
    //   _getCategoryList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBodyPage(),
    );
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFF363636),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildChooseCategoryTitle(),
            _buildGridCategoryList(),
            _buildCreateCategoryButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChooseCategoryTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Text(
          "create_list_page_title",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white.withValues(alpha: 0.87),
          ),
        ).tr(),
        Divider(color: Color(0xFF979797)),
      ],
    );
  }

  Widget _buildGridCategoryList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final isLastItem = index == categoryListDataSource.length;
        if (isLastItem) {
          return _buildGridCategoryItemCreateNew();
        }
        final cate = categoryListDataSource.elementAt(index);
        return _buildGridCategoryItem(cate);
      },
      itemCount: categoryListDataSource.length + 1,
    );
  }

  Widget _buildGridCategoryItem(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _onHandleClickCategoryItem(category);
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  category.backgroundColorHex != null
                      ? category.backgroundColorHex?.toColor()
                      : Colors.white,
              border: Border.all(
                color: _isEditMode ? Colors.orange : Colors.transparent,
                width: _isEditMode ? 2 : 0,
              ),
            ),
            child:
                category.iconCodePoint != null
                    ? Icon(
                      IconData(
                        category.iconCodePoint!,
                        fontFamily: "MaterialIcons",
                      ),
                      color:
                          category.iconColorHex != null
                              ? category.iconColorHex?.toColor()
                              : Colors.white,
                      size: 30,
                    )
                    : null,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              category.name,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridCategoryItemCreateNew() {
    return GestureDetector(
      onTap: _goToCreateCategoryPage,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFF80FFD1),
            ),
            child: Icon(Icons.add, color: Color(0xFF00A369), size: 30),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              "Create new",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateCategoryButton() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
      ).copyWith(top: 107, bottom: 24),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child:
                Text(
                  "common_cancel",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.44),
                  ),
                ).tr(),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isEditMode = !_isEditMode;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFF8875FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child:
                Text(
                  _isEditMode
                      ? "Cancel edit"
                      : "create_list_edit_category_button",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ).tr(),
          ),
        ],
      ),
    );
  }

  Future<void> _getCategoryList() async {
    final config = Configuration.local([CategoryRealmEntity.schema]);
    final realm = Realm(config);
    // RealmResult CategoryRealmEntity => List<CategoryRealmEntity>
    final categories = realm.all<CategoryRealmEntity>();
    List<CategoryModel> categoryModels =
        categories.map((category) {
          return CategoryModel(
            id: category.id.hexString,
            name: category.name,
            iconCodePoint: category.iconCodePoint,
            backgroundColorHex: category.backgroundColorHex,
            iconColorHex: category.iconColorHex,
          );
        }).toList();
    setState(() {
      categoryListDataSource = categoryModels;
    });
  }

  void _goToCreateCategoryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateOrEditCategory()),
    );
  }

  void _onHandleClickCategoryItem(CategoryModel category) {
    if (_isEditMode) {
      // TODO: Di den man hinh edit
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateOrEditCategory(categoryId: category.id),
        ),
      );
    } else {
      Navigator.pop(context, {
        "categoryId": category.id,
        "categoryName": category.name,
        "iconCodePoint": category.iconCodePoint, // luu icon trong fluttet.icons
        "iconColorHex": category.iconColorHex, // color hex string
        "backgroundColorHex": category.backgroundColorHex,
      });
    }
  }
}
