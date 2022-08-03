import 'package:flutter/material.dart';
import 'package:new_ank_customer/Services/apiProvider/goods_types_api_provider.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/common/utils.dart';
import 'package:provider/provider.dart';

class GoodsTypeScreen extends StatefulWidget {
  const GoodsTypeScreen({Key? key}) : super(key: key);

  @override
  State<GoodsTypeScreen> createState() => _GoodsTypeScreenState();
}

class _GoodsTypeScreenState extends State<GoodsTypeScreen> {
  @override
  void initState() {
    if (context.read<ListGoodTypeAPIProvider>().goodsTypeResponseModel ==
        null) {
      context.read<ListGoodTypeAPIProvider>().fetchData();
    }

    // TODO: implement initState
    super.initState();
  }

  String? selectedIndex;
  String? selectedGoodsType;

  @override
  Widget build(BuildContext context) {
    final goodTypeAPIProvider = Provider.of<ListGoodTypeAPIProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Utils.getSizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: Colors.brown[900],
                    )),
                Utils.getSizedBox(width: 15),
                Text(
                  "Select your goods type",
                  style: CommonStyles.blackText17BoldW500(),
                ),
              ],
            ),
            Utils.getSizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "You can select multiple types and give estimated weight,\n This will help us to charge you fair amount.",
                    style: CommonStyles.black10thin(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            Utils.getSizedBox(height: 20),
            goodTypeAPIProvider.ifLoading
                ? CircularProgressIndicator(
                    strokeWidth: 0.5,
                  )
                : buildListView(goodTypeAPIProvider),
          ],
        ),
      ),
    );
  }

  Widget buildListView(ListGoodTypeAPIProvider goodTypeAPIProvider) {
    return Column(
      children: [
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: goodTypeAPIProvider
                .goodsTypeResponseModel!.categoryList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = goodTypeAPIProvider
                              .goodsTypeResponseModel!.categoryList![index].id;
                          selectedGoodsType = goodTypeAPIProvider
                              .goodsTypeResponseModel!
                              .categoryList![index]
                              .categoryName;
                          print("Slected id ---------" +
                              selectedIndex.toString());
                          print("Slected Type ---------" +
                              selectedGoodsType.toString());
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.blueAccent, width: 2)),
                            child: (selectedIndex ==
                                    goodTypeAPIProvider.goodsTypeResponseModel!
                                        .categoryList![index].id)
                                ? Center(
                                    child:
                                        Icon(Icons.check, color: Colors.green),
                                  )
                                : null,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            goodTypeAPIProvider.goodsTypeResponseModel!
                                .categoryList![index].categoryName!,
                            style: CommonStyles.black16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    )
                  ],
                ),
              );
            }),
        Utils.getSizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Colors.blue[900],
              height: 40,
              onPressed: () {
                Map<String, dynamic> map = {
                  'goodtype': selectedGoodsType,
                };

                Navigator.of(context).pop(map);
              },
              child: Center(
                child: Text(
                  " Update ",
                  style: CommonStyles.whiteText12BoldW500(),
                ),
              )),
        )
      ],
    );
  }
}
