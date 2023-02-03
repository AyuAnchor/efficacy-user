import 'package:cached_network_image/cached_network_image.dart';
import 'package:efficacy_user/models/all_events.dart';
import 'package:efficacy_user/provider/event_provider.dart';
import 'package:efficacy_user/utils/base_viewmodel.dart';
import 'package:efficacy_user/utils/enums.dart';
import 'package:efficacy_user/widgets/divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_user/themes/efficacy_usercolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:efficacy_user/pages/club_details.dart';
import 'package:efficacy_user/widgets/details_widget.dart';
import 'package:efficacy_user/widgets/detail_card.dart';
import 'package:efficacy_user/widgets/moderator.dart';
import 'package:efficacy_user/widgets/add_to_calender.dart';
import 'package:efficacy_user/widgets/like_widget.dart';
import 'package:efficacy_user/widgets/share_widget.dart';
import 'package:efficacy_user/widgets/follow_widget.dart';
import 'package:efficacy_user/widgets/facebook_widget.dart';
import 'package:efficacy_user/widgets/gform_widget.dart';

class EventScreen extends StatefulWidget {
  final String? eventId;
  static const route = '/event_screen';
  const EventScreen({
    Key? key,
    this.eventId,
  }) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // late EventProvider engine;
  // bool isInit = true;
  // bool isLoading = false;

  int _selectedIndex = 0;
  BorderRadiusGeometry sheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  // final Map<String, dynamic> json = {
  //   "eventID": "yHZG2GhfYzQgS5MwDnzP",
  //   "clubID": "94Pkmpbj0qzBCkiSQ6Yr",
  //   "clubName": "Illuminits",
  //   "eventName": "Illuminits Event",
  //   "description": "notification",
  //   "longDescription":
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur sodales ligula in libero. Sed dignissim lacinia nunc.",
  //   "duration": "Temporary",
  //   "startTime": "2022-02-18T18:30:00.000Z",
  //   "endTime": "2022-03-18T18:30:00.000Z",
  //   "fbPostURL": "fb",
  //   "googleFormURL": "gf",
  //   "posterURL":
  //       "https://logos-world.net/wp-content/uploads/2020/06/ETSU-Buccaneers-emblem.jpg",
  //   "clubLogoURL":
  //       'https://res.cloudinary.com/devncode/image/upload/v1575267757/production_devncode/community/1575267756355.jpg',
  //   "venue": "Teams",
  //   "likeCount": 0,
  //   "usersWhoLiked": [],
  //   "contact": [
  //     {
  //       "name": "Soumya Ranjan Mohapatro",
  //       "email": "moderator@gmail.com",
  //       "phNumber": "9876543210",
  //       "position": "Moderator"
  //     }
  //   ]
  // };
  //
  // @override
  // void initState() {
  //   engine = Provider.of<EventProvider>(context, listen: false);
  //   engine.fetchEvent(context: context, eventId: widget.eventId ?? '');
  //   // engine = Provider.of<EventProvider>(context);
  //   // getEvent();
  //   super.initState();
  //   // engineVar = EventModel.fromJson(json);
  // }

  late AllEvent event;

  // void getEvent() async {
  //   if (isInit) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     engineVar = await engine.fetchEvent(widget.eventId!);
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  //   print(engineVar);
  //   isInit = false;
  // }

  @override
  Widget build(BuildContext context) {
    Size devicesize = MediaQuery.of(context).size;
    // engineVar = Provider.of<EventProvider>(
    //   context,
    // ).event;
    return BaseView<EventProvider>(
      onModelReady: (model) async {
        await model.fetchEvent(eventId: widget.eventId ?? '', context: context);
        event = model.event;
      },
      builder: (_, model, __) => Scaffold(
        body: model.state == ViewState.busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : event.name == null
                ? const Center(child: Text('Something went wrong'))
                : SlidingUpPanel(
                    maxHeight: devicesize.height,
                    minHeight: devicesize.height * 0.60,
                    panelBuilder: (sc) => Padding(
                      padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // shrinkWrap: true,
                        controller: sc,
                        children: [
                          const PanelDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ClubDetail.route);
                                    },
                                    child: SizedBox(
                                        width: 44,
                                        height: 44,
                                        child: CachedNetworkImage(
                                            height: 200,
                                            imageUrl: event.posterUrl ?? '',
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, _) =>
                                                const Center(
                                                    child: Icon(Icons.error)),
                                            progressIndicatorBuilder: (context,
                                                    url, progress) =>
                                                Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            value: progress
                                                                .progress)))),

                                    // Image.network(
                                    //   event.posterUrl ?? '',
                                    //   fit: BoxFit.cover,
                                    // ),
                                    // ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Organized by",
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              color: const Color(0xff191C1D)
                                                  .withOpacity(0.7),
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          event.name ?? '',
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              color: const Color(0xff191C1D)
                                                  .withOpacity(0.7),
                                              fontSize: 8.0,
                                              fontWeight: FontWeight.w300,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const Follow()
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  event.name ?? '',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: const Color(0xff191C1D)
                                          .withOpacity(0.7),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 61,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Like(
                                          eventId: widget.eventId ?? '',
                                          isLiked: false),
                                      const Share(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          DetailCard(
                              text1: DateFormat.yMd()
                                  .format(event.startTime ?? DateTime(0))
                                  .toString(),
                              text2: DateFormat.jms()
                                      .format(event.startTime ?? DateTime(0))
                                      .toString() +
                                  ' to ' +
                                  DateFormat.jms()
                                      .format(event.endTime ?? DateTime(0))
                                      .toString(),
                              icon: Icons.calendar_today_outlined),
                          // DetailCard(
                          //     text1: event.startTime
                          //         .toString()
                          //         .split(' ')[0],
                          //     text2:
                          //         '${event.startTime.toString().split(' ')[1]} to ${event.endTime.toString().split(' ')[1]}',
                          //     icon: Icons.calendar_today_outlined),
                          DetailCard(
                              text1: event.venue!,
                              text2: "On Campus",
                              icon: Icons.location_on_outlined),

                          Wrap(children: const [AddToCalender()]),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Event Details",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color:
                                      const Color(0xff191C1D).withOpacity(0.7),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          DetailsWidget(text: event.longDescription!),
                          Container(
                            margin: const EdgeInsets.only(top: 29),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [Gform(), Facebook()],
                            ),
                          ),
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: List.generate(
                              event.contacts?.length ?? 0,
                              (index) => Column(
                                children: [
                                  Moderator(
                                    text1: event.contacts?[index].name ?? '',
                                    text2: event.contacts?[index].email ?? '',
                                    icon: Icons.person,
                                  ),
                                  DetailCard(
                                    text1: event.contacts?[index].phone ?? '',
                                    icon: Icons.call_outlined,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12, bottom: 20),
                            child: Text(
                              "published on 12 March,2021",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: const Color(0xff191C1D)
                                        .withOpacity(0.7),
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.5,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    body: SafeArea(
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                              height: 250,
                              width: devicesize.width,
                              imageUrl: event.posterUrl ?? '',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, _) =>
                                  const Center(child: Icon(Icons.error)),
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                          value: progress.progress))),

                          // Container(
                          //   height: 250,
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       image:

                          //           // NetworkImage(event.posterUrl ?? ''),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            left: 20.0,
                            top: 25.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color(0xffDFE5E7).withOpacity(0.2),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    borderRadius: sheetRadius,
                  ),
      ),
    );
  }
}
