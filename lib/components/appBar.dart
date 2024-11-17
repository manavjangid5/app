import "package:flutter/material.dart";

class CustomAppBar extends StatefulWidget {
  final String username;

  const CustomAppBar({Key? key, required this.username}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return(
        AppBar(
          title: const Text("LADLE INFORMATION"),
          backgroundColor: Colors.red,
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.red.shade100), // Set background color
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout, color: Colors.black), // Adjust icon color to be distinct
                  SizedBox(width: 6), // Spacing between icon and text
                  Text("Logout", style: TextStyle(color: Colors.black)), // Adjust text color if needed
                ],
              ),
            ),
          ],
        )
    );
  }
}
