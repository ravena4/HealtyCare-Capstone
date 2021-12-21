import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy_care/service/home_page_controller.dart';
import 'package:healthy_care/model/historyitem.dart';
import 'package:healthy_care/screens/home/result.dart';
import 'package:healthy_care/screens/menu.dart';
import 'package:healthy_care/service/notification_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationService notificationService = NotificationService();
  await notificationService.initNotification(flutterLocalNotificationsPlugin);
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryItemAdapter());
  await Hive.openBox<HistoryItem>('history');
  runApp(HealtyCare());
}

class HealtyCare extends StatelessWidget {
const HealtyCare({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => HomePageController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
        ),
        home: BottomNavPage(),
        routes: {
          ResultsPage.routeName: (context) => ResultsPage(),
        },
      ),
    );
  }
}
