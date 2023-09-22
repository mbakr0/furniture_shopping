
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:furniture_shopping/model/cartModel.dart';
import 'package:furniture_shopping/model/item.dart';
import 'package:furniture_shopping/ui/components/PriceTag.dart';
import 'package:furniture_shopping/ui/components/ProductName.dart';
import 'package:furniture_shopping/ui/favorite/favorite.dart';
import 'package:furniture_shopping/ui/home/cart/cart.dart';
import 'package:furniture_shopping/ui/home/productDetails/productDetails.dart';
import 'package:furniture_shopping/ui/profile/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../model/mainIconModel.dart';
import '../../theme/color_schemes.g.dart';
import '../components/bagContainer.dart';
import '../notification/notification.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<MainIconModel> mainIconModel = [];
  int _selectedIndex = 0;

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse){
        if (!isScrollingDown)
          {
            isScrollingDown = true;
            _showAppbar = false;
            setState(() {});
          }
      }
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward)
        {
          if (isScrollingDown)
            {
              isScrollingDown = false;
              _showAppbar = true;
              setState(() {});
            }
        }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  void _getMainIconModel() {
    mainIconModel = MainIconModel.getMainIconModel();
  }


  void _onItemTapped(int index) {
    setState(() {
      if(index == 0 && index  == _selectedIndex)
        {
          _scrollViewController.animateTo(
              0.0,
              duration:  const Duration(milliseconds: 500),
              curve: Curves.easeOut
          );
        }
      _selectedIndex = index;
      _showAppbar = true;
    });
  }





  @override
  Widget build(BuildContext context) {
    _getMainIconModel();


    final screens = [
      HomePage(scrollViewController:_scrollViewController,selectedIndex: _selectedIndex),
      Favorite(scrollController:_scrollViewController,selectedIndex: _selectedIndex,),
      NotificationPage(scrollController:_scrollViewController,selectedIndex: _selectedIndex,),
      Profile()
    ];
    return ChangeNotifierProvider(
      create: (context) => Item.forProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(context),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home",activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border),label: "BookMark",activeIcon: Icon(Icons.bookmark)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none_outlined),label: "Notifications",activeIcon: Icon(Icons.notifications)),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: "Profile",activeIcon: Icon(Icons.person))
        ],
          type: BottomNavigationBarType.fixed,
          selectedItemColor: onPrimary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: _showAppbar ? 56.0 : 0.0,
      bottom: buildTabBar(),
      scrolledUnderElevation: 0,
      actions: [
        getRightAction(),
        const SizedBox(width: 20,)
      ],
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: getRightTitle()
    );
  }

  PreferredSize buildTabBar(){
    switch(_selectedIndex){
      case 0: {
        return
          PreferredSize(preferredSize: const Size(double.infinity,100), child: TapSection(mainIconModel: mainIconModel));
      }
      default: return const PreferredSize(preferredSize: Size(0,0),child: SizedBox(),);
    }
  }

  getRightTitle() {
    switch(_selectedIndex){
      case 0 : {
        return Column(
          children: [
            Text("Make home",style: GoogleFonts.gelasio(fontWeight: FontWeight.normal,fontSize: 18,color: dateColor)),
            Text("BEAUTIFUL",style: GoogleFonts.gelasio(fontWeight: FontWeight.bold,fontSize: 18,color: onSurface)),
          ],
        );
      }
      case 1: {
        return  Text("Favorites",style: GoogleFonts.merriweather(fontWeight: FontWeight.bold,fontSize: 18,color: onSurface));
      }
      case 2: {
        return Text("Notification",style: GoogleFonts.merriweather(fontWeight: FontWeight.bold,fontSize: 18,color: onSurface));
      }
      case 3: {
        return Text("Profile",style: GoogleFonts.merriweather(fontWeight: FontWeight.bold,fontSize: 18,color: onSurface));
      }

    }
  }

  getRightAction() {
    switch(_selectedIndex) {
      case 0 || 1: {
        return Consumer<CartModel>(
          builder: (context,cart,child) {
            return Badge(
              textColor: onPrimary,
              backgroundColor: primaryContainer,
              isLabelVisible: (cart.items.isNotEmpty) ? true: false,
              label: Text(cart.items.length.toString()),
              child: IconButton(onPressed: (){
                final pageRoute = PageTransition(type: PageTransitionType.fade,alignment: Alignment.topLeft,child:const Cart(),childCurrent: widget);
                pageRoute;
                Navigator.push(context,pageRoute);
              }, icon:  const Icon(Icons.shopping_cart_outlined,color: onSecondary),),
            );
          }
        );
      }
      case 3:{
        return IconButton(onPressed: (){
          FirebaseAuth.instance.signOut();
        }, icon: const Icon(Icons.logout,color: onSecondary,),);
      }
      default: return const SizedBox(width: 20,);
    }

  }

}



class HomePage extends StatelessWidget {
  final ScrollController scrollViewController;
  final int selectedIndex;

  const HomePage({
    super.key, required this.scrollViewController, required this.selectedIndex,
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 20, color: Colors.transparent),
        GridSection(scrollViewController: scrollViewController,selectedIndex: selectedIndex)

      ],
    );
  }
}

class GridSection extends StatefulWidget {
  final ScrollController scrollViewController;
  final int selectedIndex;
  const GridSection({
    super.key, required this.scrollViewController, required this.selectedIndex,
  });

  @override
  State<GridSection> createState() => _GridSectionState();
}

class _GridSectionState extends State<GridSection> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Consumer<Item>(
          builder: (context,item,child) {
            final List<Item> items = item.getAllItems();
            return GridView.builder(
                controller: (widget.selectedIndex == 0) ? widget.scrollViewController: ScrollController(),
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,mainAxisExtent: 320,crossAxisSpacing: 10
                ),
                itemCount: items.length,
                itemBuilder: (context,index){ return SizedBox(
                  height: 300,
                  width: 150,
                  child: GridViewItem(index:index,item:items[index]),
                );});
          }
        )
    );
  }
}

class TapSection extends StatefulWidget {
  const TapSection({
    super.key,
    required this.mainIconModel,
  });

  final List<MainIconModel> mainIconModel;

  @override
  State<TapSection> createState() => _TapSectionState();
}

class _TapSectionState extends State<TapSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.mainIconModel.length,
        padding: const EdgeInsets.only(left: 20, right: 20),
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 60,
            child: CustomTap(
                index:index,
                textColor: widget.mainIconModel[index].textColor,
                fillColor:widget.mainIconModel[index].fillColor ,
                color: widget.mainIconModel[index].color,
                assetPath: widget.mainIconModel[index].path,
                name: widget.mainIconModel[index].name),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const CustomVerticalDivider();
        },
      ),
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(width: 25, color: Colors.transparent);
  }
}

class CustomTap extends StatefulWidget {
  final String assetPath;
  final String name;
  final Color color;
  final Color fillColor;
  final Color textColor;
  final int index;

  const CustomTap(
      {super.key,
        required this.textColor,
        required this.fillColor,
        required this.color,
        required this.assetPath,
        required this.name,
        required this.index});

  @override
  State<CustomTap> createState() => _CustomTapState();
}

class _CustomTapState extends State<CustomTap> {
  bool active = false;
  @override

  @override
  Widget build(BuildContext context) {
    if(widget.index == 0){
      active = true;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer<Item>(
          builder: (context,item,child) {
            return Ink(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color:  (active)?Colors.black:widget.color
                ),

                child: InkWell(
                  onTap: (){
                    item.setCategory(widget.name.toLowerCase(),!active);
                    setState(() {
                      active = !active;
                    });
                  },
                  splashColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ImageIcon(
                      color: (active)?Colors.white:widget.fillColor,
                      AssetImage(widget.assetPath),
                    ),
                  ),
                ));
          }
        ),
        const SizedBox(height: 10),
        Text(
          widget.name,
          style: GoogleFonts.nunitoSans(fontSize: 14,color: (active)?Colors.black:widget.textColor),
        )
      ],
    );
  }
}

class GridViewItem extends StatelessWidget {
  final int index;
  final Item item;
  const GridViewItem({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Ink(
            height: 250,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: AssetImage(item.imagePath),fit: BoxFit.contain),
            ),
              child: InkWell(
                onTap:  (){
                  Navigator.push(context,
                      PageTransition(type: PageTransitionType.fade,child: ProductDetail(item:item))
                  );
                },
                borderRadius: BorderRadius.circular(12),
              ),
          ),
            const BagContainer()
          ],
        ),
        const SizedBox(height: 6),
        ProductName(name:item.title),
        const SizedBox(height: 4),
        PriceTag(price:item.price)
      ],
    );
  }

}
