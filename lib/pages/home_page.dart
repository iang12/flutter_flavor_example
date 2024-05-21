import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_example_config/flavors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<List<String>> fetchMovies() {
    return FirebaseFirestore.instance.collection('movies').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => doc.data()['title'].toString())
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flavor Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Base URL: ${Flavor.apiBaseUrl}"),
            Text("Flavor: ${Flavor.flavorType}"),
            const SizedBox(height: 20),
            const Text("Movies List"),
            StreamBuilder(
              stream: fetchMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (_, index) {
                      var movie = snapshot.data![index];
                      return Text(
                        '${index + 1} - $movie',
                        textAlign: TextAlign.center,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Text('Something went wrong!');
                } else {
                  return const Text('Something went wrong!');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
