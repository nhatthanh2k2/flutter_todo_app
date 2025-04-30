import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _nameTaskTextController = TextEditingController();
  final _descTaskTextController = TextEditingController();
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

  Widget _buildTaskActionField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
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
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/timer.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/tag.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
}
