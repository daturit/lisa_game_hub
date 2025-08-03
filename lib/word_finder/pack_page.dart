import 'package:flutter/material.dart';

import 'data_helper.dart';
import 'helper.dart';
import 'main_page.dart';

class PackPage extends StatefulWidget {
  const PackPage({Key? key}) : super(key: key);

  @override
  State<PackPage> createState() => _PackPageState();
}

class _PackPageState extends State<PackPage> {
  late List<int?> data = [];

  void _goToOnePack(int index, int level) {
    if (!_checkLock(index)) {
      return;
    }
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainPage(level, totalCategory[index], index)))
        .then((value) => {_getDataLocal(), setState(() {})});
  }

  void _getDataLocal() async {
    final List<int?> data1 = [];
    int count = 0;
    // get index of package
    for (int i = 0; i < totalCategory.length; i++) {
      count = count + totalCategory[i].length;
      int? value = await Helper.getData("$count");
      print("test data $value");
      data1.add(value ?? 0);
    }

    setState(() {
      data = data1;
    });
  }

  bool _checkLock(int index) {
    if (index == 0) {
      return true;
    }

    if (data.length >= index) {
      print("index ${index - 1} value ${data[index - 1]}");
      if (data[index - 1] == 1) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _getDataLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: const Text("Select A Pack",
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.normal)),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F2027), // Màu bắt đầu (xanh đen đậm)
                  Color(0xFF2C5364), // Màu kết thúc (xanh navy đậm)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListView.builder(
              itemCount: totalCategory.length,
              itemBuilder: (context, index) {
                return SizedBox(
                    height: 100,
                    child: InkWell(
                      onTap: () {
                        _goToOnePack(index, 1);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images/${totalCategoryName[index]}.png'),
                                        fit: BoxFit.fill,
                                        opacity:
                                            _checkLock(index) ? 1.0 : 0.5)),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    totalCategoryName[index],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "${totalCategory[index].length.toString()} Puzzles",
                                    style: const TextStyle(
                                        color: Colors.white60,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(
                                  _checkLock(index)
                                      ? Icons.navigate_next
                                      : Icons.lock,
                                  size: 30,
                                  color: Colors.white70)),
                        ],
                      ),
                    ));
              })
        ],
      ),
    );
  }
}
