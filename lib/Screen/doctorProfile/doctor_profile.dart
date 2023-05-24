
import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/Screen/doctorProfile/bloc/bloc.dart';
import 'package:clinicassistant/Screen/doctorProfile/bloc/event.dart';
import 'package:clinicassistant/Screen/doctorProfile/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorProfile extends StatefulWidget {
  final String id;
  const DoctorProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  DoctorProfileBloc doctorProfileBloc = DoctorProfileBloc(["moredrop.png","moredrop.png" , "عرض المزيد"]);
  @override
  void initState() {
    print("The Id is : ==> ${widget.id}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: null, // Set your desired color here
    // ));
    return Scaffold(
        backgroundColor: Coloring.third,
        key: _scaffoldkey,
        appBar: MyAppBar(),
        endDrawer: Code.DrawerNative(context, _scaffoldkey),
        //backgroundColor: Coloring.primary,
        body: BodyDetail(context)
    );
  }

  //Make Body
  BodyDetail(BuildContext context) {
    return SingleChildScrollView(

        child:
        /*  if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }*/
        /*else if(snapshot.hasData)*/
        Column(
          children: [
            SizedBox(height: 25,),
            CircleAvatar(
              backgroundColor: Colors.transparent,
                radius: Sizer.getWidth(context) / 10,
                // backgroundImage: snapshot.data?.profilePicture==null?
                // null :NetworkImage(snapshot.data!.profilePicture!),
                child: //snapshot.data?.profilePicture==null?
                Image.asset("${Font.urlImage}doctoravatar.png")
              //:null,
            ),
            Center(
              //${snapshot.data!.firstName}${snapshot.data!.lastName}
              child: Text(" الطبيب محمد نبيل الغفري ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizer.getTextSize(context, 0.05),
                    fontFamily: Font.fontfamily,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Text(":الاختصاصات",
              style: TextStyle(
                  color: Coloring.primary,
                  fontSize: Sizer.getTextSize(context, 0.06),
                  fontFamily: Font.fontfamily,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text("اسنان- تقويم",style: TextStyle(
                color: Colors.white,
                fontSize: Sizer.getTextSize(context, 0.04),
                fontFamily: Font.fontfamily,
                fontWeight: FontWeight.bold
            )),
            // if he have many subspeciality :
            Directionality(
              textDirection: TextDirection.rtl,
              child: BlocBuilder <DoctorProfileBloc , List<String>>(
                  bloc: doctorProfileBloc,
                  builder: (context , state)
                  {
                    return ExpansionTile(
                        onExpansionChanged: (value) {
                          doctorProfileBloc.add(ChangingMoreText(value));
                          //print(value);
                        },
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("اسنان-لثّة",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizer.getTextSize(context, 0.05),
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ],
                          )
                        ],
                        trailing: Transform.translate(
                            offset: Offset(Sizer.getWidth(context)/4,0),
                            child: Image.asset("${Font.urlImage}more.png"),),

                        title: Transform.translate(
                          offset: Offset(-Sizer.getWidth(context)/3,0),
                          child: Text("${state[2]}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizer.getTextSize(context, 0.05),
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold
                              )),
                        ));
                  }
              ),
            ),

            Divider(color: Colors.white, thickness: 2),
            // if active or non active :
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("${Font.urlImage}online.png"),
                Text.rich(
                    TextSpan(
                        text: " الطبيب متاح الآن في ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizer.getTextSize(context, 0.05),
                            fontFamily: Font.fontfamily,
                        ),
                        children: <InlineSpan>[
                          TextSpan(text: "عيادة السّلام",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("${Font.urlImage}star.png",scale: 0.4,),
                Text("التقييم: 4.5 ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizer.getTextSize(context, 0.05),
                        fontFamily: Font.fontfamily,
                        fontWeight: FontWeight.bold
                    ))
              ],
            ),
            InkWell(
              onTap: () {
                showDialog(context: context,
                    builder: (context) {
                      return Code.showRatingBar(context);
                    });
                },
              child: Container(
                margin: EdgeInsets.only(top: 15.sp),
                alignment: Alignment.center,
                width: Sizer.getWidth(context) / 2.2,
                height: Sizer.getHeight(context) / 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(61.sp),
                    color: Coloring.primary
                ),
                child: Text("إضافة تقييم ",
                  style: TextStyle(fontFamily: Font.fontfamily, fontSize:
                  Sizer.getTextSize(context, 0.05), color: Colors.white),),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 15.sp),
                child: Divider(color: Colors.white,thickness: 2)),
            Directionality(
              textDirection: TextDirection.rtl,
              child: BlocBuilder <DoctorProfileBloc , List<String>>(
                  bloc: doctorProfileBloc,
                  builder: (context , state)
                  {
                    return ExpansionTile(
                        onExpansionChanged: (value) {
                          doctorProfileBloc.add(ChangeCommunicationDropDown(value));
                          //print(value);
                        },
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone_android_sharp , color: Coloring.primary),
                              Text("0955760913",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizer.getTextSize(context, 0.05),
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ],
                          )
                        ],
                        trailing: Transform.translate(
                            offset: Offset(Sizer.getWidth(context)/7,0),
                            child: Image.asset("${Font.urlImage}${state[1]}")),

                        title: Transform.translate(
                          offset: Offset(-Sizer.getWidth(context)/5,0),
                          child: Text("عرض معلومات التّواصل",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizer.getTextSize(context, 0.05),
                                  fontFamily: Font.fontfamily,
                                  fontWeight: FontWeight.bold
                              )),
                        ));
                  }
              ),
            ),
            Divider(color: Colors.white,thickness: 2),
            Directionality(
              textDirection: TextDirection.rtl,
              child: BlocBuilder <DoctorProfileBloc , List<String>>(
                bloc: doctorProfileBloc,
                  builder: (context , state)
                  {
                  return ExpansionTile(
                      onExpansionChanged: (value) {
                        doctorProfileBloc.add(ChangeDropDown(value));
                        //print(value);
                      },
                      children: [
                        Text("طبيب متخرج من 5 سنوات من جامعة دمشق السوريّة وخبرة عالية في طب الاسنان وجراحتها ",
                        textAlign: TextAlign.center,
                            style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizer.getTextSize(context, 0.05),
                          fontFamily: Font.fontfamily,
                          fontWeight: FontWeight.bold,
                        )
                        )
                      ],
                      trailing: Transform.translate(
                          offset: Offset(Sizer.getWidth(context)/5.5,0),
                          child: Image.asset("${Font.urlImage}${state[0]}")),

                      title: Transform.translate(
                        offset: Offset(-Sizer.getWidth(context)/4,0),
                        child: Text(" نبذة عن الطبيب",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizer.getTextSize(context, 0.05),
                                fontFamily: Font.fontfamily,
                                fontWeight: FontWeight.bold
                            )),
                      ));
                }
              ),
            ),
            Divider(color: Colors.white,thickness: 2),
            SizedBox(height: 15.sp),
            Container(
              height: Sizer.getHeight(context)/3,
              width: double.infinity,
              child: ListView(

                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,

                children: [
                  Container(
                   width: Sizer.getWidth(context)/2,
                   height: Sizer.getHeight(context)/10,
                   decoration: BoxDecoration(
                     color: Coloring.third3,
                     borderRadius: BorderRadius.circular(15)
                   ),
                   child: Column(
                     children: [

                       Image.asset("${Font.urlImage}clinicavatar.png"),
                       Text("عيادة السّلام",style: TextStyle(
                           color: Coloring.primary,
                           fontSize: Sizer.getTextSize(context, 0.05),
                           fontFamily: Font.fontfamily,
                           fontWeight: FontWeight.bold
                       )),
                       Text("دمشق - الميدان ",style: TextStyle(
                           color: Coloring.primary,
                           fontSize: Sizer.getTextSize(context, 0.05),
                           fontFamily: Font.fontfamily,
                           //fontWeight: FontWeight.bold
                       )),
                       MaterialButton(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8)),
                         onPressed: () {
                           // RouterNav.fluroRouter.navigateTo(context,
                           //     routeSettings: RouteSettings(arguments:
                           //     {'id' : state.doctor!.doctors![index].id}),
                           //     RouteName.ProfileDoctor+"/${state.doctor!.doctors![index].id}" );
                         },
                         color: Coloring.third4,
                         child: Text("احجز الآن ",
                             style: TextStyle(
                                 color: Colors.white,
                                 fontSize:
                                 Sizer.getTextSize(context, 0.05),
                                 fontWeight: FontWeight.bold,
                                 fontFamily: Font.fontfamily)),
                       ),
                     ],
                   ),

                 ),
                  SizedBox(width: 10),
                  Container(
                      width: Sizer.getWidth(context)/2,
                      decoration: BoxDecoration(
                          color: Coloring.third3,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          Image.asset("${Font.urlImage}clinicavatar.png"),
                          Text("عيادة السّلام",style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getTextSize(context, 0.05),
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold
                          )),
                          Text("دمشق - الميدان ",style: TextStyle(
                            color: Coloring.primary,
                            fontSize: Sizer.getTextSize(context, 0.05),
                            fontFamily: Font.fontfamily,
                            //fontWeight: FontWeight.bold
                          )),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: () {
                              // RouterNav.fluroRouter.navigateTo(context,
                              //     routeSettings: RouteSettings(arguments:
                              //     {'id' : state.doctor!.doctors![index].id}),
                              //     RouteName.ProfileDoctor+"/${state.doctor!.doctors![index].id}" );
                            },
                            color: Coloring.third4,
                            child: Text("احجز الآن ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                    Sizer.getTextSize(context, 0.05),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font.fontfamily)),
                          ),
                        ],
                      ),
                  ),
                  SizedBox(width: 10),
                  Container(
                      width: Sizer.getWidth(context)/2,
                      height: Sizer.getHeight(context)/5,
                      decoration: BoxDecoration(
                          color: Coloring.third3,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          Image.asset("${Font.urlImage}clinicavatar.png"),
                          Text("عيادة السّلام",style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getTextSize(context, 0.05),
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold
                          )),
                          Text("دمشق - الميدان ",style: TextStyle(
                            color: Coloring.primary,
                            fontSize: Sizer.getTextSize(context, 0.05),
                            fontFamily: Font.fontfamily,
                            //fontWeight: FontWeight.bold
                          )),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: () {
                              // RouterNav.fluroRouter.navigateTo(context,
                              //     routeSettings: RouteSettings(arguments:
                              //     {'id' : state.doctor!.doctors![index].id}),
                              //     RouteName.ProfileDoctor+"/${state.doctor!.doctors![index].id}" );
                            },
                            color: Coloring.third4,
                            child: Text("احجز الآن ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                    Sizer.getTextSize(context, 0.05),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font.fontfamily)),
                          ),
                        ],
                      ),
                  )
              ]),
            )
          ],
        )
      /*else{
              return Text("No Data");
            }*/
    );
  }

  MyAppBar() {
    return Code.AppBarProfile(_scaffoldkey, context);
  }
}