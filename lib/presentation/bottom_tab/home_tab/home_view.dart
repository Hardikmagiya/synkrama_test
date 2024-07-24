import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:untitled/resources/common_widgets.dart';
import 'package:untitled/utils/strings_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    showShimmer();
    super.initState();
  }

  showShimmer(){
    Future.delayed(Duration(seconds: 5)).then(
          (value) {
        isLoading = false;
        setState(() {
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(strHomePage,style: TextStyle(color: Colors.white),),
        surfaceTintColor: Colors.blue,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: Skeletonizer(
          enabled: isLoading,
          child: ListView(
            children: <Widget>[
              heightBox(10.h),
              Text(
                strHorizontalListview,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
              heightBox(10.h),
              SizedBox(
                height: 110.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(imageList[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 90,
                    );
                  },
                ),
              ),
              heightBox(10.h),
              Text(
                strVerticalListview,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600
                ),
              ),
              heightBox(10.h),
              SizedBox(
                height: 300.h,
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(imageList[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              heightBox(10.h),
              Text(
                strGridview,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600
                ),
              ),
              heightBox(10.h),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.8,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imageList[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
