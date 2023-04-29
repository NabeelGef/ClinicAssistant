import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoctorProfile extends StatefulWidget {
  final String id;
  const DoctorProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack, overlays: []);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: null, // Set your desired color here
    // ));
    return Scaffold(
      // appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent,
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent
      //   ),),
      backgroundColor: Coloring.primary,
      body: BodyDetail(context)
    );
  }
  //Make Body
  BodyDetail(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: API.getDetailDoctor(widget.id),
          builder: (context, snapshot)
          {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    height: Sizer.getHeight(context)/3,
                    width: double.infinity,
                    child: Stack(
                        children: [
                          Container(
                              width:double.infinity ,
                              child: Image.network(snapshot.data!.profilePicture! , fit: BoxFit.fitWidth,)),
                          Positioned(
                              right: 20,
                              bottom : 10,
                              child: snapshot.data!.active!? Image.asset("assets/images/online.png")
                                  :Image.asset("assets/images/offline.png")) ,
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top:Sizer.getHeight(context)/3.5 ),
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.evaluate,
                              itemBuilder: (context, index) {
                                return Container(
                                    child: Image.asset("assets/images/star.png"));
                              },
                            ),
                          )]
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("${snapshot.data!.firstName}${snapshot.data!.lastName}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: Font.fontfamily ,
                              fontWeight: FontWeight.bold,
                              fontSize: Sizer.getTextSize(context, 0.05)
                          )),
                      Text(" :الاسم",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: Font.fontfamily ,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizer.getTextSize(context, 0.05)
                        ),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("${snapshot.data!.specialtyName}${snapshot.data!.subSpecialtyName}",style: TextStyle(
                          fontFamily: Font.fontfamily ,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizer.getTextSize(context, 0.05)

                      )),Text("${snapshot.data!.phoneNumber}",style: TextStyle(
                          fontFamily: Font.fontfamily ,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizer.getTextSize(context, 0.05)
                      )),
                    ],
                  ),
                  Divider(thickness: 2,color: Coloring.customgrey),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("سعر الكشفيّة:",style: TextStyle(
                          fontFamily: Font.fontfamily ,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizer.getTextSize(context, 0.05)
                      )),
                      Text("${snapshot.data!.checkupPrice} SP",style: TextStyle(
                          fontFamily: Font.fontfamily ,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizer.getTextSize(context, 0.05)
                      ))
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.record_voice_over , size: Sizer.getTextSize(context, 0.05),) ,
                        Text("${snapshot.data!.numberOfPeopleWhoVoted}",style: TextStyle(
                            fontFamily: Font.fontfamily ,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizer.getTextSize(context, 0.05)
                        ))
                      ]),
                  Divider(thickness: 2,color: Coloring.customgrey),
                  Text("${snapshot.data!.description!}"
                      ,textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: Font.fontfamily ,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizer.getTextSize(context, 0.05)
                      )),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: Sizer.getHeight(context)/10,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.clinics!.length,
                        itemBuilder: (context, index) {
                          return Card(child: Column(
                            children: [
                              Text("${snapshot.data!.clinics![index].clinicName!}",style: TextStyle(
                                  fontFamily: Font.fontfamily ,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizer.getTextSize(context, 0.05)
                              )),
                              Icon(Icons.info , size: Sizer.getTextSize(context, 0.05),)
                            ],
                          ));
                        } ),
                  ) ,
                  MaterialButton(
                    onPressed: () {
                    },
                    color: Coloring.customgrey,
                    child: Text("احجز الآن",style: TextStyle(
                        fontFamily: Font.fontfamily ,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizer.getTextSize(context, 0.05)

                    )),

                  )
                ],
              );
            }else{
              return Text("No Data");
            }
          }
      ),
    );
  }
}
