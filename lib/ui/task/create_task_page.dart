import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/category_model.dart';
import 'package:todo_app/ui/category/category_list_page.dart';
import 'package:todo_app/ui/task_priority/task_priority_list_page.dart';
import 'package:todo_app/utils/color_extension.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _nameTaskTextController = TextEditingController();
  final _descTaskTextController = TextEditingController();
  CategoryModel? _categorySelected;
  DateTime? _taskDateTimeSelected;
  int? _taskPrioritySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF363636),
      child: SafeArea(
        child: Container(padding: EdgeInsets.all(25), child: _buildBodyPage()),
      ),
    );
  }

  Widget _buildBodyPage() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTaskNameField(),
          _buildTaskDescField(),
          if (_taskDateTimeSelected != null) _buildTaskDateTime(),
          if (_categorySelected != null) _buildTaskCategory(),
          if (_taskPrioritySelected != null) _buildTaskPriority(),
          _buildTaskActionField(),
        ],
      ),
    );
  }

  Widget _buildTaskNameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "create_task_name_label",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white.withValues(alpha: 0.87),
            fontWeight: FontWeight.bold,
          ),
        ).tr(),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: _nameTaskTextController,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            decoration: InputDecoration(
              hintText: "create_task_name_placeholder".tr(),
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
    );
  }

  Widget _buildTaskDescField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "create_task_desc_label",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.87),
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _descTaskTextController,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                hintText: "create_task_desc_placeholder".tr(),
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

  Widget _buildTaskCategory() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Task category:",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.87),
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: _buildGridCategoryItem(_categorySelected!),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskDateTime() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Task time:",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.87),
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFF8687E7)),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                DateFormat("dd-MM-yyyy HH:mm").format(_taskDateTimeSelected!),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.87),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskPriority() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Task priority:",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.87),
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFF8687E7)),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/flag.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    _taskPrioritySelected!.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withValues(alpha: 0.87),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridCategoryItem(CategoryModel category) {
    return Column(
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
    );
  }

  Widget _buildTaskActionField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: _selectTaskTime,
                  icon: Image.asset(
                    "assets/images/timer.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                ),
                IconButton(
                  onPressed: _showDialogChooseCategory,
                  icon: Image.asset(
                    "assets/images/tag.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                ),
                IconButton(
                  onPressed: _showDialogChoosePriority,
                  icon: Image.asset(
                    "assets/images/flag.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: Image.asset(
              "assets/images/send.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  void _showDialogChoosePriority() async {
    final result = await showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      pageBuilder: (_, __, ___) {
        return TaskPriorityListPage();
      },
    );

    //print(result);

    if (result != null && result is Map<String, dynamic>) {
      final priority = result["priority"];
      setState(() {
        _taskPrioritySelected = priority;
      });
    } else {}
  }

  void _showDialogChooseCategory() async {
    final result = await showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      pageBuilder: (_, __, ___) {
        return CategoryListPage();
      },
    );

    //print(result);

    if (result != null && result is Map<String, dynamic>) {
      final categoryId = result["categoryId"];
      if (categoryId == null) {
        return;
      }
      final categoryName = result["categoryName"];
      final iconCodePoint = result["iconCodePoint"];
      final iconColorHex = result["iconColorHex"];
      final backgroundColorHex = result["backgroundColorHex"];

      final categoryModel = CategoryModel(
        id: categoryId,
        name: categoryName,
        iconCodePoint: iconCodePoint,
        iconColorHex: iconColorHex,
        backgroundColorHex: backgroundColorHex,
      );

      setState(() {
        _categorySelected = categoryModel;
      });
    } else {}
  }

  void _selectTaskTime() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF8687E7),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date == null) {
      return;
    }
    if (!context.mounted) {
      return;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF8687E7),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time == null) {
      return;
    }

    final dateTimeSelected = date.copyWith(
      hour: time.hour,
      minute: time.minute,
      second: 0,
    );

    setState(() {
      _taskDateTimeSelected = dateTimeSelected;
    });
  }
}
