
import 'package:clinicassistant/model/specialist.dart';

import 'package:clinicassistant/model/specialist.dart';

abstract class AllDoctorsEvents{
  AllDoctorsEvents();
}

class SearchEventDoctor extends AllDoctorsEvents{}
class ChooseSpecialist extends AllDoctorsEvents {
  final int index ;
  final List<Subspecialties> subspecialties ;
  ChooseSpecialist(this.index , this.subspecialties);
}