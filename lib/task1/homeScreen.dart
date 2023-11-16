import 'package:flutter/material.dart';
import 'package:task/task1/sqliteProvider/cat_provider.dart';
import 'package:task/utils/app_color.dart';
import '../models/cat.dart';
import '../wigets/button_normal.dart';
import 'city_delete_screen.dart';
import 'city_update_screen.dart';

//------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

//------------------------------------------------
class HomeState extends State<HomeScreen> {
  late Cat cat;
  late List<String> catsList = [fido, milo];
  var fido, milo, jubi;

  //------------------------------------------------
  @override
  initState() {
    super.initState();

    fido = const Cat(
      id: 0,
      name: 'Fido',
      age: 35,
    );
    milo = const Cat(
      id: 0,
      name: 'Milo',
      age: 35,
    );
    jubi = const Cat(
      id: 0,
      name: 'Jilo',
      age: 35,
    );
    catsList.add(fido);
    catsList.add(milo);
    catsList.add(jubi);
    _storeCatSqlite();
  }

  //------------------------------------------------
  @override
  Widget build(BuildContext context) {
    var page = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
            width: page.width,
            height: page.height,
            child: catsList == null
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
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: catsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return catItem(cat.name[index]!);
                            }),
                      )),
                    ]),
                    Align(
                      alignment: FractionalOffset.bottomLeft,
                      child: Row(children: [
                        Expanded(
                            child: ButtonNormal(
                                text: " آپدیت شهر",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CityUpdateScreen()),
                                  );
                                })),
                        Expanded(
                            child: ButtonNormal(
                                text: "حذف شهر",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CityDeleteScreen()),
                                  );
                                })),
                      ]),
                    ),
                  ]))));
  }

  //------------------------------------------------
  catItem(String catName) {
    return SizedBox(
        // height: 70,
        child: Column(
      children: <Widget>[
        Expanded(
          child: Text(catName!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.right),
        ),
        const Divider(color: AppColor.grayText),
      ],
    ));
  }

//-----------------------------------------------

  Future<bool> _storeCatSqlite() async {
    var db = CatProvider();
    try {
      await db.open();
      await db.getCats();
      await db.insertCat(fido);
      await db.insertCat(milo);
      await db.insertCat(jubi);
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }
}
