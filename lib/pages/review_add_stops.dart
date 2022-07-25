import 'package:flutter/material.dart';

class ReviewAddStops extends StatefulWidget {
  const ReviewAddStops({Key? key}) : super(key: key);

  @override
  _ReviewAddStopsState createState() => _ReviewAddStopsState();
}

class _ReviewAddStopsState extends State<ReviewAddStops> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: buildBNB(),
    );
  }

  buildBody() {
    return Stack(
      children: [
        buildMap(),
        SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height - 250),
            child: buildvehicalType(),
          ),
        )
      ],
    );
  }

  buildMap() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 1,
      width: double.infinity,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.grey,
            image: DecorationImage(
                image: NetworkImage(
                    'https://static2.tripoto.com/media/filter/tst/img/466718/TripDocument/1514641199_2017_12_30_13_06_37_photos.png'),
                fit: BoxFit.cover)),
      ),
    );
  }

  buildvehicalType() {
    return SingleChildScrollView(
      child: Container(
        // height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3, bottom: 3),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueGrey[200],
                  ),
                  height: 5,
                  width: 50,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Review/',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    'AddStop',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: double.infinity,
                  // color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 30,
                        ),
                        Expanded(
                          child: Text(
                            '6/8, cholourpala, binnipet, bengaluru,karnataka 560009',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )),
              Container(
                  width: double.infinity,
                  // color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.stop_circle_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Expanded(
                          child: Text(
                            '6/8, cholourpala, binnipet, bengaluru,karnataka 560009',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )),
              Container(
                  width: double.infinity,
                  // color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.stop_circle_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Expanded(
                          child: Text(
                            '6/8, cholourpala, binnipet, bengaluru,karnataka 560009',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )),
              Container(
                  width: double.infinity,
                  // color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 30,
                        ),
                        Expanded(
                          child: Text(
                            '6/8, cholourpala, binnipet, bengaluru,karnataka 560009',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'ConfirmLocation');
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.add_box),
                        Text(
                          'Add Stops',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildBNB() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'SelectVehical');
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          // width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
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
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

// class ReorderableViewPage extends StatefulWidget {
//   List<String> item = [
//     "Clients",
//     "Designer",
//     "Developer",
//     "Director",
//     "Employee",
//     "Manager",
//     "Worker",
//     "Owner"
//   ];
//   @override
//   _ReorderableViewPageState createState() => _ReorderableViewPageState();
// }

// class _ReorderableViewPageState extends State<ReorderableViewPage> {
//   void reorderData(int oldindex, int newindex) {
//     setState(() {
//       if (newindex > oldindex) {
//         newindex -= 1;
//       }
//       final items = widget.item.removeAt(oldindex);
//       widget.item.insert(newindex, items);
//     });
//   }

//   void sorting() {
//     setState(() {
//       widget.item.sort();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[400],
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           "Reorderable ListView In Flutter",
//           style: TextStyle(color: Colors.pinkAccent[100]),
//         ),
//         centerTitle: true,
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(Icons.sort_by_alpha),
//               tooltip: "Sort",
//               onPressed: sorting),
//         ],
//       ),
//       body: ReorderableListView(
//         children: <Widget>[
//           for (final items in widget.item)
//             Card(
//               color: Colors.blueGrey,
//               key: ValueKey(items),
//               elevation: 2,
//               child: Container(
//                 height: 50,
//                 color: Colors.amber,
//               ),
//             ),
//         ],
//         onReorder: reorderData,
//       ),
//     );
//   }
// }
