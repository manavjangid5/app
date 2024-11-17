import "package:flutter/material.dart";
import "package:project1/components/appBar.dart";

class CurrentStatusPage extends StatefulWidget {
  final String username;

  const CurrentStatusPage({Key? key, required this.username}) : super(key: key);

  @override
  State<CurrentStatusPage> createState() => _CurrentStatusPageState();
}

class _CurrentStatusPageState extends State<CurrentStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: CustomScrollView(
              primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 1,
                    children: <Widget>[
                      Card(
                        // Styling the card
                        color: Colors.red[100],
                        elevation: 4,
                        shadowColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,

                        // Card content
                        child: Padding(
                          padding: const EdgeInsets.all(12), // Padding inside the card
                          child: IntrinsicHeight( // Ensures the card height matches its content
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image on the left
                                const Image(
                                  image: AssetImage('lib/images/AMNS_Logo_Mid.jpg'),
                                  width: 100,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 12), // Space between image and text

                                Container(
                                  width: 1,
                                  color: Colors.grey,
                                  margin: const EdgeInsets.symmetric(vertical: double.minPositive),
                                ),
                                // Text content on the right
                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min, // Adjust to content height
                                    children: [
                                      // Title
                                      const Center(
                                        child: Text(
                                          "Castor 1",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        height: 1,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.symmetric(horizontal: double.minPositive),
                                      ),
                                      const SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("string 1"),
                                            SizedBox(height: 8),
                                            Text("string 12"),
                                            SizedBox(height: 8),
                                            Text("string 21"),
                                            SizedBox(height: 8),
                                            Text("string 122"),
                                            SizedBox(height: 8),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        // Define the shape of the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),

                        // Define how the card's content should be clipped
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        // Define the child widget of the card
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Add padding around the row widget
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Add an image widget to display an image
                                  const Image(
                                    image: AssetImage('lib/images/AMNS_Logo_Mid.jpg'),
                                    width: 70,
                                    height: 60,
                                  ),
                                  // Add some spacing between the image and the text
                                  Container(width: 20),
                                  // Add an expanded widget to take up the remaining horizontal space
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Add some spacing between the top of the card and the title
                                        Container(height: 5),
                                        // Add a title widget
                                        const Text(
                                          "Cards Title 1",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        // Add some spacing between the title and the subtitle
                                        Container(height: 5),
                                        // Add a subtitle widget
                                        const Text(
                                          "Cards Title 1",
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        // Add some spacing between the subtitle and the text
                                        Container(height: 10),
                                        // Add a text widget to display some text
                                        Text(
                                          "MyStringsSample.card_text",
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
    );
  }
}
