import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:urban_home/web_services/api_provider.dart';
import 'package:urban_home/web_services/urls.dart';
import 'package:urban_home/web_services/user.dart';
import '../../constant/constant.dart';
import '../screens.dart';
import '../../widget/column_builder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final serviceList = [
  //   {
  //     'title': 'Personal Care Services',
  //     'image': 'assets/icon/white/001-household.png',
  //     'color': orangeColor
  //   },
  //   {
  //     'title': 'Home Care Services',
  //     'image': 'assets/icon/white/002-plumber.png',
  //     'color': primaryColor
  //   },
  //   {
  //     'title': 'Home Design Services',
  //     'image': 'assets/icon/white/003-electrician.png',
  //     'color': redColor
  //   },
  //   {
  //     'title': 'Repair Services',
  //     'image': 'assets/icon/white/004-painter.png',
  //     'color': orangeColor
  //   },
  //   {
  //     'title': 'Best Offer',
  //     'image': 'assets/icon/white/005-meditation.png',
  //     'color': primaryColor
  //   },
  //   {
  //     'title': 'Beautician',
  //     'image': 'assets/icon/white/006-makeup.png',
  //     'color': redColor
  //   }
  // ];

  // final bestOfferList = [
  //   {
  //     'title': 'Salon at home for Women',
  //     'image': 'assets/best-offers/best-offers-1.jpeg',
  //     'subtitle': 'Upto 50% Off'
  //   },
  //   {
  //     'title': 'Salon for Men',
  //     'image': 'assets/best-offers/best-offers-2.jpeg',
  //     'subtitle': 'Upto 50% Off'
  //   },
  //   {
  //     'title': 'Bathroom Cleaning',
  //     'image': 'assets/best-offers/best-offers-3.jpeg',
  //     'subtitle': 'Free Fan Cleaning & More'
  //   },
  //   {
  //     'title': 'House Painters',
  //     'image': 'assets/best-offers/best-offers-4.jpeg',
  //     'subtitle': 'Upto 15% Off'
  //   }
  // ];

  // final reviewList = [
  //   {
  //     'name': 'Natasha',
  //     'review':
  //         'Sofia is as amazing as her reviews. Very through job, takes the time to get into the details. Will be booking again.',
  //     'service': 'Home Cleaning'
  //   },
  //   {
  //     'name': 'Menka',
  //     'review':
  //         'Hotel style cleaning. Beyond perfection. Will definitely hope he accepts future bookings.',
  //     'service': 'Home Cleaning'
  //   },
  //   {
  //     'name': 'Justine',
  //     'review':
  //         'Michael was very nice and provided a very efficient service. Highly recommended.',
  //     'service': 'Handyman'
  //   },
  //   {
  //     'name': 'Chaitali',
  //     'review':
  //         'On time and accurate. Clean work. John is cooperative and polite. Will be happy to have them again for next service.',
  //     'service': 'Home Cleaning'
  //   },
  //   {
  //     'name': 'Claire',
  //     'review':
  //         'Carla did a fantastic job. Cleaning our place and was very easy to communicate with.',
  //     'service': 'Home Cleaning'
  //   }
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: ListView(
        children: [
          userAndLocation(),
          searchBar(),
          selectService(),
          todaysOfferBanner(),
          bestOffers(),
          customerReviews(),
        ],
      ),
    );
  }

  userAndLocation() {
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 24.0,
                color: greyColor,
              ),
              width5Space,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                      color: greyColor.withOpacity(0.6),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  height5Space,
                  Text(
                    'New York',
                    style: grey14MediumTextStyle,
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomBar(
                    index: 5,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: NetworkImage(User.image ??
                      'https://i.etsystatic.com/21073028/r/il/1b1907/2662292100/il_340x270.2662292100_t37c.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    color: blackColor.withOpacity(0.25),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: Search(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                spreadRadius: 1.0,
                color: blackColor.withOpacity(0.25),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(
              fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 24.0,
                color: primaryColor,
              ),
              widthSpace,
              Text(
                'Search for a service',
                style: grey14MediumTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectService() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Select Service',
                style: black16BoldTextStyle,
              ),
              // InkWell(
              //   onTap: () {},
              //   child: Text(
              //     'See all',
              //     style: primary14MediumTextStyle,
              //   ),
              // ),
            ],
          ),
        ),
        Container(
          height: 105.0,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: ApiProvider.getMethod('/api/getcategory'),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final category = snapshot.data["getcategory"];
                return ListView.builder(
                  itemCount: category.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = category[index];
                    return Padding(
                      padding: (index != category.length - 1)
                          ? const EdgeInsets.only(left: fixPadding * 2.0)
                          : const EdgeInsets.symmetric(
                          horizontal: fixPadding * 2.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ServiceList(categoryId: data["_id"]),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: primaryColor,
                              ),
                              child: Image.network(
                                imageBaseUrl + data['image'],
                                width: 60.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: 80.0,
// height: 25.0,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                data['categoryname'],
                                style: black10MediumTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitRing(
                      color: primaryColor,
                      size: 40.0,
                      lineWidth: 1.2,
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      'Please Wait..',
                      style: grey14MediumTextStyle,
                    ),
                  ],
                );
              }
              return Container();
            },
          )
          // ListView.builder(
          //   itemCount: serviceList.length,
          //   scrollDirection: Axis.horizontal,
          //   physics: BouncingScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     final item = serviceList[index];
          //     return Padding(
          //       padding: (index != serviceList.length - 1)
          //           ? const EdgeInsets.only(left: fixPadding * 2.0)
          //           : const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          //       child: InkWell(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             PageTransition(
          //               type: PageTransitionType.rightToLeft,
          //               child: ServiceList(),
          //             ),
          //           );
          //         },
          //         borderRadius: BorderRadius.circular(10.0),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               width: 80.0,
          //               height: 80.0,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10.0),
          //                   border: Border.all(color: greyColor)
          //                   //color: item['color'],
          //                   ),
          //               child: Image.asset(
          //                 item['image'],
          //                 width: 60.0,
          //                 height: 60.0,
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //             Container(
          //               width: 80.0,
          //               // height: 25.0,
          //               alignment: Alignment.bottomCenter,
          //               child: Text(
          //                 item['title'],
          //                 style: black10MediumTextStyle,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ),
      ],
    );
  }

  todaysOfferBanner() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset('assets/todays-offer-banner.png'),
        ),
      ),
    );
  }

  bestOffers() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Best offers',
            style: black16BoldTextStyle,
          ),
          FutureBuilder(
            future: ApiProvider.getMethod('/api/getoffer'),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                print(snapshot.data.toString());
                final data = snapshot.data['getoffer'];
                print(data.length);
                return ColumnBuilder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final offerItem = data[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: fixPadding * 2.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ServiceProviderList(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: whiteColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                spreadRadius: 1.0,
                                color: blackColor.withOpacity(0.25),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10.0)),
                                child: Image.network(
                                  'https://brijesh-patel.herokuapp.com/upload/image/' +
                                      offerItem['subcategory']['image']
                                          .toString(),
                                  width: double.infinity,
                                  height: 225.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(fixPadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      offerItem['subcategory']['name'],
                                      style: black12MediumTextStyle,
                                    ),
                                    height5Space,
                                    Text(
                                      'Upto' + offerItem['offer'].toString(),
                                      style: grey12MediumTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitRing(
                      color: primaryColor,
                      size: 40.0,
                      lineWidth: 1.2,
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      'Please Wait..',
                      style: grey14MediumTextStyle,
                    ),
                  ],
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  customerReviews() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            'Customer reviews',
            style: black16BoldTextStyle,
          ),
        ),
        height20Space,
        Container(
          height: 130.0,
          width: double.infinity,
          child: FutureBuilder(
              future: ApiProvider.getMethod('/api/getallreview'),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final reviewList = snapshot.data['getreview'];
                  print(reviewList);
                  return ListView.builder(
                    itemCount: reviewList.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = reviewList[index];
                      return Padding(
                        padding: (index != reviewList.length - 1)
                            ? const EdgeInsets.only(left: fixPadding * 2.0)
                            : const EdgeInsets.symmetric(
                                horizontal: fixPadding * 2.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            padding: EdgeInsets.all(fixPadding),
                            height: double.infinity,
                            width: 245.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFFDCDFD8),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  spreadRadius: 1.0,
                                  color: blackColor.withOpacity(0.25),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "cleaning",
                                  style: black12RegularTextStyle,
                                ),
                                Text(
                                  data['description'] ?? "",
                                  style: black12MediumTextStyle,
                                ),
                                Text(
                                  data['user']['name'] ?? "Anonymus",
                                  style: black14BoldTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SpinKitRing(
                        color: primaryColor,
                        size: 40.0,
                        lineWidth: 1.2,
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        'Please Wait..',
                        style: grey14MediumTextStyle,
                      ),
                    ],
                  );
                }
                return Container();
              }),
          // ListView.builder(
          //   itemCount: reviewList.length,
          //   scrollDirection: Axis.horizontal,
          //   physics: BouncingScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     final item = reviewList[index];
          //     return Padding(
          //       padding: (index != reviewList.length - 1)
          //           ? const EdgeInsets.only(left: fixPadding * 2.0)
          //           : const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 4.0),
          //         child: Container(
          //           padding: EdgeInsets.all(fixPadding),
          //           height: double.infinity,
          //           width: 245.0,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10.0),
          //             color: const Color(0xFFDCDFD8),
          //             boxShadow: [
          //               BoxShadow(
          //                 blurRadius: 4.0,
          //                 spreadRadius: 1.0,
          //                 color: blackColor.withOpacity(0.25),
          //               ),
          //             ],
          //           ),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 item['service'],
          //                 style: black12RegularTextStyle,
          //               ),
          //               Text(
          //                 item['review'],
          //                 style: black12MediumTextStyle,
          //               ),
          //               Text(
          //                 item['name'],
          //                 style: black14BoldTextStyle,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ),
        height20Space,
      ],
    );
  }
}
