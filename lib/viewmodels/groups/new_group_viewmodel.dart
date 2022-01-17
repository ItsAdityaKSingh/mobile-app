import 'package:mobile_app/enums/view_state.dart';
import 'package:mobile_app/locator.dart';
import 'package:mobile_app/models/failure_model.dart';
import 'package:mobile_app/models/groups.dart';
import 'package:mobile_app/services/API/groups_api.dart';
import 'package:mobile_app/viewmodels/base_viewmodel.dart';

class NewGroupViewModel extends BaseModel {
  // ViewState Keys
  final String addGROUP = 'add_group';

  final GroupsApi _groupsApi = locator<GroupsApi>();

  Group? _newGroup;

  Group? get newGroup => _newGroup;

  set newGroup(Group? newGroup) {
    _newGroup = newGroup;
    notifyListeners();
  }

  Future? addGroup(String? name) async {
    setStateFor(addGROUP, ViewState.Busy);
    try {
      newGroup = await _groupsApi.addGroup(name!);

      setStateFor(addGROUP, ViewState.Success);
    } on Failure catch (f) {
      setStateFor(addGROUP, ViewState.Error);
      setErrorMessageFor(addGROUP, f.message);
    }
  }
}
