// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AllClinicsEvents {
  AllClinicsEvents();
}

class SearchEventClinic extends AllClinicsEvents {
  String name;
  SearchEventClinic({
    required this.name,
  });
}

class LoadingClinics extends AllClinicsEvents {}
