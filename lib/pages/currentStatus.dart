import "package:flutter/material.dart";
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CurrentStatusPage extends StatefulWidget {
  final String username;

  const CurrentStatusPage({Key? key, required this.username}) : super(key: key);

  @override
  State<CurrentStatusPage> createState() => _CurrentStatusPageState();
}

class _CurrentStatusPageState extends State<CurrentStatusPage> {

  final List<Map<String, dynamic>> containerData = [
    {
      "title": "Mobile App Design",
      "icon": Icons.phone_android,
      "itemList": ["Wireframes", "UI Design", "UX Review"]
    },
    {
      "title": "Pending",
      "icon": Icons.pending,
      "itemList": ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5", "Task 6"]
    },
    {
      "title": "Website Design",
      "icon": Icons.web,
      "itemList": ["HTML Setup", "CSS Styling", "JavaScript Logic"]
    },
    {
      "title": "Illustration",
      "icon": Icons.brush,
      "itemList": ["Sketch Ideas", "Digital Art", "Coloring"]
    },
    {
      "title": "Testing",
      "icon": Icons.bug_report,
      "itemList": ["Unit Tests", "Integration Tests", "Bug Fixing","Unit Tests", "Integration Tests", "Bug Fixing"]
    },
    {
      "title": "Illustration",
      "icon": Icons.brush,
      "itemList": ["Sketch Ideas", "Digital Art", "Coloring"]
    },
    {
      "title": "Illustration",
      "icon": Icons.brush,
      "itemList": ["Sketch Ideas", "Digital Art", "Coloring"]
    },
    {
      "title": "Illustration",
      "icon": Icons.brush,
      "itemList": ["Sketch Ideas", "Digital Art", "Coloring"]
    },
    {
      "title": "Pending",
      "icon": Icons.pending,
      "itemList": ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5", "Task 6"]
    },
    {
      "title": "Website Design",
      "icon": Icons.web,
      "itemList": ["HTML Setup", "CSS Styling", "JavaScript Logic"]
    },
    {
      "title": "Illustration",
      "icon": Icons.brush,
      "itemList": ["Sketch Ideas", "Digital Art", "Coloring"]
    },
    {
      "title": "Testing",
      "icon": Icons.bug_report,
      "itemList": ["Unit Tests", "Integration Tests", "Bug Fixing","Unit Tests", "Integration Tests", "Bug Fixing"]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasonryGridView.builder(
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
        ),
        mainAxisSpacing: 16, // Vertical spacing between items
        crossAxisSpacing: 16, // Horizontal spacing between items
        itemCount: containerData.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final data = containerData[index];
          return customContainer(
            context,
            data["itemList"] as List<String>,
            data["icon"] as IconData,
            data["title"] as String,
          );
        },
      ),

      // body: SingleChildScrollView(
      //   child: Center(
      //     child: Padding(
      //       padding: const EdgeInsets.all(6.0),
      //       child: Wrap(
      //         // delegate: DynamicFlowDelegate(
      //         //   spacing: 8,
      //         // ),
      //         spacing: 8.0,
      //         runSpacing: 10.0,
      //         children: containerData.map((data) {
      //           return SizedBox(
      //             width: MediaQuery.of(context).size.width * 0.45, // Limit width to 45% of the screen
      //             child: customContainer(
      //               context,
      //               data["itemList"] as List<String>,
      //               data["icon"] as IconData,
      //               data["title"] as String,
      //             ),
      //           );
      //         }).toList(),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

Widget customContainer(
    BuildContext context, List<String> itemList, IconData iconRequired, String titleRequired) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(
        colors: [Colors.red, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(2, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(iconRequired, size: 40),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                titleRequired,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...itemList.map((item) => Text(item)).toList(),
      ],
    ),
  );
}
// list, icon, title,