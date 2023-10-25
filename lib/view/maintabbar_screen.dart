import 'package:brieftest/view/post_screen.dart';
import 'package:brieftest/viewmodel/post_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:brieftest/viewmodel/tabbar_viewmodel.dart';
import 'package:brieftest/viewmodel/deteksi_viewmodel.dart';
import 'package:brieftest/view/webview_screen.dart';
import 'package:brieftest/view/deteksi_screen.dart';
import 'package:brieftest/view/about_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

class MainTabbar extends StatefulWidget {
  const MainTabbar({super.key});

  @override
  State<MainTabbar> createState() => _MainTabbarState();
}

class _MainTabbarState extends State<MainTabbar>
    with SingleTickerProviderStateMixin {
  var isDialOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    context.read<TabbarViewModel>().controllerTabbar =
        TabController(length: 2, vsync: this);

    context.read<PostViewModel>().getAllPost();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabbarviewmodel = context.read<TabbarViewModel>();
    final tfliteProvider = context.read<DeteksiViewModel>();

    tabbarviewmodel.controllerTabbar.addListener(() {
      tabbarviewmodel.indexTabbar();
    });

    return WillPopScope(
      onWillPop: () async {
        if (tabbarviewmodel.index != 0) {
          tabbarviewmodel.controllerTabbar.index = 0;
        } else {
          await _deleteCacheDir();
          await _deleteAppDir();
          return true;
        }
        return false;
      },
      child: Consumer<TabbarViewModel>(
        builder: (context, value, _) {
          return Scaffold(
            body: NestedScrollView(
              floatHeaderSlivers: true,
              physics: NeverScrollableScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                    title: Text("Brief Test"),
                    pinned: true,
                    floating: true,
                    actions: [
                      PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 1,
                              child: Text("About"),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text("Logout"),
                            ),
                          ];
                        },
                        onSelected: (value) async {
                          if (value == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutScreen(),
                              ),
                            );
                          } else if (value == 2) {
                            signOutUser();
                            await FirebaseAuth.instance.signOut();
                          }
                        },
                      ),
                    ],
                    bottom: TabBar(
                      controller: tabbarviewmodel.controllerTabbar,
                      tabs: tabbarviewmodel.myTabs,
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: tabbarviewmodel.controllerTabbar,
                children: [PostScreen(), DeteksiScreen()],
              ),
            ),
            floatingActionButton: tabbarviewmodel.index == 1
                ? SpeedDial(
                    spacing: 8,
                    overlayColor: Colors.black,
                    overlayOpacity: 0.5,
                    childMargin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    elevation: 0,
                    icon: Icons.keyboard_arrow_up_rounded,
                    activeIcon: Icons.close,
                    children: [
                      SpeedDialChild(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        elevation: 0,
                        labelShadow: [
                          const BoxShadow(color: Colors.transparent)
                        ],
                        label: "galeri",
                        shape: const CircleBorder(),
                        child: const Icon(Icons.photo),
                        onTap: () =>
                            tfliteProvider.btnAction(ImageSource.gallery),
                      ),
                      SpeedDialChild(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        labelShadow: [
                          const BoxShadow(color: Colors.transparent)
                        ],
                        elevation: 0,
                        label: "kamera",
                        shape: const CircleBorder(),
                        child: const Icon(Icons.camera_alt),
                        onTap: () =>
                            tfliteProvider.btnAction(ImageSource.camera),
                      ),
                    ],
                  )
                : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            bottomNavigationBar: tabbarviewmodel.index == 1
                ? BottomAppBar(
                    child: Consumer<DeteksiViewModel>(
                      builder: (context, value, _) => hasil(tfliteProvider),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget hasil(DeteksiViewModel tfliteProvider) {
    final isLoading = tfliteProvider.state == DeteksiState.loading;
    if (isLoading) {
      return Center(
          child: resultText().redacted(context: context, redact: true));
    } else if (tfliteProvider.result.isNotEmpty) {
      return Center(
        child: TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WebviewScreen(title: tfliteProvider.predLabel!),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${tfliteProvider.predLabel}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(width: 3),
              Icon(
                Icons.open_in_new_rounded,
                size: 20,
                color: Colors.blue[800],
              )
            ],
          ),
        ),
      );
    } else {
      return resultText();
    }
  }

  Future<void> _deleteCacheDir() async {
    var tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    var appDocDir = await getApplicationDocumentsDirectory();

    if (appDocDir.existsSync()) {
      appDocDir.deleteSync(recursive: true);
    }
  }

  Widget resultText() {
    return Center(
      child: Text(
        "Result here",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  void signOutUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }
}
