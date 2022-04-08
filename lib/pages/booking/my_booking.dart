import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../constant/constant.dart';
import '../screens.dart';

class MyBooking extends StatefulWidget {
  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  final upcomingBookingList = [
    {
      'name': 'Apollonia Anderson',
      'date': '15 March 2021',
      'time': '10:00 AM',
      'type': 'Cleaner',
    },
    {
      'name': 'Linnea Hayden',
      'date': '21 March 2021',
      'time': '12:00 PM',
      'type': 'Cleaner',
    },
    {
      'name': 'John Smith',
      'date': '25 March 2021',
      'time': '04:00 PM',
      'type': 'Plumber',
    }
  ];

  final pastBookingList = [
    {
      'name': 'Amara Smith',
      'date': '18 March 2021',
      'time': '12:00 PM',
      'type': 'Cleaner',
    },
    {
      'name': 'Shira Williamson',
      'date': '22 March 2021',
      'time': '08:00 AM',
      'type': 'Cleaner',
    },
    {
      'name': 'John Smith',
      'date': '25 March 2021',
      'time': '03:00 PM',
      'type': 'Electrician',
    },
    {
      'name': 'Faina Maxwell',
      'date': '2 April 2021',
      'time': '05:00 PM',
      'type': 'Beautician',
    }
  ];

  final cancelledBookingList = [
    {
      'name': 'Amara Smith',
      'date': '14 March 2021',
      'time': '04:00 PM',
      'type': 'Cleaner',
    },
    {
      'name': 'Ellison Perry',
      'date': '17 March 2021',
      'time': '09:00 AM',
      'type': 'Cleaner',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: whiteColor,
          title: Text(
            'Bookings',
            style: appBarTextStyle,
          ),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
            tabs: [
              Tab(
                child: tabItem('Upcoming', upcomingBookingList.length),
              ),
              Tab(
                child: tabItem('Past', pastBookingList.length),
              ),
              Tab(
                child: tabItem('Cancelled', cancelledBookingList.length),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            upcomingBookings(),
            pastBookings(),
            cancelledBookings(),
          ],
        ),
      ),
    );
  }

  tabItem(text, number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: black12MediumTextStyle,
        ),
        SizedBox(width: 4.0),
        Container(
          width: 20.0,
          height: 20.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: primaryColor,
          ),
          child: Text(
            '$number',
            style: white12MediumTextStyle,
          ),
        ),
      ],
    );
  }

  upcomingBookings() {
    return ListView.builder(
      itemCount: upcomingBookingList.length,
      itemBuilder: (context, index) {
        final item = upcomingBookingList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: UpcomingBooking(),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(width: 1.0, color: greenColor),
                        color: greenColor.withOpacity(0.20),
                      ),
                      child: Text(
                        item['date'],
                        textAlign: TextAlign.center,
                        style: green14MediumTextStyle,
                      ),
                    ),
                    widthSpace,
                    Container(
                      height: 80.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['time'],
                            style: black16BoldTextStyle,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            item['name'],
                            style: black14MediumTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            item['type'],
                            style: primaryColor14RegularTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              divider(),
            ],
          ),
        );
      },
    );
  }

  pastBookings() {
    return ListView.builder(
      itemCount: pastBookingList.length,
      itemBuilder: (context, index) {
        final item = pastBookingList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: PastBooking(),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(width: 1.0, color: primaryColor),
                        color: primaryColor.withOpacity(0.20),
                      ),
                      child: Text(
                        item['date'],
                        textAlign: TextAlign.center,
                        style: primaryColor14MediumTextStyle,
                      ),
                    ),
                    widthSpace,
                    Container(
                      height: 80.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['time'],
                            style: black16BoldTextStyle,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            item['name'],
                            style: black14MediumTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            item['type'],
                            style: primaryColor14RegularTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              divider(),
            ],
          ),
        );
      },
    );
  }

  cancelledBookings() {
    return ListView.builder(
      itemCount: cancelledBookingList.length,
      itemBuilder: (context, index) {
        final item = cancelledBookingList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: CancelledBooking(),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(width: 1.0, color: redColor),
                        color: redColor.withOpacity(0.20),
                      ),
                      child: Text(
                        item['date'],
                        textAlign: TextAlign.center,
                        style: primary14MediumTextStyle,
                      ),
                    ),
                    widthSpace,
                    Container(
                      height: 80.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['time'],
                            style: black16BoldTextStyle,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            item['name'],
                            style: black14MediumTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            item['type'],
                            style: primaryColor14RegularTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              divider(),
            ],
          ),
        );
      },
    );
  }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: MediaQuery.of(context).size.width - fixPadding * 4.0,
      height: 1.0,
      color: greyColor,
    );
  }
}
