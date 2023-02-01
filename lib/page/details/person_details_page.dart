import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:khdma/api/myapi.dart';
import 'package:khdma/controllers/user_job_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../language/app_words.dart';
import '../../models/user_job_model.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../widget/main_text.dart';
import '../widget/mediat_text.dart';
import '../widget/small_text.dart';
import '../../vars.dart' as v;

class PersonDetailsPage extends StatefulWidget {
  // static const id = "/PersonDetailsPage";
  final JobsModel? jobsModel;

  PersonDetailsPage({Key? key, this.jobsModel}) : super(key: key);

  @override
  State<PersonDetailsPage> createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  UserJobsController userJobsController = Get.find();
  // TextEditingController date = TextEditingController();
  TextEditingController _txtproblem = TextEditingController();
  TextEditingController _txtprice = TextEditingController();
  TextEditingController _txtdate_start = TextEditingController();
  TextEditingController _txtdate_end = TextEditingController();

  MyApi myApi = MyApi();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: MediatText(
          text: AppWords.appName,
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Dimensions.height100 + 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            Column(
              children: [
                const MainText(
                  text: "More details",
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20 - 10,
                    right: Dimensions.width20 - 10,
                  ),
                  padding: EdgeInsets.only(
                    bottom: Dimensions.height20 - 10,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height20 - 12),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                height: 120,
                                width: 120,
                                child: Image.network(
                                  "${v.storageLink}${widget.jobsModel?.path}",
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, obj, st) {
                                    return Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    );
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      padding: EdgeInsets.all(4),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: Dimensions.height100 * 2,
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.width20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.width20 - 10,
                                    right: Dimensions.width20 - 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: MainText(text: widget.jobsModel?.name),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20 - 10,
                                    ),
                                    SmallText(text: widget.jobsModel?.address),
                                    SizedBox(
                                      height: Dimensions.height20 - 10,
                                    ),
                                    SmallText(text: widget.jobsModel?.email),
                                    SizedBox(
                                      height: Dimensions.height20 - 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        widget.jobsModel?.phone != null
                                            ? SmallText(
                                                text: widget.jobsModel?.phone,
                                              )
                                            : const SmallText(
                                                text:
                                                    "He is not have phone number",
                                              ),
                                        Builder(builder: (context) {
                                          bool isUploading = false;
                                          return StatefulBuilder(builder:
                                              (context, setStateInternal) {
                                            doRated({int? rate}) {
                                              print("rate: ${rate}");
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    right: Dimensions.width20 -
                                                        10),
                                                child: Column(
                                                  children: [
                                                    /*Expanded(
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.star,
                                                            color: AppColors
                                                                .mainColor,
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions
                                                                    .width20 -
                                                                15,
                                                          ),
                                                          MediatText(
                                                              text: widget.jobsModel
                                                                  ?.rating),
                                                        ],
                                                      ),
                                                    ),*/
                                                    Visibility(
                                                      visible: !isUploading,
                                                      replacement:
                                                          CircularProgressIndicator(
                                                              strokeWidth: 3),
                                                      child: InkWell(
                                                          onTap: () async {
                                                            isUploading = true;
                                                            setStateInternal(
                                                                () {});

                                                            await myApi.postRequest(
                                                                apiName:
                                                                    "rating",
                                                                conditionId:
                                                                    "${widget.jobsModel?.id}",
                                                                params: {
                                                                  'rating':
                                                                      '${rate ?? 1}'
                                                                })?.then(
                                                                (value) {
                                                              print(
                                                                  "value of rating: ${value}");
                                                              if (value !=
                                                                  null) {
                                                                if (rate ==
                                                                    null) {
                                                                  v.db.insert(
                                                                    table:
                                                                        "likes",
                                                                    obj: {
                                                                      'worker_id':
                                                                          '${widget.jobsModel?.id}',
                                                                      'value':
                                                                          '1',
                                                                      "created_at":
                                                                          DateTime.now()
                                                                              .toIso8601String(),
                                                                      "updated_at":
                                                                          DateTime.now()
                                                                              .toIso8601String(),
                                                                    },
                                                                  ).then(
                                                                      (value) {
                                                                    int val =
                                                                        rate ??
                                                                            1;
                                                                    int rating =
                                                                        int.parse(widget.jobsModel!
                                                                            .rating
                                                                            .toString());
                                                                    widget.jobsModel
                                                                        ?.rating = (rating +
                                                                            val)
                                                                        .toString();
                                                                  }).catchError(
                                                                      (err) {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                      msg:
                                                                          "Failed insert in sqlite",
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    );
                                                                  });
                                                                } else {
                                                                  v.db
                                                                      .update(
                                                                          table:
                                                                              "likes",
                                                                          obj: {
                                                                            'value':
                                                                                '${rate}',
                                                                          },
                                                                          condition:
                                                                              "worker_id = '${widget.jobsModel?.id}'")
                                                                      .then(
                                                                          (value) {
                                                                    int val =
                                                                        rate;
                                                                    int rating =
                                                                        int.parse(widget.jobsModel!
                                                                            .rating
                                                                            .toString());
                                                                    widget.jobsModel
                                                                        ?.rating = (rating +
                                                                            val)
                                                                        .toString();
                                                                  }).catchError(
                                                                          (err) {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                      msg:
                                                                          "Failed update in sqlite",
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    );
                                                                  });
                                                                }
                                                              }
                                                            }).catchError(
                                                                (err) {
                                                              print(
                                                                  "err postRequest rating: ${err}");
                                                            });

                                                            isUploading = false;
                                                            setStateInternal(
                                                                () {});
                                                          },
                                                          child: Icon(
                                                            (rate == 1 ||
                                                                    rate ==
                                                                        null)
                                                                ? Icons
                                                                    .favorite_border
                                                                : Icons
                                                                    .favorite,
                                                            color: (rate == 1 ||
                                                                    rate ==
                                                                        null)
                                                                ? Colors.grey
                                                                : Colors.pink,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            return FutureBuilder(
                                                future: v.db.select(
                                                    column: "*",
                                                    table: "likes",
                                                    condition:
                                                        "worker_id = '${widget.jobsModel?.id}'"),
                                                builder: (context,
                                                    AsyncSnapshot<List>
                                                        snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (snapshot.data!.length ==
                                                        0) {
                                                      return doRated(
                                                          rate: null);
                                                    } else {
                                                      final item =
                                                          snapshot.data![0];
                                                      if (item['value'] ==
                                                          "1") {
                                                        return doRated(
                                                            rate: -1);
                                                      } else {
                                                        return doRated(rate: 1);
                                                      }
                                                    }
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text("error");
                                                  } else {
                                                    return Text("loading ...");
                                                  }
                                                });
                                          });
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Form(
                        key: _formkey,
                        child: Column(
                        children: [
                          Container(
                            width: Get.width * 0.9,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.price_check,
                                      color: Colors.blue,
                                    )),
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: "Price"
                                    ),
                                    controller: _txtprice,
                                    validator: (String? val) {
                                      if (val == null || val == "") {
                                        return "لا يمكن ترك هذا الحقل فارغ";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        Container(
                          width: Get.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width20, right: Dimensions.width20),
                            child: TextFormField(
                              controller: _txtdate_start,
                              readOnly: true,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.calendar_month),
                                  labelText: "Select Date Start"
                              ),
                              onTap: () async {
                                DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(3000),);
                                if(pickDate !=null){
                                  setState(() {
                                    _txtdate_start.text = DateFormat('dd-mm-yyyy').format(pickDate);
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: Get.width * 0.9,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width20, right: Dimensions.width20),
                              child: TextFormField(
                                controller: _txtdate_end,
                                readOnly: true,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.calendar_month),
                                    labelText: "Select Date End"
                                ),
                                onTap: () async {
                                  DateTime? pickDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(3000),);
                                  if(pickDate !=null){
                                    setState(() {
                                      _txtdate_end.text = DateFormat('dd-mm-yyyy').format(pickDate);
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.report_problem_outlined,
                                    color: Colors.blue,
                                  )),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    labelText: "Problem"
                                  ),
                                  controller: _txtproblem,
                                  validator: (String? val) {
                                    if (val == null || val == "") {
                                      return "لا يمكن ترك هذا الحقل فارغ";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: Get.width * 0.6,
                        height: 60,
                        child: Builder(builder: (context) {
                          bool isBooking = false;
                          return StatefulBuilder(
                              builder: (context, setStateInternal) {
                            return Visibility(
                              visible: !isBooking,
                              replacement: Column(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.icoColor2
                                ),
                                onPressed: (widget.jobsModel!.booking != "1") ? () async {
                                  if(_formkey.currentState!.validate() == false || _txtdate_end.text.isEmpty || _txtdate_end.text.isEmpty){
                                    Fluttertoast.showToast(msg: "There is fields is empty");
                                    return;
                                  }
                                  if(widget.jobsModel!.booking == "1"){
                                    Fluttertoast.showToast(msg: "The worker is booked");
                                    return;
                                  }
                                        isBooking = true;
                                  setStateInternal(() {});
                                        await myApi.postRequest(
                                            apiName: "work_users",
                                            // conditionId: "${widget.jobsModel!.id}",
                                            params: {
                                              "title": "${_txtproblem.text}",
                                              "price": "${_txtprice.text}",
                                              "date_start": "${_txtdate_start.text}",
                                              "date_end": "${_txtdate_end.text}",
                                              "user_id_w": "${widget.jobsModel!.id}",
                                              "user_id_c": "${v.userData['id']}",
                                            })?.then((value) {
                                          if (widget.jobsModel!.booking != "1") {
                                            widget.jobsModel!.booking = "1";
                                          } else {
                                            widget.jobsModel!.booking = "0";
                                          }
                                        }).catchError((err) {
                                          Fluttertoast.showToast(
                                            msg: "Failed booking",
                                            backgroundColor: Colors.red);
                                        });
                                        await Future.delayed(Duration(seconds: 1));
                                        isBooking = false;
                                        setStateInternal(() {});
                                      }
                                    : null,
                                child: Text(
                                  (widget.jobsModel!.booking == "0")
                                      ? "Booking"
                                      : "Booked",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            );
                          });
                        }),
                      ),
                      SizedBox(
                        height: Dimensions.height45,
                      ),
                      Center(
                        child: Container(
                          height: Dimensions.height100 * 2.5,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white12,
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/jobs.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
