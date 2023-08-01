import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Screen/welcomePage/welcom0.dart';
import 'package:clinicassistant/blocNotification/bloc.dart';
import 'package:clinicassistant/blocNotification/event.dart';
import 'package:clinicassistant/blocNotification/state.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/services/notification_services.dart';
import 'package:clinicassistant/widgets/Connectivity/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'Constant/color.dart';

/*@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  print('[BackgroundFetch] Headless event received.');
  // Do your work here...
  BackgroundFetch.finish(taskId);
}
*/

NotificationSocketBloc notificationSocketBloc = NotificationSocketBloc(
    NotificationSocketState(
        getNumberOfUnReadState: GetNumberOfUnReadState(num: 0)));
NotificationService notificationService = NotificationService();
void listenToNotificationStream() =>
    notificationService.behaviorSubject.listen((payload) {});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // isLogin = await Code.getDataLogin('isLogin');
  // token = await Code.getData('token');

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  SharedBloc sharedBloc = SharedBloc(sharedPreferences: sharedPreferences);
  Connectivity connectivity = Connectivity();
  ConnectivityResult result = await connectivity.checkConnectivity();
  RouterNav.setupRouter();
  IO.Socket socket = IO.io(
      API.BaseUrlBack,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setReconnectionDelay(5)
          .setQuery({"token": "${sharedPreferences.getString('token')}"})
          .build());
  socket.onError((data) => print("Error in Connecting is : $data"));
  socket.onConnect((data) {
    print('connect...');
    // socket.emit('msg', 'test');
  });
  socket.on("notification", (data) {
    print("Notification Coming : $data");
    notificationService.showLocalNotification(
        id: 0, title: "مساعد العيادات", body: data['message'], payload: "???");
  });
  socket.on('numberOfUnRead', (data) {
    print("Data ====> $data");
    notificationSocketBloc
        .add(AddNumberOfUnReadNotificationEvent(num: data['numberOfUnRead']));
  });
  listenToNotificationStream();
  notificationService.initializePlatformNotifications();

  runApp(
    DevicePreview(
        enabled: true,
        builder: (context) => MultiBlocProvider(providers: [
              BlocProvider<SharedBloc>(create: (context) => sharedBloc),
              BlocProvider<ConnectivityBloc>(
                create: (context) => ConnectivityBloc(result)..startListening(),
              )
            ], child: MyApp())),
  );
  //BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Coloring.primary,
    ));

    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: (context, child) {
        ScreenUtil.init(context, minTextAdapt: true, splitScreenMode: true);
        ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.resize(1024, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        );
        return DevicePreview.appBuilder(context, child);
      },
      debugShowCheckedModeBanner: false,
      title: 'مساعد العيادات',
      theme: ThemeData(
        primaryColor: Coloring.primary,
        fontFamily: Font.fontfamily,
      ),
      home: Welcome0(),

      //initialRoute: "/",
      // routes: {
      //   '/' : (context) => Welcome1(),
      //   '/welcome2' : (context)=>Welcome2(),
      //   '/welcome3' : (context)=>Welcome3(),
      //   '/welcome4' : (context)=>Welcome4(),
      //   '/home' : (context) => Home(),
      //   '/home/allclinics':(context) => AllClinics(),
      //   '/home/alldoctors' : (context) => AllDoctors(),
      //},
    );
  }
}
