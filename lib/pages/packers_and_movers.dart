import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class PackersAndMovers extends StatefulWidget {
  const PackersAndMovers({Key? key}) : super(key: key);

  @override
  _PackersAndMoversState createState() => _PackersAndMoversState();
}

class _PackersAndMoversState extends State<PackersAndMovers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }

  buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Packers And OutStation ',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  buildBody() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        buildType(),
        buildLocation(),
        buildPlaningToMove(),
        buildTypeOfHouse(),
        buildProceed(),
      ],
    );
  }

  buildType() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DropdownSearch<String>(
        maxHeight: 100,
        validator: (v) => v == null ? "required field" : null,
        hint: "Select Type",
        mode: Mode.MENU,
        showSelectedItem: true,
        items: ["Packers", "OutStation"],
        label: " Type",
        // showClearButton: true,
        onChanged: print,
        popupItemDisabled: (String s) => s.startsWith('I'),
        clearButtonSplashRadius: 20,
        // selectedItem: "Tunisia",
        onBeforeChange: (a, b) {
          if (b == null) {
            AlertDialog alert = AlertDialog(
              title: Text("Are you sure..."),
              content: Text("...you want to clear the selection"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                TextButton(
                  child: Text("NOT OK"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );

            return showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                });
          }

          return Future.value(true);
        },
      ),
    );
  }

  buildLocation() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Card(
        elevation: 5,
        child: Container(
          // height: 180,
          width: double.infinity,
          // color: Colors.black12,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Enter',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      ' Location Details',
                      style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    readOnly: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: '  MovingFrom',
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    readOnly: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: '  MovingTo',
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildPlaningToMove() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 20),
      child: Card(
        elevation: 5,
        child: Container(
          // height: 180,
          width: double.infinity,
          // color: Colors.black12,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'When Are You',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      ' Planing To Move?',
                      style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    readOnly: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: ' DD/MM/YYYY',
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTypeOfHouse() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 20),
      child: Card(
        elevation: 5,
        child: Container(
          // height: 180,
          width: double.infinity,
          // color: Colors.black12,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Type of House You',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      ' You Are Moving From?',
                      style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    readOnly: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0),
                    decoration: InputDecoration(
                      // suffix: IconButton(
                      //     iconSize: 5,
                      //     padding: EdgeInsets.zero,
                      //     onPressed: () => DropdownButton(items: null),
                      //     icon: Icon(
                      //       Icons.arrow_drop_down,
                      //       color: Colors.black,
                      //       size: 35,
                      //     )),
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildProceed() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        height: 50,
        // width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green.shade800,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 25.0,
              spreadRadius: 1.0,
              offset: Offset(
                5.0,
                10.0,
              ),
            )
          ],
        ),
        child: Text(
          'Proceed',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
