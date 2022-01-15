import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mobile_app/enums/view_state.dart';
import 'package:mobile_app/locator.dart';
import 'package:mobile_app/models/assignments.dart';
import 'package:mobile_app/models/failure_model.dart';
import 'package:mobile_app/services/API/assignments_api.dart';
import 'package:mobile_app/viewmodels/base_viewmodel.dart';

class UpdateAssignmentViewModel extends BaseModel {
  // ViewState Keys
  String updateASSIGNMENT = 'update_assignment';

  final AssignmentsApi _assignmentsApi = locator<AssignmentsApi>();

  Assignment _updatedAssignment;

  Assignment get updatedAssignment => _updatedAssignment;

  set updatedAssignment(Assignment updatedAssignment) {
    _updatedAssignment = updatedAssignment;
    notifyListeners();
  }

  Future updateAssignment(
    String assignmentId,
    String name,
    DateTime deadline,
    String description,
    List restrictionsList,
  ) async {
    setStateFor(updateASSIGNMENT, ViewState.Busy);
    try {
      // deadline format..
      var deadlineFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

      // Updates Assignment..
      updatedAssignment = await _assignmentsApi.updateAssignment(
        assignmentId,
        name,
        deadlineFormat.format(deadline.subtract(deadline.timeZoneOffset)),
        description,
        jsonEncode(restrictionsList),
      );

      setStateFor(updateASSIGNMENT, ViewState.Success);
    } on Failure catch (f) {
      setStateFor(updateASSIGNMENT, ViewState.Error);
      setErrorMessageFor(updateASSIGNMENT, f.message);
    }
  }
}
