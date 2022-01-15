import 'package:mobile_app/enums/view_state.dart';
import 'package:mobile_app/locator.dart';
import 'package:mobile_app/models/failure_model.dart';
import 'package:mobile_app/models/groups.dart';
import 'package:mobile_app/services/API/groups_api.dart';
import 'package:mobile_app/viewmodels/base_viewmodel.dart';

class EditGroupViewModel extends BaseModel {
  // ViewState Keys
  String updateGROUP = 'update_group';

  final GroupsApi _groupsApi = locator<GroupsApi>();

  Group _updatedGroup;

  Group get updatedGroup => _updatedGroup;

  set updatedGroup(Group updatedGroup) {
    _updatedGroup = updatedGroup;
    notifyListeners();
  }

  Future updateGroup(String groupId, String name) async {
    setStateFor(updateGROUP, ViewState.Busy);
    try {
      updatedGroup = await _groupsApi.updateGroup(groupId, name);

      setStateFor(updateGROUP, ViewState.Success);
    } on Failure catch (f) {
      setStateFor(updateGROUP, ViewState.Error);
      setErrorMessageFor(updateGROUP, f.message);
    }
  }
}
