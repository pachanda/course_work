import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/models.dart';
import '../../services/repo.dart';

class GrocPicker extends StatefulWidget {
  GrocPicker({Key? key, this.groceries = const [], this.grocCurState = const []}) : super(key: key);

  List<Grocery> groceries;
  List<DishGroc> grocCurState;

  @override
  State<GrocPicker> createState() => _GrocPickerState();
}

class _GrocPickerState extends State<GrocPicker> {

  Future<List<Grocery>> _grocs = Future.value([]);
  List<DishGroc> picked = []; // дублирование. нужно было все что ниже делать не через picker. а через widget.curGrocState
  List<Grocery> tempGrocs = [];
  TextEditingController grocNameCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    _grocs = getGrocs();
    picked = widget.grocCurState; // вот оно
    
  }

  Future<List<Grocery>> getGrocs() async {
    return await Provider.of<Repo>(context, listen: false).getGroceries(suppliedOnly: true);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListView(
            children: [
              for (int i = 0; i < picked.length; i++) Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5.0))
                    ),
                    height: 20,
                    width: 20,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          picked.removeAt(i);
                        });
                      },
                      child: const Icon(Icons.close, size: 15)
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(child: Text(picked[i].grocName))
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: TextEditingController(text: picked[i].grocCount.toString()),
                        decoration: const InputDecoration(
                          labelText: "count",

                        ),
                        onChanged: (newVal) {
                          picked[i].grocCount = double.parse(newVal.isEmpty ? '0.0' : newVal);
                        },
                      ),
                    )
                  )
                ],
              )
            ],
          )
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "name",
                    border: OutlineInputBorder()
                  ),
                  controller: grocNameCont,
                  onChanged: (newVal) {
                    setState(() { /* там, ниже... */ });
                  }
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Grocery>>(
                  future: _grocs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      widget.groceries = snapshot.data!;
                      // вот тут
                      tempGrocs = snapshot.data!.where((element) => element.grocName.contains(grocNameCont.text)).toList();
                      return SingleChildScrollView(
                        controller: ScrollController(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (int i = 0; i < tempGrocs.length; i++) InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text(tempGrocs[i].grocName)
                              ),
                              onTap: () {
                                setState(() { 
                                  if (picked.where((element) => element.grocId == tempGrocs[i].grocId).toList().isEmpty) {
                                    picked.add(DishGroc.initial(tempGrocs[i].grocId, tempGrocs[i].grocName));
                                  }
                                });
                              }
                            )
                          ],
                        )
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }
                ),
              ),
            ],
          )
        ),
      ]
    );
  }
}