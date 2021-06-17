import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

late final FirebaseApp app;

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(app: app,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FirebaseApp app;
  MyHomePage({required this.app});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

late DatabaseReference linksRef;

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    linksRef = FirebaseDatabase.instance.reference().child('Links');
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    database.reference().child('Links').get().then((DataSnapshot? snapshot) {
      Map<dynamic, dynamic> values = snapshot!.value;
      if(values.isNotEmpty) {
        imageList.clear();
        values.forEach((key, values) {
          imageList.add(values);
        });
      }
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    linksRef.keepSynced(true);
  }

  List<String> imageList = [
    "https://i.pinimg.com/236x/70/50/58/70505806e5a1b3a87c4c1c2091051b8f--india-fashion-floral-shorts.jpg",
    "https://bloggerspassion.com/wp-content/uploads/2021/03/Manvi-Gandotra-fashion-blogger.jpg",
    "https://blog.grabon.in/wp-content/uploads/2014/10/top-indian-fashion-blogger.jpg",
    "https://assets.teenvogue.com/photos/5b3ceaea155483623a883817/16:9/w_1600,c_limit/how-to-be-a-fashion-blogger-keiko-lynn-fb.jpg",
    "https://cdn.buttercms.com/7DToqIKKTTCjlFnz1DmI",
    "https://media.theeverygirl.com/wp-content/uploads/2015/03/budget-friendly-fashion-bloggers-8.jpg",
    "https://i.pinimg.com/originals/5d/33/98/5d339842814b897c011cdd24fe10f5be.jpg",
    "https://cdn.augrav.com/online/jewels/2016/02/Masoom-Minawala-Style-Fiesta-Diaries.jpg",
    "https://www.thegirlatfirstavenue.com/wp-content/uploads/2017/10/IMG_1339.jpg",
    "https://cdn.augrav.com/online/jewels/2016/02/Akansha-Redhu-Fashion-blogger-india.jpg",
    "https://cdn.augrav.com/online/jewels/2016/02/Manvi-Gandotra-1024x683.jpg",
    "https://cdn.augrav.com/online/jewels/2016/02/Ritu-Arya-Razzle-Dazzle-Pickle-blog.jpg",
    "https://cdn.augrav.com/online/jewels/2016/02/Arushi-Khosla-Aesthete-Khosla-fshionista-blog.jpg",
    "https://www.beyondpinkworld.com/Assets/News/3329/BP_1_636908176225855568.jpg",
    "https://3.bp.blogspot.com/-VEi550gn0GE/WaWFHjudH9I/AAAAAAAAKDA/mAW_cOnk04YMqSBd1YqbYVXWtj2vJp02wCLcBGAs/s1600/bangalore%2Bfashion%2Bblogger%2Bstyling%2Btulle%2Bskirt%2Bindian%2Bwomen%2Bgirls%2B%25281%2529.jpg",
    "https://qph.fs.quoracdn.net/main-qimg-00c7c42c29d3f10b7d7358fb9626553d",
    "https://i.pinimg.com/236x/4f/25/10/4f25108d60f9a30329743a7e638237ed.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white24,
        appBar: AppBar(
          title: Text("Staggered Layout"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          margin: EdgeInsets.all(12),
          child:  StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                          Radius.circular(30))
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(15)),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: imageList[index],fit: BoxFit.cover,),
                  ),
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.fit(1);
                //return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
              }),
        ),
      ),
    );
  }
}