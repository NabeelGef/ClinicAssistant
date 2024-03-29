import 'package:clinicassistant/Screen/bookingPage/bloc/event.dart';
import 'package:clinicassistant/Screen/bookingPage/bloc/state.dart';
import 'package:clinicassistant/model/doctorClinicBook.dart';
import 'package:clinicassistant/repository/BookRepository/doctor_clinic_book_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookPageBloc extends Bloc<BookEvent, BookState> {
  BookPageBloc(super.initialState);
  String imagespecialist = "moredrop.png";
  String imagecommunication = "moredrop.png";
  String imageaddress = "moredrop.png";
  DoctorClinicBook? doctorClinicBook;
  @override
  Stream<BookState> mapEventToState(BookEvent event) async* {
    if (event is ChangeCommunicationDropDown) {
      yield* ChangeDropDownCommunication(event.isClick);
    }
    if (event is ChangeSpecialDropDown) {
      yield* ChangeDropDownSpecial(event.isClick);
    }
    if (event is ChangeAddressDropDown) {
      yield* ChangeDropDownAddress(event.isClick);
    }
    if (event is LoadingBooking) {
      yield* Loading(event.doctorId, event.clinicId, event.token);
    }
  }

  Stream<BookState> ChangeDropDownCommunication(bool isClick) async* {
    if (!isClick) {
      imagecommunication = "moredrop.png";
    } else {
      imagecommunication = "lessdrop.png";
    }
    yield BookState([imagecommunication, imagespecialist, imageaddress],
        SuccessDoctorClinicBook(doctorClinicBook, ""));
  }

  Stream<BookState> ChangeDropDownSpecial(bool isClick) async* {
    if (!isClick) {
      imagespecialist = "moredrop.png";
    } else {
      imagespecialist = "lessdrop.png";
    }
    yield BookState([imagecommunication, imagespecialist, imageaddress],
        SuccessDoctorClinicBook(doctorClinicBook, ""));
  }

  Stream<BookState> ChangeDropDownAddress(bool isClick) async* {
    if (!isClick) {
      imageaddress = "moredrop.png";
    } else {
      imageaddress = "lessdrop.png";
    }
    yield BookState([imagecommunication, imagespecialist, imageaddress],
        SuccessDoctorClinicBook(doctorClinicBook, ""));
  }

  Stream<BookState> Loading(
      String doctorId, String clinicId, String token) async* {
    yield BookState([imagecommunication, imagespecialist, imageaddress],
        SuccessDoctorClinicBook(doctorClinicBook, ""));

    try {
      doctorClinicBook = await DoctorClinicBookRepository.getDoctorClinicBook(
          doctorId, clinicId, token);
      if (doctorClinicBook == null) {
        yield BookState([imagecommunication, imagespecialist, imageaddress],
            SuccessDoctorClinicBook(null, "Couldn't Find any Data!!"));
      } else {
        yield BookState([imagecommunication, imagespecialist, imageaddress],
            SuccessDoctorClinicBook(doctorClinicBook, ""));
      }
    } catch (e, s) {
      print("Catch Error In DoctorClinicBook : $e in Line $s");
      if (e is DioException) {
        if (e.response!.statusCode != 200) {
          yield BookState([imagecommunication, imagespecialist, imageaddress],
              SuccessDoctorClinicBook(null, "Not Found"));
        } else {
          yield BookState([imagecommunication, imagespecialist, imageaddress],
              SuccessDoctorClinicBook(null, "Not Found any data"));
        }
      }
    }
  }
}
