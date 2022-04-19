

import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get ru => 'Russian';

  @override
  String get en => 'English';

  @override
  String get uk => 'Ukrainian';

  @override
  String get language => 'Language';

  @override
  String get delete_inf_ab_sup => 'Delete all information about deleted suppliers';

  @override
  String get dark_theme => 'Dark Theme';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get store => 'Store';

  @override
  String get stats => 'Stats';

  @override
  String get settings => 'Settings';

  @override
  String supply(Object count) {
    return intl.Intl.select(
      count,
      {
        '1': 'Supply',
        '2': 'Supplies'
      },
      desc: 'No description provided in @supply'
    );
  }

  @override
  String get menu => 'Menu';

  @override
  String get employees => 'Employees';

  @override
  String get orders => 'Orders';

  @override
  String get date => 'Date';

  @override
  String get group => 'Group';

  @override
  String get day => 'day';

  @override
  String get hour => 'hour';

  @override
  String get month => 'month';

  @override
  String get year => 'year';

  @override
  String grouping(String gr) {
    return intl.Intl.select(
      gr,
      {
        'day': 'day',
        'month': 'month',
        'hour': 'hour',
        'year': 'year',
        'other': '...'
      },
      desc: 'No description provided in @grouping'
    );
  }

  @override
  String grocery(num count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Groceries',
    );
  }

  @override
  String get price => 'Price';

  @override
  String supplier(Object count) {
    return intl.Intl.select(
      count,
      {
        '1': 'Supplier',
        '2': 'Suppliers'
      },
      desc: 'No description provided in @supplier'
    );
  }

  @override
  String get enter_groc => 'enter grocery name...';

  @override
  String measure(String measure) {
    return intl.Intl.select(
      measure,
      {
        'gram': 'kilogram',
        'liter': 'liter',
        'other': 'wrong measure'
      },
      desc: 'No description provided in @measure'
    );
  }

  @override
  String measure_short(String measure) {
    return intl.Intl.select(
      measure,
      {
        'gram': 'kg',
        'liter': 'l',
        'other': 'xxx'
      },
      desc: 'No description provided in @measure_short'
    );
  }

  @override
  String get name => 'Name';

  @override
  String get left => 'Left';

  @override
  String get count => 'Count';

  @override
  String get add => 'Add';

  @override
  String get add_supplier => 'Add supplier';

  @override
  String get contacts => 'Contacts';

  @override
  String get number => 'Number';

  @override
  String get sorting => 'Sorting';

  @override
  String get filtering => 'Filtering';

  @override
  String get by => 'By';

  @override
  String get find => 'Find';

  @override
  String asc(String a) {
    return intl.Intl.select(
      a,
      {
        'asc': 'ascedenting',
        'desc': 'descedenting'
      },
      desc: 'No description provided in @asc'
    );
  }

  @override
  String get dish => 'Dish';

  @override
  String get dish_name => 'Dish name';

  @override
  String get groups => 'Groups';

  @override
  String get prime_cost => 'Prime cost';

  @override
  String get save => 'Save';

  @override
  String get add_group => 'Add group';

  @override
  String get total => 'Total';

  @override
  String get total1 => 'Total';

  @override
  String get choose_image => 'Choose image';

  @override
  String get enter_descr => 'Enter description...';

  @override
  String get no_descr => 'No description...';

  @override
  String get update_role => 'Update role';

  @override
  String get delete => 'Delete';

  @override
  String get roles => 'Roles';

  @override
  String get diary => 'Diary';

  @override
  String get add_role => 'Add role';

  @override
  String get namee => 'First Name';

  @override
  String get surname => 'Last Name';

  @override
  String get birthday => 'Birthday';

  @override
  String get hours_per_month => 'Hours per month';

  @override
  String gen(String g) {
    return intl.Intl.select(
      g,
      {
        'm': 'Mans',
        'f': 'Womans'
      },
      desc: 'No description provided in @gen'
    );
  }

  @override
  String get hours => 'Hours';

  @override
  String get clear => 'Clear';

  @override
  String get has_come => 'Has come';

  @override
  String get from => 'from';

  @override
  String get to => 'to';

  @override
  String get has_gone => 'Has gone';

  @override
  String get waiter => 'Waiter';

  @override
  String get salary_per_hour => 'Salary per hour';

  @override
  String get comment => 'Comment';

  @override
  String get summ => 'Summ';

  @override
  String get pay => 'Pay';

  @override
  String get rest => 'Rest';

  @override
  String get order => 'Order';

  @override
  String get or_rec => 'order received in';

  @override
  String get or_paid => 'order paid at';

  @override
  String get or_list => 'order list';
}
