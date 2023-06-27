import 'package:android_intent_plus/android_intent.dart';
import 'package:clinicassistant/Screen/searchByLocation/bloc/event.dart';
import 'package:clinicassistant/Screen/searchByLocation/bloc/state.dart';
import 'package:clinicassistant/model/area.dart';
import 'package:clinicassistant/model/clinic.dart';
import 'package:clinicassistant/model/governorate.dart';
import 'package:clinicassistant/repository/get_all_area_repo.dart';
import 'package:clinicassistant/repository/get_all_governorate_repo.dart';
import 'package:clinicassistant/repository/search_by_location_area_repo.dart';
import 'package:fl_location/fl_location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchByLocationBloc
    extends Bloc<SearchLocationEvent, SearchByLocationState> {
  SearchByLocationBloc(super.initialState);
  Governorate? dropdowngovernate;
  Area? dropdownareas;
  bool? isClickArea;

  @override
  Stream<SearchByLocationState> mapEventToState(
      SearchLocationEvent event) async* {
    if (event is GetGovernorateEvent) {
      yield* getGovernorate(dropdowngovernate);
    }
    if (event is ChangeDropDownGovernorateEvent) {
      dropdowngovernate = event.dropdown;
      yield* getGovernorateDrop(dropdowngovernate);
    }
    if (event is ChangeDropDownAreaEvent) {
      dropdownareas = event.dropdown;
      yield* getAreaDrop(dropdownareas);
    }
    if (event is SearchByLocationEvent) {
      isClickArea = true;
      yield* searchbylocation(event.areaId, event.specialId);
    }
    if (event is AddMyLocationEvent) {
      yield* addMyLocation();
    }
    if (event is SearchByMYLocationEvent) {
      yield* searchbymylocation(
          event.Latitude, event.Longitude, event.specialId);
    }
  }

  Stream<SearchByLocationState> getGovernorate(
      Governorate? dropDownGovernate) async* {
    yield SearchByLocationState(
        GetGovernorateState(
            dropdowngovernate: null, allGovernorate: null, error: ""),
        GetAreaState(
            dropdownarea: null, allArea: null, error: "Not found any data"),
        GetClinicState(clinic: null, error: ""),
        null,
        state.Mylocation);
    try {
      AllGovernorate? allGovernorate =
          await GetAllGovernorateRepo.getAllGovernorate();
      if (allGovernorate == null) {
        yield SearchByLocationState(
            GetGovernorateState(
              dropdowngovernate: null,
              allGovernorate: null,
              error: "Not found any data",
            ),
            GetAreaState(
                dropdownarea: null, allArea: null, error: "Not found any data"),
            GetClinicState(clinic: null, error: ""),
            null,
            state.Mylocation);
      } else {
        yield SearchByLocationState(
            GetGovernorateState(
              dropdowngovernate: state.getGovernorateState.dropdowngovernate,
              allGovernorate: allGovernorate,
              error: "",
            ),
            GetAreaState(
                dropdownarea: null, allArea: null, error: "Not found any data"),
            GetClinicState(clinic: null, error: ""),
            null,
            state.Mylocation);
      }
    } catch (e, s) {
      print("Error in Get Governorate is : $e , in \n $s");
      yield SearchByLocationState(
          GetGovernorateState(
            dropdowngovernate: state.getGovernorateState.dropdowngovernate,
            allGovernorate: null,
            error: "Not found any data",
          ),
          GetAreaState(
              dropdownarea: null, allArea: null, error: "Not found any data"),
          GetClinicState(clinic: null, error: ""),
          null,
          state.Mylocation);
    }
  }

  Stream<SearchByLocationState> getGovernorateDrop(
      Governorate? dropDownGovernate) async* {
    yield SearchByLocationState(
        GetGovernorateState(
          dropdowngovernate: null,
          allGovernorate: state.getGovernorateState.allGovernorate,
          error: "",
        ),
        GetAreaState(dropdownarea: null, allArea: null, error: ""),
        GetClinicState(clinic: null, error: ""),
        null,
        state.Mylocation);
    try {
      AllGovernorate? allGovernorate =
          await GetAllGovernorateRepo.getAllGovernorate();
      if (allGovernorate == null) {
        yield SearchByLocationState(
            GetGovernorateState(
              dropdowngovernate: null,
              allGovernorate: null,
              error: "Not found any data",
            ),
            GetAreaState(
                dropdownarea: null, allArea: null, error: "Not found any data"),
            GetClinicState(clinic: null, error: ""),
            null,
            state.Mylocation);
      } else {
        try {
          AllArea? allArea =
              await GetAllAreaRepo.getAllArea(dropDownGovernate!.governorateId);
          dropdownareas = allArea!.areas![0];
          yield SearchByLocationState(
              GetGovernorateState(
                dropdowngovernate: dropDownGovernate,
                allGovernorate: state.getGovernorateState.allGovernorate,
                error: "",
              ),
              GetAreaState(
                  dropdownarea: allArea.areas![0], allArea: allArea, error: ""),
              GetClinicState(clinic: null, error: ""),
              null,
              state.Mylocation);
        } catch (e, s) {
          print("Error in Get All Area State is : $e in \n$s");
          yield SearchByLocationState(
              GetGovernorateState(
                dropdowngovernate: dropDownGovernate,
                allGovernorate: state.getGovernorateState.allGovernorate,
                error: "",
              ),
              GetAreaState(
                  dropdownarea: null,
                  allArea: null,
                  error: "Not found any data"),
              GetClinicState(clinic: null, error: ""),
              null,
              state.Mylocation);
        }
      }
    } catch (e, s) {
      print("Error in Get Governorate is : $e , in \n $s");
      yield SearchByLocationState(
          GetGovernorateState(
            dropdowngovernate: null,
            allGovernorate: state.getGovernorateState.allGovernorate,
            error: "Not found any data",
          ),
          GetAreaState(
              dropdownarea: null, allArea: null, error: "Not found any data"),
          GetClinicState(clinic: null, error: ""),
          null,
          state.Mylocation);
    }
  }

  Stream<SearchByLocationState> getAreaDrop(Area? dropDownareas) async* {
    yield SearchByLocationState(
        GetGovernorateState(
          dropdowngovernate: dropdowngovernate,
          allGovernorate: state.getGovernorateState.allGovernorate,
          error: "",
        ),
        GetAreaState(
            dropdownarea: null,
            allArea: state.getAreaState.allArea,
            error: "Not found any data"),
        GetClinicState(clinic: null, error: ""),
        null,
        state.Mylocation);
    try {
      AllGovernorate? allGovernorate =
          await GetAllGovernorateRepo.getAllGovernorate();
      if (allGovernorate == null) {
        yield SearchByLocationState(
            GetGovernorateState(
              dropdowngovernate: null,
              allGovernorate: null,
              error: "Not found any data",
            ),
            GetAreaState(
                dropdownarea: null, allArea: null, error: "Not found any data"),
            GetClinicState(clinic: null, error: ""),
            null,
            state.Mylocation);
      } else {
        try {
          yield SearchByLocationState(
              GetGovernorateState(
                dropdowngovernate: dropdowngovernate,
                allGovernorate: state.getGovernorateState.allGovernorate,
                error: "",
              ),
              GetAreaState(
                  dropdownarea: dropDownareas,
                  allArea: state.getAreaState.allArea,
                  error: ""),
              GetClinicState(clinic: null, error: ""),
              null,
              state.Mylocation);
        } catch (e, s) {
          print("Error in Get All Area State is : $e in \n$s");
          yield SearchByLocationState(
              GetGovernorateState(
                dropdowngovernate: dropdowngovernate,
                allGovernorate: state.getGovernorateState.allGovernorate,
                error: "",
              ),
              GetAreaState(
                  dropdownarea: null,
                  allArea: state.getAreaState.allArea,
                  error: "Not found any data"),
              GetClinicState(clinic: null, error: ""),
              null,
              state.Mylocation);
        }
      }
    } catch (e, s) {
      print("Error in Get Governorate is : $e , in \n $s");
      yield SearchByLocationState(
          GetGovernorateState(
            dropdowngovernate: null,
            allGovernorate: state.getGovernorateState.allGovernorate,
            error: "Not found any data",
          ),
          GetAreaState(
              dropdownarea: null,
              allArea: state.getAreaState.allArea,
              error: "Not found any data"),
          GetClinicState(clinic: null, error: ""),
          null,
          state.Mylocation);
    }
  }

  Stream<SearchByLocationState> searchbylocation(
      String areaId, String specialId) async* {
    yield SearchByLocationState(
        GetGovernorateState(
          allGovernorate: state.getGovernorateState.allGovernorate,
          dropdowngovernate: dropdowngovernate,
          error: "",
        ),
        GetAreaState(
            allArea: state.getAreaState.allArea,
            dropdownarea: dropdownareas,
            error: ""),
        GetClinicState(clinic: null, error: ""),
        true,
        state.Mylocation);
    try {
      Clinic? clinic = await SearchByLocation.searchByArea(areaId, specialId);
      if (clinic == null) {
        yield SearchByLocationState(
            GetGovernorateState(
                allGovernorate: state.getGovernorateState.allGovernorate,
                dropdowngovernate: dropdowngovernate,
                error: ""),
            GetAreaState(
                allArea: state.getAreaState.allArea,
                dropdownarea: dropdownareas,
                error: ""),
            GetClinicState(clinic: null, error: "Not Found any Data"),
            true,
            state.Mylocation);
      }
      yield SearchByLocationState(
          GetGovernorateState(
              allGovernorate: state.getGovernorateState.allGovernorate,
              dropdowngovernate: dropdowngovernate,
              error: ""),
          GetAreaState(
              allArea: state.getAreaState.allArea,
              dropdownarea: dropdownareas,
              error: ""),
          GetClinicState(clinic: clinic, error: ""),
          true,
          state.Mylocation);
    } catch (e, s) {
      print("Error in Search By Location is : $e in $s");
      yield SearchByLocationState(
          GetGovernorateState(
              allGovernorate: state.getGovernorateState.allGovernorate,
              dropdowngovernate: dropdowngovernate,
              error: ""),
          GetAreaState(
              allArea: state.getAreaState.allArea,
              dropdownarea: dropdownareas,
              error: ""),
          GetClinicState(clinic: null, error: ""),
          true,
          state.Mylocation);
    }
  }

  Stream<SearchByLocationState> addMyLocation() async* {
    Location? dataLocation;
    if (await _checkAndRequestPermission()) {
      final timeLimit = const Duration(seconds: 5);
      await FlLocation.getLocation(timeLimit: timeLimit).then((location) {
        print('location: ${location.toJson().toString()}');
        dataLocation = location;
      }).onError((error, stackTrace) {
        print('error: ${error.toString()}');
      });
    } else {}
    yield SearchByLocationState(
        GetGovernorateState(
            allGovernorate: state.getGovernorateState.allGovernorate,
            error: ""),
        GetAreaState(allArea: state.getAreaState.allArea, error: ""),
        GetClinicState(clinic: state.getClinicState.clinic, error: ""),
        isClickArea,
        dataLocation);
  }

  Future<bool> _checkAndRequestPermission({bool? background}) async {
    if (!await FlLocation.isLocationServicesEnabled) {
      // Location services are disabled.
      final AndroidIntent intent = new AndroidIntent(
        action: 'android.settings.LOCATION_SOURCE_SETTINGS',
      );
      await intent.launch();
      print("Successs");
      return false;
    }

    var locationPermission = await FlLocation.checkLocationPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      // Cannot request runtime permission because location permission is denied forever.
      return false;
    } else if (locationPermission == LocationPermission.denied) {
      // Ask the user for location permission.
      locationPermission = await FlLocation.requestLocationPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) return false;
    }

    // Location permission must always be allowed (LocationPermission.always)
    // to collect location data in the background.
    if (background == true &&
        locationPermission == LocationPermission.whileInUse) return false;

    // Location services has been enabled and permission have been granted.
    return true;
  }

  Stream<SearchByLocationState> searchbymylocation(
      double latitude, double longitude, String specialId) async* {
    yield SearchByLocationState(
        GetGovernorateState(
            allGovernorate: state.getGovernorateState.allGovernorate,
            error: ""),
        GetAreaState(allArea: state.getAreaState.allArea, error: ""),
        GetClinicState(clinic: state.getClinicState.clinic, error: ""),
        isClickArea,
        state.Mylocation);
    try {
      Clinic? clinic = await SearchByLocation.searchByMyLocation(
          latitude, longitude, specialId);
      if (clinic == null) {
        yield SearchByLocationState(
            GetGovernorateState(
                allGovernorate: state.getGovernorateState.allGovernorate,
                error: ""),
            GetAreaState(allArea: state.getAreaState.allArea, error: ""),
            GetClinicState(clinic: null, error: ""),
            false,
            null);
      }
      yield SearchByLocationState(
          GetGovernorateState(
              allGovernorate: state.getGovernorateState.allGovernorate,
              error: ""),
          GetAreaState(allArea: state.getAreaState.allArea, error: ""),
          GetClinicState(clinic: clinic, error: ""),
          false,
          state.Mylocation);
    } catch (e, s) {
      print("Error in Get MyLocation is : $e is : $s");
      yield SearchByLocationState(
          GetGovernorateState(
              allGovernorate: state.getGovernorateState.allGovernorate,
              error: ""),
          GetAreaState(allArea: state.getAreaState.allArea, error: ""),
          GetClinicState(clinic: null, error: ""),
          false,
          state.Mylocation);
    }
  }
}
