import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/doctorProfile/doctor_profile.dart';
import 'package:clinicassistant/doctorsPage/bloc/bloc.dart';
import 'package:clinicassistant/doctorsPage/bloc/events.dart';
import 'package:clinicassistant/doctorsPage/bloc/states.dart';
import 'package:clinicassistant/model/specialist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AllDoctors extends StatefulWidget {
  const AllDoctors({Key? key}) : super(key: key);

  @override
  State<AllDoctors> createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllDoctorsBloc(InitialState()),
      child: Scaffold(
        key: _scaffoldkey,
        appBar: MyAppBar(),
        drawer: Code.DrawerNative(context),
        body: BodyDoctors(),
      ),
    );
  }

  //Make Body
  Widget BodyDoctors() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(15),
          width: double.infinity,
          height: Sizer.getHeight(context)/10,
          child: Row(
            children: [
              BlocConsumer<AllDoctorsBloc , AllDoctorStates>(
                  listener: (context, AllDoctorStates state) {},
                  builder: (context, AllDoctorStates state) {
                    int clickspecialist = AllDoctorsBloc.get(context).clickspecialist;
                    return InkWell(
                      onTap: () {
                        AllDoctorsBloc.get(context).add(ChooseSpecialist(-1 , []));
                      },
                      child: Container(
                        width: Sizer.getWidth(context)/4,
                        height: Sizer.getHeight(context)/16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          color: clickspecialist==-1? Coloring.custompurble
                            : Colors.white,
                        ),
                        child: Center(
                          child: Text("الجميع ", textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Sizer.getTextSize(context, 0.05),
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold,
                                  color:clickspecialist==-1? Colors.white
                                      : Coloring.customgrey)),
                        ),
                      ),
                    );
                  }),
              SizedBox(width: 15,),
              Expanded(
                child: FutureBuilder<Specialists>(
                    future: API.getSpecialist() ,
                    builder: (context,AsyncSnapshot<Specialists> snapshot)
                    {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Shimmer.fromColors(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      width: Sizer.getWidth(context)/4,
                                      height: Sizer.getHeight(context)/16,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 15,),
                                  ],
                                );
                              },
                            ),
                            baseColor: Colors.white, highlightColor: Coloring.custompurble);
                      }
                      else if(snapshot.hasData) {
                        return BlocConsumer<AllDoctorsBloc , AllDoctorStates>(
                            listener: (context, AllDoctorStates state) {},
                            builder: (context,AllDoctorStates state)
                            {
                              int clickspecialist = AllDoctorsBloc.get(context).clickspecialist;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.specialist!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      AllDoctorsBloc.get(context).add(ChooseSpecialist(index ,
                                          snapshot.data!.specialist![index].subspecialties!));
                                      print("Index = $index");
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Sizer.getWidth(context)/4,
                                          height: Sizer.getHeight(context)/17,
                                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          color: clickspecialist==index? Coloring.custompurble
                                              :  Colors.white,
                                    ),
                                            child: Center(
                                              child: Text(snapshot.data!.specialist![index].specialtyName!, textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: Sizer.getTextSize(context, 0.05),
                                                    fontFamily: Font.fontfamily,
                                                    fontWeight: FontWeight.bold,
                                                    color: clickspecialist==index? Colors.white
                                                        :  Coloring.customgrey),),
                                            ),
                                          ),

                                        SizedBox(width: 15,),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                        );
                      }
                      else {
                        return Container(
                          color: Colors.amber,
                        );
                      }
                    }
                ),
              ),
            ],
          ),
        ),
        BlocConsumer<AllDoctorsBloc,AllDoctorStates>(
          listener: (context,AllDoctorStates state) {},
          builder: (context,AllDoctorStates state) {
            List<Subspecialties> sub = AllDoctorsBloc.get(context).subspecialities;
            return sub.length==0? Expanded(
              child: FutureBuilder(
                  future: API.getDoctors(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Shimmer.fromColors(
                          direction: ShimmerDirection.ttb,
                          loop: 10,
                          child: Container(
                            width: Sizer.getWidth(context)/1.1,
                            child: GridView.builder(gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 15,
                                crossAxisCount: 2,
                                mainAxisExtent : Sizer.getHeight(context)/1.8
                            ),
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                      decoration: BoxDecoration(
                                      color: Coloring.custompurble,
                                      borderRadius: BorderRadius.circular(25),
                                  ),
                                  );
                                  //   child: Shimmer.fromColors(
                                  //       child: Container(
                                  //   decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(25),
                                  // ),
                                  //   )
                                  //       , baseColor: Coloring.customgrey, highlightColor: Coloring.primary),
                                  // );
                                }),
                          )
                          , baseColor: Colors.white, highlightColor: Coloring.custompurble);
                    }
                    else if (snapshot.hasData) {
                      return
                        Container(
                          width: Sizer.getWidth(context)/1.1,
                          child: GridView.builder(
                            itemCount: snapshot.data!.doctors!.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 15,
                                crossAxisCount: 2,
                                mainAxisExtent : Sizer.getHeight(context)/1.8
                            ),
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              int countstar = snapshot.data!.doctors![index].evaluate!.toInt();
                              return InkWell(
                                onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) => DoctorProfile(
                                    id: snapshot.data!.doctors![index].id! ,
                                ),)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Coloring.customgrey2,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15,),
                                  Container(
                                    width: Sizer.getWidth(context)/3,
                                    height: Sizer.getHeight(context)/4,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data!.doctors![index].profilePicture!),
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                        repeat: ImageRepeat.noRepeat,
                                      ),

                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                      Center(
                                          child: Text("${snapshot.data!.doctors![index].firstName} ${snapshot.data!.doctors![index].lastName}",
                                          style: TextStyle(color: Colors.black
                                              ,fontSize: Sizer.getTextSize(context, 0.05),
                                              fontFamily: Font.fontfamily ,
                                              fontWeight: FontWeight.bold))),
                                      Center(
                                        child: Container(
                                          height: Sizer.getHeight(context)/20,
                                          child: ListView.builder(
                                            itemCount:  5,
                                            itemBuilder: (context, index) {
                                              if(index < countstar)
                                                return Container(
                                                    width: Sizer.getWidth(context)/15,
                                                    child: Image.asset("assets/images/star.png" , fit: BoxFit.cover,));
                                              else return Container(
                                                  // width: Sizer.getWidth(context)/15,
                                                  // child: Image.asset("assets/images/emptystar.png", fit: BoxFit.cover));
                                              );},
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                      ),
                                      Divider(thickness: 4, color: Colors.white,),
                                      Center(child: Text(snapshot.data!.doctors![index].specialtyName!
                                          , style: TextStyle(color: Colors.black
                                              , fontFamily: Font.fontfamily , fontSize: Sizer.getTextSize(context, 0.04), fontWeight: FontWeight.bold))),
                                      snapshot.data!.doctors![index].subSpecialtyName!=null?
                                      Center(child: Text(snapshot.data!.doctors![index].subSpecialtyName!
                                          , style: TextStyle(color: Colors.black
                                              , fontFamily: Font.fontfamily , fontSize: 15, fontWeight: FontWeight.bold)))
                                          :Center(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.phone , color: Coloring.customgrey , size: Sizer.getTextSize(context, 0.05),),
                                          Text(snapshot.data!.doctors![index].phoneNumber!, style: TextStyle(color: Colors.black
                                              , fontFamily: Font.fontfamily ,fontSize: Sizer.getTextSize(context, 0.04), fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                    }
                    else{
                      return Center(child: Text("NotFound!!"));
                    }
                  }
              ),
            ) :
              Expanded(child:
                GridView.builder(
                  itemCount: sub.length,
             itemBuilder: (context, index) {
                    return Container(
                   decoration: BoxDecoration(
                     gradient:
                     SweepGradient(colors: [
                       Colors.white,
                       Coloring.custompurble,
                       Colors.white,
                     ]),
                     color: Coloring.primary,
                     borderRadius: BorderRadius.circular(25),
                   ),
                      child: Column(
                        children: [
                        SizedBox(height: 15),
                        Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(25),
                         ),
                         child: Image(image: AssetImage(
                             "assets/images/clinic1.png")),
                       ),
                       Divider(thickness: 2 , color: Colors.white,),
                       Center(child: Text(sub[index].subSpecialtyName!,
                           textAlign: TextAlign.center,
                           style: TextStyle(color: Colors.black,
                               fontFamily: Font.fontfamily,
                               fontWeight: FontWeight.bold))),
                       ],
                   ));
             },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 15,
                  crossAxisCount: 2,
                  mainAxisExtent : Sizer.getHeight(context)/1.8
              ),
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
            )
            );
          },
        )
      ],
    );
  }
  //Make AppBar
  MyAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(Sizer.getHeight(context)/8),
      child: BlocConsumer<AllDoctorsBloc , AllDoctorStates>(
          listener: (context,AllDoctorStates state) {},
          builder: (context , AllDoctorStates state) {
            bool isSearchSelected = AllDoctorsBloc.get(context).isSearch;
            return Code.AppBarDoctorsAndClinics(_scaffoldkey,context, isSearchSelected ,true,
                "أوجد طبيبك المناسبك" , "أدخل اسم طبيبك ...");
          }
      ),
    );
  }
}

