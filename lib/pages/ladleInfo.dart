import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/components/customNavigationBar.dart';
import '../objects/ladle.dart';
import 'package:project1/api.dart';
import '../components/appBar.dart';
import "../pages/currentStatus.dart";

enum SampleItem { itemOne, itemTwo, itemThree }

class LadleInfo extends StatefulWidget {
  final String username;

  const LadleInfo({Key? key, required this.username}) : super(key: key);

  @override
  State<LadleInfo> createState() => _LadleInfoState();
}

class _LadleInfoState extends State<LadleInfo> {

  final formKey= GlobalKey<FormState>();
  late bool isEditableRow;
  final TextEditingController optionController = TextEditingController();
  final TextEditingController selectedOptionController = TextEditingController();

  String? selectedLadleId;
  String? optionSelected="Select Option";
  SampleItem? selectedItem;


  List<Ladle> ladles = [
  Ladle(ladleNo: '1', plugType: "Mini Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '24', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Breakdown"),
  Ladle(ladleNo: '2', plugType: "Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '24', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Pending"),
  Ladle(ladleNo: '3', plugType: "Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '24', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Ver Pre-Heater"),
  Ladle(ladleNo: '5', plugType: "Mini Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '24', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Partial Relining"),
  Ladle(ladleNo: '8', plugType: "Mini Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '24', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Partial Relining"),
  Ladle(ladleNo: '6', plugType: "Mini Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '24', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Hoz. Pre-Heater"),
  Ladle(ladleNo: '7', plugType: "Mini Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '24', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Breakdown"),
  Ladle(ladleNo: '4', plugType: "Mini Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '24', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Full  Relining"),
  Ladle(ladleNo: '9', plugType: "Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '24', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Full  Relining"),
  Ladle(ladleNo: '11', plugType: "Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '23', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Breakdown"),
  Ladle(ladleNo: '10', plugType: "Jumbo", standardLife: '170', cumulativeHolding: '2345432', currentLife: '121', sb: '43', ladleIn: '24', sgp: '2', ppLife: '1', sgType: "LG-22", ppCumHolding: '234', ladleStatus: "Pending"),];


  Set<String> ladlesDropdown={};
  Set<String> reliningStatusDropdown={};
  Set<String> optionsDropdown={"Ladle Id", "Relining Status"};
  List<Ladle> _foundLadles=[];
  
  @override
  void initState() {
    // TODO: implement initState
    _foundLadles=ladles;
    isEditableRow = false;
    for(Ladle obj in ladles)
    {
      ladlesDropdown.add(obj.ladleNo.toString());
      reliningStatusDropdown.add(obj.ladleStatus.toString());
    }
    super.initState();
  }

  Widget buildEditableRow(String label, String value, ValueChanged<String> onChanged) {
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
        Expanded(
          child: TextFormField(
            controller: TextEditingController(text: value),
            onChanged: onChanged,
            decoration: const InputDecoration(
              errorStyle: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  void _searchAction(String enteredString)
  {
    List<Ladle>? tempLadles=[];
    if(enteredString.isNotEmpty){
      tempLadles=ladles.where((ladle) => ladle.ladleNo.toString().toLowerCase().contains(enteredString.toLowerCase())
      || ladle.ladleStatus.toLowerCase().contains(enteredString.toLowerCase())).toList();
    }
    else{
      tempLadles=ladles;
    }
    setState(() {
      _foundLadles=tempLadles!;
    });
  }
  void _handleSelectedAction(BuildContext context, dynamic ladleId)
  {
    if(selectedItem == SampleItem.itemOne) {
      _viewDetailAction(context, ladleId);
    }else if(selectedItem == SampleItem.itemTwo) {
      _updateAction(context, ladleId);
    } else if(selectedItem == SampleItem.itemThree) {
      _deleteAction(ladleId);
    }
  }

  void _saveChanges(Ladle editedLadle) {
    print('Changes saved for Ladle ID: ${editedLadle.ladleNo}');
    setState(() {
      for(Ladle ladle in _foundLadles)
      {
        if(ladle.ladleNo==editedLadle.ladleNo) {
          ladle=editedLadle;
        }
      }
    });
    Api.addLadle(editedLadle.toMap());
    print(editedLadle);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _viewDetailAction(BuildContext context, dynamic ladleId) {
    // Create a variable to hold any changes made
    // Ladle editedLadle = Ladle(ladleId: ladleId, ladleLife: 1200, ladleMinutes: 300, reliningStatus: "Pending");
    Ladle editedLadle = Ladle(ladleNo: '0', currentLife: '0', cumulativeHolding: '0', ladleStatus: 'Unknown', standardLife: '0', plugType: '', sb: '0', ladleIn: '0', sgp: '0', ppLife: '234', sgType: '', ppCumHolding: '23');

    for(Ladle ladleObj in ladles)
    {
      if(ladleObj.ladleNo == ladleId)
      {
        editedLadle=ladleObj;
        break;
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
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
                LabelText(label: "Current Life:", value: "${editedLadle.currentLife} hours"),
                const SizedBox(height: 8),
                LabelText(label: "Cum. Holding:", value: "${editedLadle.cumulativeHolding} minutes"),
                const SizedBox(height: 8),
                LabelText(label: "Status :", value: editedLadle.ladleStatus),
                const SizedBox(height: 8),
                LabelText(label: "Standard Life :", value: editedLadle.standardLife.toString()),
                const SizedBox(height: 8),
                LabelText(label: "Plug Type :", value: editedLadle.plugType),
                const SizedBox(height: 8),
                LabelText(label: "SB :", value: editedLadle.sb.toString()),
                const SizedBox(height: 8),
                LabelText(label: "Ladle In :", value: editedLadle.ladleIn.toString()),
                const SizedBox(height: 8),
                LabelText(label: "SGP :", value: editedLadle.sgp.toString()),
                const SizedBox(height: 8),
                LabelText(label: "PP Life :", value: editedLadle.ppLife.toString()),
                const SizedBox(height: 8),
                LabelText(label: "SG Type :", value: editedLadle.sgType),
                const SizedBox(height: 8),
                LabelText(label: "PP Cum. Holding :", value: editedLadle.ppCumHolding.toString()),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

// Example of the _saveChanges function


  void _updateAction(BuildContext context, dynamic ladleNo) {

    Ladle editedLadle = Ladle(ladleNo: '0', currentLife: '0', cumulativeHolding: '0', ladleStatus: 'Unknown', standardLife: '0', plugType: '', sb: '0', ladleIn: '0', sgp: '0', ppLife: '234', sgType: '', ppCumHolding: '23');
    List<String> ladleStatusItems=['Breakdown', 'Full  Relining', 'Hoz. Pre-Heater', 'Partial Relining', 'Ver Pre-Heater', 'Pending'];

    for(Ladle ladleObj in ladles)
    {
      if(ladleObj.ladleNo == ladleNo)
      {
        editedLadle=ladleObj;
        break;
      }
    }

    String? valueForLadleStatus=editedLadle.ladleStatus;
    String? valueForPlugType=editedLadle.plugType;

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ladle No: $ladleNo',
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

                    buildEditableRow("Current Life: ", editedLadle.currentLife, (value) {
                      setState(() {
                        editedLadle = editedLadle.copyWith(currentLife: value);
                      });
                    }),
                    const SizedBox(height: 8),
                    buildEditableRow("Cum. Holding: ", editedLadle.cumulativeHolding, (value) {
                      setState(() {
                        editedLadle = editedLadle.copyWith(cumulativeHolding: value);
                      });
                    }),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          "Ladle Status: ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownMenu<String>(
                            initialSelection: valueForLadleStatus,
                            dropdownMenuEntries: ladleStatusItems.map((String item) {
                              return DropdownMenuEntry<String>(
                                value: item,
                                label: item,
                              );
                            }).toList(),
                            onSelected: (String? value) {
                              setState(() {
                                valueForLadleStatus = value;
                                editedLadle = editedLadle.copyWith(ladleStatus: value);
                              });
                            },
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            inputDecorationTheme: const InputDecorationTheme(
                              contentPadding: EdgeInsets.all(2),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    buildEditableRow("Standard Life: ", editedLadle.standardLife, (value) {
                      setState(() {
                        editedLadle = editedLadle.copyWith(standardLife: value);
                      });
                    }),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          "Plug Type: ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownMenu<String>(
                            initialSelection: valueForPlugType,
                            dropdownMenuEntries: ["Mini Jumbo","Jumbo"].map((String item) {
                              return DropdownMenuEntry<String>(
                                value: item,
                                label: item,
                              );
                            }).toList(),
                            onSelected: (String? value) {
                              setState(() {
                                valueForLadleStatus = value;
                                editedLadle = editedLadle.copyWith(plugType: value);
                              });
                            },
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            inputDecorationTheme: const InputDecorationTheme(
                              contentPadding: EdgeInsets.all(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    buildEditableRow("SB: ", editedLadle.sb, (value) {
                      setState(() {
                        editedLadle = editedLadle.copyWith(sb: value);
                      });
                    }),
                    const SizedBox(height: 8),
                    buildEditableRow("Ladle In: ", editedLadle.ladleIn, (value) {
                      setState(() {
                        editedLadle = editedLadle.copyWith(ladleIn: value);
                      });
                    }),
                    const SizedBox(height: 8),
                    buildEditableRow("SGP: ", editedLadle.sgp, (value) {
                      setState(() {
                        editedLadle = editedLadle.copyWith(sgp: value);
                      });
                    }),
                    const SizedBox(height: 8),
                    buildEditableRow("PP Life: ", editedLadle.ppLife, (value) {
                      setState(() {
                        editedLadle = editedLadle.copyWith(ppLife: value);
                      });
                    }),
                    const SizedBox(height: 8),
                    buildEditableRow("SG Type: ", editedLadle.sgType, (value) {
                      setState(() {
                        editedLadle = editedLadle.copyWith(sgType: value);
                      });
                    }),
                    const SizedBox(height: 8),
                    buildEditableRow("PP Cum. Holding: ", editedLadle.ppCumHolding, (value) {
                      setState(() {
                        editedLadle = editedLadle.copyWith(ppCumHolding: value);
                      });
                    }),
                    const SizedBox(height: 10),
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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteAction(dynamic ladleId)
  {
    setState(() {
      ladles.removeWhere((item) => item.ladleNo == ladleId);
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
      body: Container(
        color: Colors.white,
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                // Search Bar for filtering ladles
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        DropdownMenu<String>(
                          controller: optionController,
                          requestFocusOnTap: true,
                          label: const Text(
                            'Select Option For search',
                            style: TextStyle(fontSize: 12),
                          ),
                          onSelected: (value) {
                            setState(() {
                              optionSelected = value;
                              selectedOptionController.clear(); // Clear the second dropdown selection
                            });
                          },
                          dropdownMenuEntries: optionsDropdown
                              .toList()
                              .map<DropdownMenuEntry<String>>((String option) {
                            return DropdownMenuEntry<String>(
                              value: option,
                              label: option,
                              style: MenuItemButton.styleFrom(
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                        ),
                        if (optionSelected != null && optionSelected!.isNotEmpty)
                          DropdownMenu<String>(
                            controller: selectedOptionController,
                            requestFocusOnTap: true,
                            label: Text(optionSelected!),
                            onSelected: (value) => _searchAction(value!),
                            dropdownMenuEntries: (optionSelected == "Ladle Id"
                                ? ladlesDropdown
                                : reliningStatusDropdown)
                                .toList()
                                .map<DropdownMenuEntry<String>>((String val) {
                              return DropdownMenuEntry<String>(
                                value: val,
                                label: val,
                                style: MenuItemButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                  backgroundColor: Colors.white,
                                  textStyle: const TextStyle(fontSize: 12),
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _foundLadles.length,
                    itemBuilder: (context, index) {
                      final detail = _foundLadles[index];
                      return Card(
                        key: ValueKey("ladle_id_${detail.ladleNo}"),
                        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                        color: Colors.red[100],
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
                                    value: detail.ladleNo.toString(),
                                  ),
                                  // PopupMenuButton added here
                                  PopupMenuButton<SampleItem>(
                                    initialValue: selectedItem,
                                    onSelected: (SampleItem item) {
                                      setState(() {
                                        selectedItem = item;
                                      });
                                      _handleSelectedAction(context, detail.ladleNo);
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
                              LabelText(label: "Current Life:", value: "${detail.currentLife} hours"),
                              const SizedBox(height: 8),
                              LabelText(label: "Cumulative Holding(in MIN.):", value: detail.cumulativeHolding),
                              const SizedBox(height: 8),
                              LabelText(label: "Ladle Status:", value: detail.ladleStatus),
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
    );
  }
}

class LabelText extends StatelessWidget {
  final dynamic label;
  final dynamic value;

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
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}

