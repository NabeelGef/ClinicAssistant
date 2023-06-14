import 'package:clinicassistant/model/doctorClinicBook.dart';

class BookState {
  final List<String> StatesDropDown;
  final SuccessDoctorClinicBook successDoctorClinicBook;
  BookState(this.StatesDropDown, this.successDoctorClinicBook);
}

class SuccessDoctorClinicBook {
  final DoctorClinicBook? doctorClinicBook;
  final String error;
  SuccessDoctorClinicBook(this.doctorClinicBook, this.error);
}
