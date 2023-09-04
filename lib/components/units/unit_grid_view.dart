import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ncue_aiot/components/units/unit.dart';

class UnitGridView extends StatefulWidget {
  const UnitGridView({super.key});

  @override
  State<UnitGridView> createState() => UnitGridViewState();
}

class UnitGridViewState extends State<UnitGridView> {
  final deviceData = Hive.box('local_storage');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (deviceData.get('Devices') == null) {
      return const Center(
        child: Text("No Devices here"),
      );
    } else {
      List data = deviceData.get('Devices');
      return Expanded(
          child: GridView.builder(
        itemCount: data.length,
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / 1.2),
        itemBuilder: (BuildContext context, int index) {
          return Unit(inputData: data[index]);
        },
      ));
    }
  }
}
