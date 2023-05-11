
import 'package:clinicassistant/model/specialist.dart';

import 'package:clinicassistant/model/specialist.dart';

abstract class AllDoctorsEvents{
  AllDoctorsEvents();
}

class SearchEventDoctor extends AllDoctorsEvents{}
class ChooseSpecialist extends AllDoctorsEvents {
  final int index ;
  final Specialist specialist;

  //final List<SubSpecialties> subspecialties ;
  ChooseSpecialist(this.index , this.specialist);
}
class ChooseSubSpecialist extends AllDoctorsEvents{
  final String sub;
  ChooseSubSpecialist(this.sub);
}
class LoadingSpecialists extends AllDoctorsEvents{}
class LoadingDoctors extends AllDoctorsEvents{}
