import 'package:client/menu/menu_states_events.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_treeview/flutter_treeview.dart';

import '../../bloc_provider.dart';
import '../../l10nn/app_localizations.dart';
import '../../supplys/filter_sort_drawer/filter_sort_drawer.dart';
import '../menu_bloc.dart';


class FilterSortMenuDrawer extends StatefulWidget {
  const FilterSortMenuDrawer({Key? key}) : super(key: key);

  @override
  State<FilterSortMenuDrawer> createState() => _FilterSortMenuDrawerState();
}

class _FilterSortMenuDrawerState extends State<FilterSortMenuDrawer> with TickerProviderStateMixin {
  late AppLocalizations l;
  
  @override
  Widget build(BuildContext context) {
    l = AppLocalizations.of(context)!;
    var bloc = BlocProvider.of<MenuBloc>(context);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              controller: ScrollController(),
              children: [
                ListTile(title: Text(l.sorting)),
                ListTile(  // выбор того по чем сортируем
                  leading: Radio<String>(
                    value: 'dish_name',
                    groupValue: bloc.fsMenu!.sortColumn,
                    onChanged: (newVal) {
                      setState(() {
                        bloc.fsMenu!.sortColumn = newVal!;
                      });
                    }
                  ),
                  title: Text('${l.by} ${l.name}')
                ),
                ListTile(  // выбор того по чем сортируем
                  leading: Radio<String>(
                    value: 'dish_price',
                    groupValue: bloc.fsMenu!.sortColumn,
                    onChanged: (newVal) {
                      setState(() {
                        bloc.fsMenu!.sortColumn = newVal!;
                      });
                    }
                  ),
                  title: Text(l.by + " " + l.price.toLowerCase())
                ),
                ListTile(title: AscDescDropdown(  // выбор направления
                  value: bloc.fsMenu!.asc,
                  onChanged: (newVal) {
                    setState(() {
                      bloc.fsMenu!.asc =  newVal!;
                    });
                  }
                )),
                ListTile(title: Text(l.filtering)), 
                ListTile(           // поиск по названию (работает сразу)
                  title: TextFormField(
                    // controller: TextEditingController(text: bloc.fsMenu!.like),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: l.dish_name
                    ),
                    onChanged: (newVal) {
                      bloc.inEvent.add(MenuFilterDishNameEvent(newVal));
                    },
                  )
                ),
                ListTile(title: Row(              // цена от до
                  children: [
                    Text(l.price + ": "),
                    Expanded(child: TextFormField( // вынести в отдельный класс с стилями нужными
                      textAlign: TextAlign.center,
                      controller: TextEditingController(text: bloc.fsMenu!.priceFrom.toString()),
                      onChanged: (newVal) {
                        // bloc.inEvent.add(SupplyFromPriceChangedEvent(newVal));
                        bloc.fsMenu!.priceFrom = double.parse(newVal.isEmpty ? '0.0' : newVal);
                      }
                    )),
                    const Text("-"),
                    Expanded(child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: TextEditingController(text: bloc.fsMenu!.priceTo.toString()),
                      onChanged: (newVal) {
                        // bloc.inEvent.add(SupplyToPriceChangedEvent(newVal));
                        bloc.fsMenu!.priceTo = double.parse(newVal.isEmpty ? '0.0' : newVal);
                      },
                    )),
                  ],
                )),
                ListTile(
                  title: InkWell(
                    onTap: () { 
                      setState(() {
                        bloc.showGrocList = !bloc.showGrocList;
                      });
                    },
                    child: Row(
                      children: [
                        Text(l.grocery(2)),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10), 
                          child: Center(
                            child: (!bloc.showGrocList) ? const Icon(Icons.arrow_drop_down) : const RotatedBox(
                              quarterTurns: 2,
                              child: Icon(Icons.arrow_drop_down)
                            )
                          )
                        )
                      ]
                    ),
                  )
                ),
                Visibility(
                  visible: bloc.showGrocList,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < bloc.groceries.length; i++) ListTile(
                        title: Text(bloc.groceries[i].grocName),
                        leading: Checkbox(
                          value: bloc.groceries[i].selected,
                          onChanged: (newVal) {
                            bloc.inEvent.add(MenuFiterGroceriesChangedEvent(i));
                          }
                        )
                      )
                    ],
                  )
                ),
                ListTile(
                  title: InkWell(
                    onTap: () { 
                      setState(() {
                        bloc.showGroupList = !bloc.showGroupList;
                      });
                    },
                    child: Row(
                      children: [
                        Text(l.groups),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10), 
                          child: Center(
                            child: (!bloc.showGroupList) ? const Icon(Icons.arrow_drop_down) : const RotatedBox(
                              quarterTurns: 2, 
                              child: Icon(Icons.arrow_drop_down)
                            )
                          )
                        )
                      ]
                    ),
                  )
                ),
                Visibility(
                  visible: bloc.showGroupList,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < bloc.groups!.length; i++) ListTile(
                        title: Text(bloc.groups![i].groupName),
                        leading: Checkbox(
                          value: bloc.groups![i].selected,
                          onChanged: (newVal) {
                            bloc.inEvent.add(MenuFiterGroupsChangedEvent(i));
                          }
                        )
                      )
                    ],
                  )
                ),
              ]
            ),
          ),
          
          Expanded(
            flex: 0,
            child: ElevatedButton(
              child: Text(l.find),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: () {
                Navigator.pop(context);
                bloc.inEvent.add(MenuLoadEvent());
              }
            )
          )
        ]
      )
    );
  }
}
