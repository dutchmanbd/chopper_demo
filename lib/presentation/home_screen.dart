import 'package:chopper_demo/data/post_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/home_data.dart';
import '../data/resource.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostNotifier _postNotifier = PostNotifier();
  // HomeData? _homeData = null;
  // String error = "";
  @override
  void initState() {
    super.initState();
    _postNotifier.getHomeData();
    // _getHomeData();
  }

  // Future _getHomeData() async {
  //   final result = await _postNotifier.getHomeData();
  //   result.fold(
  //     (l) {
  //       _homeData = null;
  //       error = l;
  //       debugPrint(l);
  //     },
  //     (r) => _homeData = r,
  //   );
  //   setState(() {});
  // }

  @override
  void dispose() {
    super.dispose();
    _postNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // _homeData != null
              //     ? Text(
              //         'Size: ${_homeData!.posts.length}, Title: ${_homeData!.post.title}')
              //     : Text(error)
              ChangeNotifierProvider(
                create: ((context) => _postNotifier),
                child: Consumer<PostNotifier>(
                  builder: (context, notifier, child) {
                    if (notifier.resource == Resource.initial) {
                      return const Text("Initial");
                    } else if (notifier.resource == Resource.loading) {
                      return const CircularProgressIndicator();
                    } else {
                      return notifier.homeData.fold(
                        (error) => Text(error),
                        (homeData) => Text(
                            'Size: ${homeData.posts.length}, Title: ${homeData.post.title}'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
