import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../models/response/response_activition.dart';
import '../models/response/response_get_food_list_by_id.dart';
import '../models/request/request_food_list_by_id.dart';
import '../services/auth_service.dart';
import '../utils/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
//------------------------------------------------
class FoodListScreen extends StatefulWidget {
  final int listId;
  final String listTitle;

  const FoodListScreen(
      {Key? key, required this.listId, required this.listTitle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FoodListState();
  }
}

//------------------------------------------------
class FoodListState extends State<FoodListScreen>
    with AutomaticKeepAliveClientMixin<FoodListScreen> {

  late String _activeCode;
  ResponseActivation? responseActivation;
  ResponseGetFoodListById? response;
  final int _cityId = 1;
  int _pageNumber = 1;
  final int _pageCount = 10;
  late int checkCount;
  bool _isLoading = true;
  late String _deviceId;
  final ScrollController _listScrollController = ScrollController();

  //------------------------------------------------
  @override
  void initState() {
    super.initState();
    sendDataForConfirmCode();
    getFoodListById();

    _listScrollController.addListener(() {
      //for get max length scroll
      double maxScroll = _listScrollController.position.maxScrollExtent; //400
      //location of scroll
      double currentScroll = _listScrollController.position.pixels; // 390
      // dp 400 -390
      if (maxScroll - currentScroll <= 10) {
        if (!_isLoading) {
          getFoodListById(pageNumber: _pageNumber + 1);
        }
      }
    });
  }

  //------------------------------------------------
  Future<void> handleRefresh() async {
    await getFoodListById(refresh: true);
    return;
  }
  //------------------------------------------------
  @override
  Widget build(BuildContext context) {
    super.build(context);

    var page = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: const Color(0xFFFCF9F2),
          body: Container(
              padding: const EdgeInsets.only(right: 5, left: 10, top: 10),
              width: page.width,
              height: page.height,
              child: response == null
                  ? const Center(
                      child: SizedBox(
                          width: 56,
                          height: 56,
                          child: CircularProgressIndicator()))
                  : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, right: 10, bottom: 10),
                    child: Text(widget.listTitle,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'vazirmatn',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: .3)),
                  ),
                  Expanded(
                    child: ListView.builder(
                        controller: _listScrollController,
                        padding: const EdgeInsets.only(top: 0),
                        itemCount: response!.data.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final itemRestaurant = response!.data;
                          return GestureDetector(
                            child: Container(
                                width: (page.width) / 1.4,
                                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                                decoration: const BoxDecoration(boxShadow: []),
                                child: Card(
                                  color: const Color(0xfffafafa),
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                              height: 115,
                                              width: MediaQuery.of(context).size.width,
                                              child: Image.asset(
                                                  'assets/images/bestfood/ic_best_food_8.jpeg',
                                                  fit: BoxFit.cover)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, left: 10),
                                                child: Container(
                                                  width: 60.0,
                                                  height: 60.0,
                                                  margin: const EdgeInsets.symmetric(
                                                      horizontal: 3.0),
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            "assets/images/restaurant_logo/restaurant_logo.png"),
                                                      )),
                                                ),
                                              ),
                                              Text(response!.data[index].shopName,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'vazirmatn',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      letterSpacing: .3)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 10),
                                        height: 112,
                                        color: Colors.white,
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.topRight,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${response!.data[index].foodName} $index',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'vazirmatn',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    letterSpacing: .3)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            onTap: () {
                              setState(() {});
                            },
                          );
                        }),
                  )
                ],
              )
          )
      ),
    );
  }

  //------------------------------------------------
  getFoodListById({int pageNumber = 1, bool refresh = false}) async {

    setState(() {
      _isLoading = true;
    });
    _pageNumber = pageNumber;
    final body = RequestGetFoodListById(
       // token: Constant.token,
        token:"9ccdbaf04d723e2fb9b86ee306cece41",
        id: widget.listId,
        cityId: _cityId,
        pageNumber: pageNumber,
        pageCount: _pageCount);

    final responseNew = await (AuthService()).getFoodListById(body.toJson());
    if (responseNew.code == 200) {
      if (response == null) {
        response = responseNew;
      } else {
        response!.data.addAll(responseNew.data);
      }
      setState(() {
        // if(refresh)
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        responseNew!.msg,
        style: const TextStyle(fontFamily: 'Vazirmatn'),
      )));
    }
  }

//------------------------------------------------
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
//------------------------------------------------
  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    //check login done or not
    if (await checkConnectionInternet()) {
      //  await AuthService.checkApiToken(token!)
      if (token != null) Constant.token = token;

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(hours: 2),
          content: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              checkToken();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('از اتصال دستگاه به اینترنت مطمئن شوید',
                    style: TextStyle(fontFamily: 'Vazirmatn')),
                Icon(Icons.wifi_lock, color: Colors.white)
              ],
            ),
          )));
    }
  }

  //------------------------------------------------
  Future<bool> checkConnectionInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
  //-----------------------------------------------
  sendDataForConfirmCode() async {
    initPlatformState();
    responseActivation = await (AuthService()).sendDataForConfirmCode({
      'mobile': '09151192366',
      // 'activeCode':_activeCode,
      'activeCode': 1111,
      'deviceId': _deviceId
    });
    if (responseActivation!.code == 200) {
      await storeUserData(responseActivation!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            responseActivation!.msg,
            style: const TextStyle(fontFamily: 'vazirmatn'),
          )));
    }
  }

//-----------------------------------------------
//for save data from server
  storeUserData(ResponseActivation responseActivation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', responseActivation.data.token);
    Constant.token = responseActivation.data.token;
    // log('token ${response.data.token}');
  }

//-----------------------------------------------

  Future<void> initPlatformState() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      _deviceId = deviceId!;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    if (!mounted) return;

  }
//------------------------------------------------

}
