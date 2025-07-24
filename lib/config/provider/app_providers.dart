import 'package:muitsu_arked/modules/battle_field_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

//REGISTER PROVIDERS HERE
class AppProviders {
  static List<SingleChildWidget> get providers => _providers;
  //Register provider here
  static final List<SingleChildWidget> _providers = [
    ChangeNotifierProvider(create: ((context) => BattleFieldProvider()))
  ];
}
