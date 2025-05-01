import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TaskPriorityListPage extends StatefulWidget {
  const TaskPriorityListPage({super.key});

  @override
  State<TaskPriorityListPage> createState() => _TaskPriorityListPageState();
}

class _TaskPriorityListPageState extends State<TaskPriorityListPage> {
  List<int> priorityListDataSource = [];
  int? _selectedPriority;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        priorityListDataSource = List.generate(10, (index) => index + 1);
      });
    });
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
            _buildChoosePriorityTitle(),
            _buildGridPriorityList(),
            _buildCreatePriorityButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChoosePriorityTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Text(
          "Task Priority",
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

  Widget _buildGridPriorityList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final cate = priorityListDataSource.elementAt(index);
        return _buildGridPriorityItem(cate);
      },
      itemCount: priorityListDataSource.length,
    );
  }

  Widget _buildGridPriorityItem(int priority) {
    final isSelected = priority == _selectedPriority;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPriority = priority;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? Color(0xFF8687E7) : Color(0xFF272727),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/flag.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              Text(
                priority.toString(),
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreatePriorityButton() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
      ).copyWith(top: 107, bottom: 24),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
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
              Navigator.pop(context, {"priority": _selectedPriority});
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFF8875FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child:
                Text(
                  "Save",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ).tr(),
          ),
        ],
      ),
    );
  }
}
