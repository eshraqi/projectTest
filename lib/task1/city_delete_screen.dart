import 'package:flutter/material.dart';
import 'package:task/task1/homeScreen.dart';
import 'package:task/task1/sqliteProvider/cat_provider.dart';
import '../models/cat.dart';
import '../utils/app_color.dart';

//------------------------------------------------
class CityDeleteScreen extends StatefulWidget{
  const CityDeleteScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CityUpdateState();
  }
}
//------------------------------------------------
class CityUpdateState extends State<CityDeleteScreen>{
  late Cat cat;
  late List<Cat> catList;
  var fido,milo, jubi;
  //------------------------------------------------
  @override
  Future<void> initState() async {
    super.initState();
  }

  //------------------------------------------------
  @override
  Widget build(BuildContext context) {
    var page = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
            width: page.width,
            height: page.height,
            child: catList == null
                ? const Center(
                child: SizedBox(
                    width: 56,
                    height: 56,
                    child: CircularProgressIndicator()))
                : Expanded(
                child: Stack(children: <Widget>[
                  Column(children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 24),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemCount: catList.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return catItem(cat.name[index], index);
                              }),
                        )),
                  ]),
                  Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 40, right: 30, left: 30),
                      width: 150,
                      decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)),
                        gradient: LinearGradient(
                            colors: [
                              Color(0xff075E54),
                              Color(0xFF26a69a)
                            ],
                            begin: FractionalOffset(0.2, 0.2),
                            end: FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: const Color(0xff075E54),
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Text("بازگشت",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'vazirmatn',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: .3)),
                          ),
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const HomeScreen(),
                                ))
                          }),
                    ),
                  ),
                ])
            )
        )
    );
  }
//------------------------------------------------
  catItem(String catName, int index) {
    return SizedBox(
      // height: 70,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(catName!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.right),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: IconButton(
                      onPressed: () {
                        _deleteDataSqlite(index);
                      },
                      icon: Image.asset(
                        "assets/images/menus/ic_delete.png",
                        width: 20,
                        height: 20,
                        color: const Color(0xFFfd2c2c),
                      ),
                    ),
                  )
                ]),
            const Divider(color: AppColor.grayText),
          ],
        ));
  }
//-----------------------------------------------
  static Future<bool> _deleteDataSqlite(int index) async {
    var db = CatProvider();
    try {
      await db.open();
      await db.deleteCat(index);
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }

//-----------------------------------------------

}