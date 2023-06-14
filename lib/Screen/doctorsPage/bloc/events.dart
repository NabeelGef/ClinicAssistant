
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
class EditClickSpecialist extends AllDoctorsEvents{}
class ChooseSubSpecialist extends AllDoctorsEvents{
  final int index ;
  final SubSpecialties sub;
  ChooseSubSpecialist(this.sub, this.index);
}
class LoadingSpecialists extends AllDoctorsEvents{}
class LoadingDoctors extends AllDoctorsEvents{
  final String? filterName;
  final int? subSpecialtyId;
  final bool? orderByEvaluate;
  LoadingDoctors(this.filterName, this.subSpecialtyId, this.orderByEvaluate);
}
class CheckEvaluate extends AllDoctorsEvents{
  final bool evaluate;
    CheckEvaluate(this.evaluate);
}
class CheckAll extends AllDoctorsEvents{
  final bool evaluate;
  CheckAll(this.evaluate);
}
class EditCheckAll extends AllDoctorsEvents{}