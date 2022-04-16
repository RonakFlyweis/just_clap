import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:urban_home/web_services/api_provider.dart';
import '../../constant/constant.dart';
import '../../web_services/urls.dart';
import '../screens.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Favorite',
          style: black16BoldTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
          future: ApiProvider.getMethod('/api/getfav'),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final favList = snapshot.data["getfav"];
              return snapshot.data["getfav"].length == 0
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 46.0,
                      color: greyColor,
                    ),
                    heightSpace,
                    Text(
                      'No item in favorite',
                      style: grey16BoldTextStyle,
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: favList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = favList[index];
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: fixPadding * 2.0,
                          bottom: (index == favList.length - 1)
                              ? fixPadding * 2.0
                              : 0.0,
                        ),
                        child: IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            loadingRing(context);
                            await ApiProvider.favPostMethod(
                                '/api/add-favroite/${data["_id"]}');
                            Navigator.pop(context);
                            setState(() {
                              // favoriteList.removeAt(index);
                            });

                            // Then show a snackbar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text(
                                  'Service provider removed from favorite'),
                            ));
                          },
                        ),
                      ),
                    ],
                    child: Padding(
                      padding: (index != favList.length - 1)
                          ? const EdgeInsets.fromLTRB(fixPadding * 2.0,
                          fixPadding * 2.0, fixPadding * 2.0, 0.0)
                          : EdgeInsets.all(fixPadding * 2.0),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     duration: Duration(milliseconds: 600),
                          //     type: PageTransitionType.fade,
                          //     child: ServiceProvider(
                          //       heroTag: item['heroTag'],
                          //       image: item['image'],
                          //     ),
                          //   ),
                          // );
                        },
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: EdgeInsets.all(fixPadding),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100.0,
                                height: 100.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Hero(
                                    tag: 'provider_1',
                                    child: Image.network(
                                      imageBaseUrl + data['image'],
                                      width: 100.0,
                                      height: 100.0,
                                    ),
                                  ),
                                ),
                              ),
                              widthSpace,
                              Container(
                                height: 100.0,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['name'],
                                            style:
                                            black14RegularTextStyle,
                                          ),
                                          height5Space,
                                          Text(
                                            data["includeservices"][0]
                                            ["title"],
                                            style: grey12BoldTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width -
                                          fixPadding * 7.0 -
                                          100.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Jobs',
                                                style:
                                                grey12BoldTextStyle,
                                              ),
                                              height5Space,
                                              Text(
                                                data['jobs'],
                                                style:
                                                black14BoldTextStyle,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Rate',
                                                style:
                                                grey12BoldTextStyle,
                                              ),
                                              height5Space,
                                              Text(
                                                '\$${data['rate']}/hr',
                                                style:
                                                black14BoldTextStyle,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Rating',
                                                style:
                                                grey12BoldTextStyle,
                                              ),
                                              height5Space,
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Icon(
                                                    Icons.star_rate,
                                                    size: 20.0,
                                                    color: orangeColor,
                                                  ),
                                                  Text(
                                                    data['rating'],
                                                    style:
                                                    black14BoldTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}

// class Favorite extends StatefulWidget {
//   @override
//   _FavoriteState createState() => _FavoriteState();
// }
//
// class _FavoriteState extends State<Favorite> {
//   final favoriteList = [
//     {
//       'name': 'Apollonia Anderson',
//       'image': 'assets/provider/provider_1.jpg',
//       'service': 'Cleaner',
//       'jobs': '197',
//       'rate': '15',
//       'rating': '4.9',
//       'heroTag': 'provider_1'
//     },
//     {
//       'name': 'Beatriz Warner',
//       'image': 'assets/provider/provider_2.jpg',
//       'service': 'Cleaner',
//       'jobs': '205',
//       'rate': '12',
//       'rating': '4.6',
//       'heroTag': 'provider_2'
//     },
//     {
//       'name': 'Shira Williamson',
//       'image': 'assets/provider/provider_3.jpg',
//       'service': 'Cleaner',
//       'jobs': '158',
//       'rate': '10',
//       'rating': '4.5',
//       'heroTag': 'provider_3'
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: scaffoldBgColor,
//       appBar: AppBar(
//         backgroundColor: whiteColor,
//         elevation: 1.0,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(
//           'Favorite',
//           style: black16BoldTextStyle,
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: blackColor,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: (favoriteList.isEmpty)
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.favorite_border,
//                     size: 46.0,
//                     color: greyColor,
//                   ),
//                   heightSpace,
//                   Text(
//                     'No item in favorite',
//                     style: grey16BoldTextStyle,
//                   ),
//                 ],
//               ),
//             )
//           : ListView.builder(
//               itemCount: favoriteList.length,
//               physics: BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 final item = favoriteList[index];
//                 return Slidable(
//                   actionPane: SlidableDrawerActionPane(),
//                   actionExtentRatio: 0.25,
//                   secondaryActions: <Widget>[
//                     Container(
//                       margin: EdgeInsets.only(
//                         top: fixPadding * 2.0,
//                         bottom: (index == favoriteList.length - 1)
//                             ? fixPadding * 2.0
//                             : 0.0,
//                       ),
//                       child: IconSlideAction(
//                         caption: 'Delete',
//                         color: Colors.red,
//                         icon: Icons.delete,
//                         onTap: () {
//                           setState(() {
//                             favoriteList.removeAt(index);
//                           });
//
//                           // Then show a snackbar.
//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             content:
//                                 Text('Service provider removed from favorite'),
//                           ));
//                         },
//                       ),
//                     ),
//                   ],
//                   child: Padding(
//                     padding: (index != favoriteList.length - 1)
//                         ? const EdgeInsets.fromLTRB(fixPadding * 2.0,
//                             fixPadding * 2.0, fixPadding * 2.0, 0.0)
//                         : EdgeInsets.all(fixPadding * 2.0),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             duration: Duration(milliseconds: 600),
//                             type: PageTransitionType.fade,
//                             child: ServiceProvider(
//                               heroTag: item['heroTag'],
//                               image: item['image'],
//                             ),
//                           ),
//                         );
//                       },
//                       borderRadius: BorderRadius.circular(10.0),
//                       child: Container(
//                         padding: EdgeInsets.all(fixPadding),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: whiteColor,
//                           boxShadow: [
//                             BoxShadow(
//                               blurRadius: 4.0,
//                               spreadRadius: 1.0,
//                               color: blackColor.withOpacity(0.25),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(10.0),
//                               child: Hero(
//                                 tag: item['heroTag'],
//                                 child: Image.asset(
//                                   item['image'],
//                                   width: 100.0,
//                                   height: 100.0,
//                                 ),
//                               ),
//                             ),
//                             widthSpace,
//                             Container(
//                               height: 100.0,
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           item['name'],
//                                           style: black14RegularTextStyle,
//                                         ),
//                                         height5Space,
//                                         Text(
//                                           item['service'],
//                                           style: grey12BoldTextStyle,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     width: width - fixPadding * 7.0 - 100.0,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               'Jobs',
//                                               style: grey12BoldTextStyle,
//                                             ),
//                                             height5Space,
//                                             Text(
//                                               item['jobs'],
//                                               style: black14BoldTextStyle,
//                                             ),
//                                           ],
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               'Rate',
//                                               style: grey12BoldTextStyle,
//                                             ),
//                                             height5Space,
//                                             Text(
//                                               '\$${item['jobs']}/hr',
//                                               style: black14BoldTextStyle,
//                                             ),
//                                           ],
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               'Rating',
//                                               style: grey12BoldTextStyle,
//                                             ),
//                                             height5Space,
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 Icon(
//                                                   Icons.star_rate,
//                                                   size: 20.0,
//                                                   color: orangeColor,
//                                                 ),
//                                                 Text(
//                                                   item['rating'],
//                                                   style: black14BoldTextStyle,
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
