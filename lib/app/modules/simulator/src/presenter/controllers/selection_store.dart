import 'package:flutter_triple/flutter_triple.dart';

import '../../domain/entities/Selection/selection_entity.dart';
import '../../domain/usecases/Selection/get_all_selections_interface.dart';
import '../../domain/usecases/Selection/get_selections_by_group_interface.dart';
import '../../domain/usecases/Selection/update_selection_statistics_interface.dart';
import '../../errors/errors_classes/errors_classes.dart';

class SelectionStore extends NotifierStore<Failure, List<Selecao>> {
  late final IGetAllSelections _getAll;
  late final IGetSelectionsByGroup _getByGroup;
  late final IUpdateSelectionStatistics _updateStatistics;

  SelectionStore({
    required IGetAllSelections getAll,
    required IGetSelectionsByGroup getByGroup,
    required IUpdateSelectionStatistics updateStatistics,
  }) : super([]) {
    _getAll = getAll;
    _getByGroup = getByGroup;
    _updateStatistics = updateStatistics;
  }

  Future<void> getAllSelections() async {
    setLoading(true);

    var result = await _getAll();

    result.fold((error) {
      setError(error);
    }, (selections) {
      update(selections);
    });

    setLoading(false);
  }

  Future<void> getSelectionsByGroup(String group) async {
    setLoading(true);

    var result = await _getByGroup(group);

    result.fold((error) {
      setError(error);
    }, (selections) {
      update(selections);
    });

    setLoading(false);
  }

  Future<void> updateStatistics({
    required int selectionId1,
    required int selectionId2,
    required String group,
    required List<int> newScores,
    required List<int?> oldScores,
  }) async {
    var result = await _updateStatistics(
      group: group,
      newScores: newScores,
      oldScores: oldScores,
      selectionId1: selectionId1,
      selectionId2: selectionId2,
    );

    result.fold((l) {
      setError(l);
    }, (selections) {
      update(selections);
    });
  }
}
