import 'package:classmate/pages/intro_page_1.dart';
import 'package:classmate/pages/intro_page_2.dart';
import 'package:classmate/pages/intro_page_3.dart';
import 'package:classmate/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {

  //controller to keep track of which page we're on
  PageController _controller = PageController();

  //keep track of if we are on the last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: [

          //page view
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },

            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          //dot indicators
          Container(
            alignment: Alignment(0,0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                GestureDetector(
                  onTap: (){
                    _controller.jumpToPage(2);
                  },
                  child: Text('skip',
                    style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                //dot indicator
                SmoothPageIndicator(controller: _controller, count: 3),
                //next or done
                onLastPage
                    ? GestureDetector(
                    onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Wrapper();
                        },
                      ),
                    );
                  },
                    child: Text('done',
                    style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                    : GestureDetector(
                    onTap: () {
                    _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn,
                    );
                  },
                    child: Text('next',
                    style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
