import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/about_us_card.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with SingleTickerProviderStateMixin {
  final panelController = PanelController();
  // final tabController = TabController(length: 3, vsync: this);
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void backButton() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        backButton();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Efficacy'),
        ),
        body: SlidingUpPanel(
          controller: panelController,
          minHeight: MediaQuery.of(context).size.height - 250,
          maxHeight: MediaQuery.of(context).size.height,
          defaultPanelState: PanelState.CLOSED,
          body: Image.asset(
            'assets/efficacy_cover.png',
            // height: 300,
            fit: BoxFit.fitWidth,
            alignment: AlignmentDirectional.topCenter,
          ),
          panelBuilder: (controller) => PanelWidget(
            controller: controller,
            panelController: panelController,
            tabController: tabController,
          ),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final TabController tabController;

  const PanelWidget(
      {Key? key,
      required this.controller,
      required this.panelController,
      required this.tabController})
      : super(key: key);

  void togglePanel() {
    panelController.isPanelOpen
        ? panelController.close()
        : panelController.open();
  }

  Widget buildDragHandler() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Container(
            width: 75,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      controller: controller,
      children: <Widget>[
        const SizedBox(height: 8),
        buildDragHandler(),
        const SizedBox(height: 20),
        // const Text(
        //   'About Us',
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20,
        //     color: Color(0xFF213F8D),
        //   ),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        Container(
          decoration: null,
          child: TabBar(
            controller: tabController,
            labelColor: const Color(0xFF05354C),
            unselectedLabelColor: const Color(0xFFA4A2A7),
            tabs: const [
              Tab(text: 'Mentors'),
              Tab(text: 'Developers'),
              Tab(text: 'Designers'),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: TabBarView(
            controller: tabController,
            children: [
              ListView(
                // controller: controller,
                children: const <Widget>[
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                ],
              ),
              ListView(
                children: const <Widget>[
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                ],
              ),
              ListView(
                children: const <Widget>[
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    developerTag: 'Flutter Developer',
                    branch: 'CSE',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
