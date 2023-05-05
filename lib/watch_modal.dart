import 'package:bezel/responsive/responsive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'api calls/requests.dart';

class WatchModal extends StatelessWidget {
  const WatchModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Future<Map> _info;

    return Scaffold(
        body: Container(
      color: Color(0xFF17302b),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: GestureDetector(
                  onTap: () {
                    _info = fetchInfo();
                    showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) => Modal(
                              info: _info,
                            ));
                  },
                  child: Image.asset("assets/images/logo.png"))),
        ],
      ),
    ));
  }
}

class Modal extends StatefulWidget {
  final Future<Map> info;

  Modal({required this.info});

  @override
  State<Modal> createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  int _status = -1;
  bool _showAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Color(0xFFfffcf8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          width: ResponsiveFlutter.of(context).verticalScale(400),
          height: ResponsiveFlutter.of(context).scale(710),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Stack(
            children: [
              FutureBuilder(
                future: widget.info,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: ResponsiveFlutter.of(context).scale(97),
                              left: ResponsiveFlutter.of(context)
                                  .verticalScale(24)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    ResponsiveFlutter.of(context)
                                        .verticalScale(4),
                                    0,
                                    0,
                                    ResponsiveFlutter.of(context).scale(32)),
                                child: Text(
                                  "CONGRATS!",
                                  style: TextStyle(
                                      color: Color(0xFF9da09e),
                                      fontWeight: FontWeight.w600,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(0.70)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    ResponsiveFlutter.of(context)
                                        .verticalScale(4),
                                    0,
                                    0,
                                    ResponsiveFlutter.of(context).scale(60)),
                                child: Text(
                                  "Your watch sold!",
                                  style: TextStyle(
                                      color: Color(0xFF1a3a32),
                                      fontWeight: FontWeight.w600,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.3)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    ResponsiveFlutter.of(context)
                                        .verticalScale(4),
                                    0,
                                    0,
                                    ResponsiveFlutter.of(context).scale(90)),
                                child: Text(
                                  "You have 1 business day to accept the sale.\n If you do not accept, it will be automatically\n rejected.",
                                  style: TextStyle(
                                      color: Color(0xFF1a3a32),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(0.70)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ResponsiveFlutter.of(context)
                                        .verticalScale(1),
                                    vertical:
                                        ResponsiveFlutter.of(context).scale(4)),
                                child: TextButton(
                                  onPressed: () async {
                                    _status = await acceptOrder();
                                    setState(() {
                                      _status;
                                      _showAnimation = true;
                                    });
                                  },
                                  child: Text("Accept Sale"),
                                  style: TextButton.styleFrom(
                                    primary: Color(0xFFfffcf8), // Text color
                                    backgroundColor:
                                        Color(0xFF1a3a32), // Background color
                                    textStyle: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(0.80),
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFfffcf8)), // Text size
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            ResponsiveFlutter.of(context)
                                                .verticalScale(52),
                                        vertical: ResponsiveFlutter.of(context)
                                            .scale(42)), // Padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // Rounded border
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ResponsiveFlutter.of(context)
                                          .verticalScale(54),
                                      top: ResponsiveFlutter.of(context)
                                          .scale(42)),
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        "Reject Sale",
                                        style: TextStyle(
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(0.80),
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1a3a32)),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  _status = await declineOrder();
                                  setState(() {
                                    _status;
                                    _showAnimation = true;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ResponsiveFlutter.of(context).scale(44),
                              horizontal: ResponsiveFlutter.of(context)
                                  .verticalScale(8)),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: ResponsiveFlutter.of(context)
                                      .verticalScale(180),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xfff6f4f0)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            ResponsiveFlutter.of(context)
                                                .verticalScale(12),
                                            ResponsiveFlutter.of(context)
                                                .scale(34),
                                            ResponsiveFlutter.of(context)
                                                .verticalScale(12),
                                            ResponsiveFlutter.of(context)
                                                .scale(2)),
                                        child: Divider(
                                          thickness: 1.5,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveFlutter.of(context)
                                                    .verticalScale(12)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${snapshot.data?["listing"]["model"]["displayName"]} ${snapshot.data?["listing"]["model"]["brand"]["displayName"]}",
                                                  style: TextStyle(
                                                      color: Color(0xFF1a3a32),
                                                      fontSize:
                                                          ResponsiveFlutter.of(
                                                                  context)
                                                              .fontSize(0.80),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: ResponsiveFlutter.of(
                                                          context)
                                                      .scale(5),
                                                ),
                                                Text(
                                                  "${snapshot.data?["listing"]["condition"]} / ${snapshot.data?["listing"]["manufactureYear"]}",
                                                  style: TextStyle(
                                                      color: Color(0xFF9da09e),
                                                      fontSize:
                                                          ResponsiveFlutter.of(
                                                                  context)
                                                              .fontSize(0.70),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                snapshot.data?["listing"]
                                                        ["images"][0]["image"]
                                                    ["url"],
                                                fit: BoxFit.fill,
                                                width: ResponsiveFlutter.of(
                                                        context)
                                                    .verticalScale(35),
                                                height: ResponsiveFlutter.of(
                                                        context)
                                                    .scale(100),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            ResponsiveFlutter.of(context)
                                                .verticalScale(12),
                                            0,
                                            ResponsiveFlutter.of(context)
                                                .verticalScale(12),
                                            ResponsiveFlutter.of(context)
                                                .scale(11)),
                                        child: Divider(
                                          thickness: 1.5,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveFlutter.of(context)
                                                    .verticalScale(12),
                                            vertical:
                                                ResponsiveFlutter.of(context)
                                                    .scale(11)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Selling Price",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xFF9da09e)),
                                            ),
                                            Text(
                                              "\$ ${(snapshot.data?["payoutAmountCents"] / 100.0).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.85),
                                                  color: Color(0xFF1a3a32),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveFlutter.of(context)
                                                    .verticalScale(12),
                                            vertical:
                                                ResponsiveFlutter.of(context)
                                                    .scale(11)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Level 1 Commision (${snapshot.data?["commissionRateBips"] / 100.0}%)",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xFF9da09e)),
                                            ),
                                            Text(
                                              "\$ ${((snapshot.data?["payoutAmountCents"] / 100.0) * (snapshot.data?["commissionRateBips"] / 100.0) / 100.0).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xFF9da09e)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveFlutter.of(context)
                                                    .verticalScale(12),
                                            vertical:
                                                ResponsiveFlutter.of(context)
                                                    .scale(11)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Seller Fee",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xFF9da09e)),
                                            ),
                                            Text(
                                              "\$ ${(snapshot.data?["sellerFeeCents"] / 100.0).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xFF9da09e)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveFlutter.of(context)
                                                    .verticalScale(12),
                                            vertical:
                                                ResponsiveFlutter.of(context)
                                                    .scale(11)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Insured Shipping",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xFF9da09e)),
                                            ),
                                            Text(
                                              "Free",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xFF9da09e)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveFlutter.of(context)
                                                    .verticalScale(12),
                                            vertical:
                                                ResponsiveFlutter.of(context)
                                                    .scale(11)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Bezel Authentication",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xff29846f)),
                                            ),
                                            Text(
                                              "Free",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xff29846f)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  ResponsiveFlutter.of(context)
                                                      .verticalScale(12),
                                              vertical:
                                                  ResponsiveFlutter.of(context)
                                                      .scale(11)),
                                          child: Divider(
                                            thickness: 1.5,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveFlutter.of(context)
                                                    .verticalScale(12),
                                            vertical:
                                                ResponsiveFlutter.of(context)
                                                    .scale(11)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Earnings",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xFF1a3a32),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              "\$${(snapshot.data?["salePriceCents"] / 100.0).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(0.80),
                                                  color: Color(0xFF1a3a32),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/logo.png"),
                        SizedBox(
                          height: ResponsiveFlutter.of(context).scale(20),
                        ),
                        Text(
                          "Failed to load data",
                          style: TextStyle(
                              color: Color(0xFF1a3a32),
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        )
                      ],
                    );
                  }

                  // By default, show a loading spinner.
                  return Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFF1a3a32)));
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveFlutter.of(context).verticalScale(6),
                    vertical: ResponsiveFlutter.of(context).scale(18)),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: ResponsiveFlutter.of(context).fontSize(1.2),
                    ),
                  ),
                ),
              ),
              if (_showAnimation)
                Positioned.fill(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAnimation = false;
                    });
                    if (_status != 0) Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.75),
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _status != 0
                            ? Lottie.asset(
                                "assets/animations/green_tick.json",
                                repeat: false,
                                height: ResponsiveFlutter.of(context)
                                    .verticalScale(100),
                                width: ResponsiveFlutter.of(context).scale(200),
                              )
                            : Lottie.asset("assets/animations/failed.json",
                                repeat: false,
                                height: ResponsiveFlutter.of(context)
                                    .verticalScale(100),
                                width:
                                    ResponsiveFlutter.of(context).scale(200)),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _status == 1
                                ? Text(
                                    "Sale Successfully Accepted",
                                    style: TextStyle(
                                        color: Color(0xFFfffcf8),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  )
                                : _status == 2
                                    ? Text("Sale Successfully Rejected",
                                        style: TextStyle(
                                            color: Color(0xFFfffcf8),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700))
                                    : Text(
                                        "Something went wrong, try again!",
                                        style: TextStyle(
                                            color: Color(0xFFfffcf8),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ))
                      ],
                    )),
                  ),
                )),
            ],
          ),
        ));
  }
}
