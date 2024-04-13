// import 'package:flutter/foundation.dart';
// import 'package:mf_app/src/app/repository/funds_repository/funds_repository.dart';
// import 'package:mf_app/src/app/repository/models/graphs/allocation_model.dart';

// abstract class AllocationState {}

// class AllocationInitial implements AllocationState {}

// class AllocationLoading implements AllocationState {}

// class AllocationError implements AllocationState {
//   final String error;

//   AllocationError({required this.error});
// }

// class AllocationLoaded implements AllocationState {
//   final Composition composition;

//   AllocationLoaded({required this.composition});
// }

// class AllocationViewModel {
//   final FundsRepository _fundsRepository;

//   final ValueNotifier<AllocationState> _allocationNotifier =
//       ValueNotifier(AllocationInitial());

//   ValueListenable<AllocationState> get allocationNotifier =>
//       _allocationNotifier;

//   AllocationViewModel({required FundsRepository fundsRepository})
//       : _fundsRepository = fundsRepository;

//   // Future<Composition> getCompostionForAllocation(int id) async {
//   //   final composition = await _fundsRepository.getCompositionAllocation(id);
//   //   return composition;
//   // }

//   Future<void> initialise(int id) async {
//     _allocationNotifier.value = AllocationLoading();
//     try {
//       //
//       // _allocationNotifier.value = AllocationLoaded(composition: composition);
//       final composition = await getCompostionForAllocation(id);
//     } catch (e) {
//       _allocationNotifier.value = AllocationError(error: e.toString());
//       rethrow;
//     }
//   }
// }
