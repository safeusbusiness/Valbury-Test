import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:valbury/app/data/commons/helpers/base_controller_helper.dart';

class InitController extends BaseControllerHelper {

  var persistenTabController = PersistentTabController(
      initialIndex: 0
  );

  @override
  void initializeData() {
  }

  void onItemSelected(int index) {}


}
