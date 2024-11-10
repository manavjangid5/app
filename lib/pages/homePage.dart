import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../objects/ladle.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final formKey= GlobalKey<FormState>();

  final TextEditingController optionController = TextEditingController();
  final TextEditingController selectedOptionController = TextEditingController();

  String? selectedLadleId;
  String? optionSelected="Ladle Id";
  SampleItem? selectedItem;


  List<Ladle> ladles = [
    Ladle(ladleId: 1, ladleLife: 1200, ladleMinutes: 300, reliningStatus: "Pending"),
    Ladle(ladleId: 2, ladleLife: 1500, ladleMinutes: 400, reliningStatus: "Completed"),
    Ladle(ladleId: 3, ladleLife: 1100, ladleMinutes: 200, reliningStatus: "In Progress"),
    Ladle(ladleId: 4, ladleLife: 1300, ladleMinutes: 350, reliningStatus: "Pending"),
    Ladle(ladleId: 5, ladleLife: 1600, ladleMinutes: 500, reliningStatus: "Completed"),
    Ladle(ladleId: 6, ladleLife: 900, ladleMinutes: 150, reliningStatus: "In Progress"),
    Ladle(ladleId: 7, ladleLife: 1700, ladleMinutes: 450, reliningStatus: "Pending"),
    Ladle(ladleId: 8, ladleLife: 1250, ladleMinutes: 300, reliningStatus: "Completed"),
    Ladle(ladleId: 9, ladleLife: 1400, ladleMinutes: 380, reliningStatus: "In Progress"),
    Ladle(ladleId: 10, ladleLife: 1000, ladleMinutes: 275, reliningStatus: "Pending"),
  ];

  Set<String> ladlesDropdown={};
  Set<String> reliningStatusDropdown={};
  Set<String> optionsDropdown={"Ladle Id", "Relining Status"};
  List<Ladle> _foundLadles=[];
  
  @override
  void initState() {
    // TODO: implement initState
    _foundLadles=ladles;
    for(Ladle obj in ladles)
    {
      ladlesDropdown.add(obj.ladleId.toString());
      reliningStatusDropdown.add(obj.reliningStatus.toString());
    }
    super.initState();
  }
  void _searchAction(String enteredString)
  {
    List<Ladle>? tempLadles=[];
    if(enteredString.isNotEmpty){
      tempLadles=ladles.where((ladle) => ladle.ladleId.toString().toLowerCase().contains(enteredString.toLowerCase())
      || ladle.reliningStatus.toLowerCase().contains(enteredString.toLowerCase())).toList();
    }
    else{
      tempLadles=ladles;
    }
    setState(() {
      _foundLadles=tempLadles!;
    });
  }
  void _handleSelectedAction(BuildContext context, int ladleId)
  {
    if(selectedItem == SampleItem.itemOne) {
      _viewDetailAction(context, ladleId);
    }else if(selectedItem == SampleItem.itemTwo) {
      _updateAction(context, ladleId);
    } else if(selectedItem == SampleItem.itemThree) {
      _deleteAction(ladleId);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _viewDetailAction(BuildContext context, int ladleId) {
    // Create a variable to hold any changes made
    // Ladle editedLadle = Ladle(ladleId: ladleId, ladleLife: 1200, ladleMinutes: 300, reliningStatus: "Pending");
    Ladle editedLadle = Ladle(ladleId: 0, ladleLife: 0, ladleMinutes: 0, reliningStatus: 'Unknown');

    for(Ladle ladleObj in ladles)
    {
      if(ladleObj.ladleId == ladleId)
      {
        editedLadle=ladleObj;
        break;
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.red[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ladle ID: $ladleId',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LabelText(label: "Ladle Life:", value: "${editedLadle.ladleLife} hours"),
                const SizedBox(height: 8),
                LabelText(label: "Ladle Minutes:", value: "${editedLadle.ladleMinutes} minutes"),
                const SizedBox(height: 8),
                LabelText(label: "Relining Status:", value: editedLadle.reliningStatus),
              ],
            ),
          ),
        );
      },
    );
  }

// Example of the _saveChanges function
  void _saveChanges(Ladle ladle) {
    print('Changes saved for Ladle ID: ${ladle.ladleId}');
  }

  void _updateAction(BuildContext context, int ladleId) {
    // Create a variable to hold any changes made
    // Ladle editedLadle = Ladle(ladleId: ladleId, ladleLife: 1200, ladleMinutes: 300, reliningStatus: "Pending");
    Ladle editedLadle = Ladle(ladleId: 0, ladleLife: 0, ladleMinutes: 0, reliningStatus: 'Unknown');

    for(Ladle ladleObj in ladles)
    {
      if(ladleObj.ladleId == ladleId)
      {
        editedLadle=ladleObj;
        break;
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: formKey,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ladle ID: $ladleId',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LabelText(label: "Ladle Life:", value: "${editedLadle.ladleLife} hours"),
                  const SizedBox(height: 8),
                  LabelText(label: "Ladle Minutes:", value: "${editedLadle.ladleMinutes} minutes"),
                  const SizedBox(height: 8),
                  LabelText(label: "Relining Status:", value: editedLadle.reliningStatus),

                  const SizedBox(height: 12),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _saveChanges(editedLadle);
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),

            ),
          ),
        );
      },
    );
  }

  void _deleteAction(int ladleId)
  {
    setState(() {
      ladles.removeWhere((item) => item.ladleId == ladleId);
      _foundLadles = List.from(ladles);
    });
    _showMessage("Deleted Ladle ID: $ladleId");
  }


  Future<void> _handleRefresh() async{
    setState(() {
      _foundLadles=ladles;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Container(
        color: Colors.red[100],
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                // Search Bar for filtering ladles
                SizedBox(
                  width: double.infinity,
                  // child: SearchAnchor(
                  //   builder: (BuildContext context, SearchController controller) {
                  //     return SearchBar(
                  //       controller: controller,
                  //       onChanged: (value) => _searchAction(value),
                  //       padding: const WidgetStatePropertyAll<EdgeInsets>(
                  //         EdgeInsets.symmetric(horizontal: 16.0),
                  //       ),
                  //       leading: const Icon(Icons.search),
                  //     );
                  //   },
                  //   suggestionsBuilder: (BuildContext context, SearchController controller) {
                  //     return List<ListTile>.generate(5, (int index) {
                  //       final String item = 'item $index';
                  //       return ListTile(
                  //         title: Text(item),
                  //         onTap: () {
                  //           setState(() {
                  //             controller.closeView(item);
                  //           });
                  //         },
                  //       );
                  //     });
                  //   },
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DropdownMenu<String>(
                        controller: optionController,
                        requestFocusOnTap: true,
                        label: const Text('Select Option For search'),
                        onSelected: (value) {
                          setState(() {
                            optionSelected = value;
                            selectedOptionController.clear(); // Clear the second dropdown selection
                          });
                        },
                        dropdownMenuEntries: optionsDropdown.toList().map<DropdownMenuEntry<String>>((String option) {
                          return DropdownMenuEntry<String>(
                            value: option,
                            label: option,
                            style: MenuItemButton.styleFrom(
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(width: 24),
                      DropdownMenu<String>(
                        controller: selectedOptionController,
                        requestFocusOnTap: true,
                        label: Text(optionSelected ?? 'Select Option'), // Use a default label if optionSelected is null
                        onSelected: (value) => _searchAction(value!),
                        dropdownMenuEntries: (optionSelected == "Ladle Id" ? ladlesDropdown : reliningStatusDropdown).toList().map<DropdownMenuEntry<String>>((String val) {
                          return DropdownMenuEntry<String>(
                            value: val,
                            label: val,
                            style: MenuItemButton.styleFrom(
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                ),
                // Display list of ladles in a scrollable ListView
                Expanded(
                  child: ListView.builder(
                    itemCount: _foundLadles.length,
                    itemBuilder: (context, index) {
                      final detail = _foundLadles[index];
                      return Card(
                        key: ValueKey("ladle_id_${detail.ladleId}"),
                        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                        color: Colors.red[200],
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  LabelText(
                                    label: "Ladle ID:",
                                    value: detail.ladleId.toString(),
                                  ),
                                  // PopupMenuButton added here
                                  PopupMenuButton<SampleItem>(
                                    initialValue: selectedItem,
                                    onSelected: (SampleItem item) {
                                      setState(() {
                                        selectedItem = item;
                                      });
                                      _handleSelectedAction(context, detail.ladleId);
                                    },
                                    itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<SampleItem>>[
                                      const PopupMenuItem<SampleItem>(
                                        value: SampleItem.itemOne,
                                        child: Text('View Details'),
                                      ),
                                      const PopupMenuItem<SampleItem>(
                                        value: SampleItem.itemTwo,
                                        child: Text('Update Ladle Info.'),
                                      ),
                                      const PopupMenuItem<SampleItem>(
                                        value: SampleItem.itemThree,
                                        child: Text('Delete Entry'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              LabelText(label: "Ladle Life:", value: "${detail.ladleLife} hours"),
                              const SizedBox(height: 8),
                              LabelText(label: "Ladle Minutes:", value: "${detail.ladleMinutes} minutes"),
                              const SizedBox(height: 8),
                              LabelText(label: "Relining Status:", value: detail.reliningStatus),
                            ],
                          ),
          
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        // onTap: (){},
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String label;
  final String value;

  const LabelText({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
