import 'package:clinicassistant/model/specialist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  Doctor({
    required this.doctor,
  });

  final List<Doctors> doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}

@JsonSerializable()
class Doctors {
  Doctors(
      {this.doctorId,
      this.description,
      this.email,
      this.phonenumberForAdmin,
      this.active,
      this.password,
      this.gender,
      this.profilePicture,
      this.firstname,
      this.lastname,
      this.evaluate,
      this.numberOfPeopleWhoVoted,
      this.phonenumber,
      this.createdAt,
      this.specialties});

  final String? doctorId;
  final String? description;
  final String? email;
  final String? phonenumberForAdmin;
  final bool? active;
  final String? password;
  final String? gender;
  final String? profilePicture;
  final String? firstname;
  final String? lastname;
  final String? evaluate;
  final int? numberOfPeopleWhoVoted;
  final String? phonenumber;
  final DateTime? createdAt;
  final List<Specialist>? specialties;

  factory Doctors.fromJson(Map<String, dynamic> json) =>
      _$DoctorsFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorsToJson(this);
}

/*
{
	"doctors": [
		{
			"doctorId": "1",
			"description": "دكتور متخرج من جامعة اكسفور بخبرة 4 سنوات في مجال الاسنان والتقويم والفك و القدرة على صناعة تقويم مطابق وصحّي لشكل الاسنان ",
			"email": "ahmad@gmail.com",
			"phonenumberForAdmin": "0912213151651",
			"active": true,
			"password": "12345",
			"gender": "ذكر",
			"profilePicture": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbS_EunOyPXOf828LVmG4usCZlyDfLt_BhFg&usqp=CAU",
			"firstname": "احمد",
			"lastname": "حمودة",
			"evaluate": "3.00",
			"numberOfPeopleWhoVoted": 0,
			"phonenumber": "09445566122",
			"createdAt": "2023-05-27T11:51:59.000Z"
		},
		{
			"doctorId": "2",
			"description": "طبيب جرّاح بخبرة 10 سنوات في جراحة وتخطيط عمل القلب و عمل القئطرة و المعالجة الحيوية ",
			"email": "Mohammad@gmail.com",
			"phonenumberForAdmin": "05126516515",
			"active": true,
			"password": "123456789",
			"gender": "ذكر",
			"profilePicture": "https://lakeforestgroup.com/wp-content/uploads/2014/11/doctor-profile-02.jpg",
			"firstname": "محمد",
			"lastname": "حمودة",
			"evaluate": "3.00",
			"numberOfPeopleWhoVoted": 0,
			"phonenumber": null,
			"createdAt": "2023-05-27T11:56:45.000Z"
		},
		{
			"doctorId": "3",
			"description": "طبيبة داخلية مختصة في علم البواطن والدواخل ومعالجة الاورام السرطانية بخبرة 5 سنوات ",
			"email": "sara@gmail.com",
			"phonenumberForAdmin": "32156156156",
			"active": true,
			"password": "123456789",
			"gender": "انثى",
			"profilePicture": "http://wwsthemes.com/themes/medwise/v1.4/images/doc-3.png",
			"firstname": "سارة ",
			"lastname": "الحلبي",
			"evaluate": "3.00",
			"numberOfPeopleWhoVoted": 0,
			"phonenumber": "0912345678",
			"createdAt": "2023-05-27T12:01:35.000Z"
		}
	]
}*/