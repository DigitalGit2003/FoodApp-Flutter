import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/modles/categories_modle.dart';
import 'package:food_app/modles/food_categories_modle.dart';
import 'package:food_app/modles/food_modle.dart';
import 'package:food_app/provider/my_provider.dart';
import 'package:food_app/screen/cart_page.dart';
import 'package:food_app/screen/categories.dart';
import 'package:food_app/screen/detail_page.dart';
import 'package:food_app/screen/welcome_page.dart';
import 'package:food_app/screen/widget/bottom_Container.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1st
  List<CategoriesModle> burgerList = [];
  //2nd
  List<CategoriesModle> recipeList = [];
  //3rd
  List<CategoriesModle> pizzaList = [];
  //4th
  List<CategoriesModle> drinkList = [];

  List<FoodModle> singleFoodList = [];

  List<FoodCategoriesModle> burgerCategoriesList = [];
  List<FoodCategoriesModle> recipeCategoriesList = [];
  List<FoodCategoriesModle> pizzaCategoriesList = [];
  List<FoodCategoriesModle> drinkCategoriesList = [];

  Widget categoriesContainer(
      {required VoidCallback onTap,
      required String image,
      required String name}) {
    // print("manan))))))))))))))))))))");
    // print(image);
    image = image.trim();
    print(image);
    print(name);

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,   // 
          child: Container(
            margin: EdgeInsets.only(left: 7),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(image)),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget drawerItem(
      {required String name, required IconData icon, Function? fun}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        name,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      onTap: () {
        fun!();
      },
    );
  }

  ////1st
  Widget burger() {
    print("debugging : #############\n");
    print(burgerList);

    return Row(
      children: burgerList
          .map((e) => categoriesContainer(
                image: e.image,
                name: e.name,
                onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Push the replacement route here.
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Categories(
                        list: burgerCategoriesList,
                      ),
                    ),
                  );
                }),
              ))
          .toList(),
    );
  }

////2nd
  Widget recipe() {
    return Row(
      children: recipeList
          .map((e) => categoriesContainer(
                image: e.image,
                name: e.name,
                onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          Categories(list: recipeCategoriesList),
                    ),
                  );
                }),
              ))
          .toList(),
    );
  }

  //3rd
  Widget pizza() {
    return Row(
      children: pizzaList
          .map(
            (e) => categoriesContainer(
              image: e.image,
              name: e.name,
              onTap: () => WidgetsBinding.instance.addPostFrameCallback((_){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(list: pizzaCategoriesList),
                  ),
                );
              }),
            ),
          )
          .toList(),
    );
  }

  /////4th
  Widget drink() {
    return Row(
      children: drinkList
          .map(
            (e) => categoriesContainer(
              image: e.image,
              name: e.name,
              onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(list: drinkCategoriesList),
                  ),
                );
              }),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String email = user?.email ?? "";
    MyProvider provider = Provider.of<MyProvider>(context);

    // ####################### Food Categories(like burger, pizza, drink, ice-cream...) #####################
    // 1st
    provider.getBurgerCategory();
    burgerList = provider.throwBurgerList();
    print("!!!!!!!!!!!!!final!!!!!!!!!");
    if (burgerList.isEmpty) {
      print("failed: empty");
    } else {
      print("success: not empty");
    }
    // print(burgerList[0].image);

    //2nd
    provider.getRecipeCategory();
    recipeList = provider.throwRecipeList();
    //3rd
    provider.getDrinkCategory();
    drinkList = provider.throwDrinkList();
    // 4th
    provider.getPizzaCategory();
    pizzaList = provider.throwPizzaList();

    // ####################### Single Food List (like demo of each food categories...one peice of burger, one of pizza...) #####################
    provider.getFoodList();
    singleFoodList = provider.throwFoodModleList;


    // ####################### Perticular Food's Categories (like Burger can be of many types) #####################
    // 1st
    provider.getBurgerCategoriesList();
    burgerCategoriesList = provider.throwBurgerCategoriesList;
    // 2nd
    provider.getrecipeCategoriesList();
    recipeCategoriesList = provider.throwRecipeCategoriesList;
    // 3rd
    provider.getPizzaCategoriesList();
    pizzaCategoriesList = provider.throwPizzaCategoriesList;
    // 4th
    provider.getDrinkCategoriesList();
    drinkCategoriesList = provider.throwDrinkCategoriesList;

    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color(0xff2b2b2b),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/background.jpg'),
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                  accountName: Text("user1"),
                  accountEmail: Text(email),
                ),
                // drawerItem(icon: Icons.person, name: "Profile"),
                drawerItem(icon: Icons.add_shopping_cart, name: "Cart", 
                  fun: (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  }
                ),
                // drawerItem(icon: Icons.shop, name: "Order"),
                Divider(
                  thickness: 2,
                  color: Colors.white,
                ),
                ListTile(
                  leading: Text(
                    "Logout from here...",
                    style: TextStyle(
                      color: Color.fromARGB(217, 225, 255, 0),
                      fontSize: 20,
                    ),
                  ),
                ),
                // Text(
                //   "Comunicate",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 20,
                //   ),
                // ),
                // drawerItem(icon: Icons.lock, name: "Change"),
                drawerItem(
                    icon: Icons.exit_to_app,
                    name: "Log Out",
                    fun: () async {
                      await FirebaseAuth.instance.signOut();
                      print("logged out");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()));
                    }),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search Food",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Color(0xff3a3e3e),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  burger(),
                  recipe(),
                  pizza(),
                  drink(),
                  // categoriesContainer(
                  //     onTap: () {}, image: 'images/1.png', name: "All"),
                  // categoriesContainer(
                  //     onTap: () {}, image: 'images/2.png', name: "Burger"),
                  // categoriesContainer(
                  //     onTap: () {}, image: 'images/3.png', name: "Recipe"),
                  // categoriesContainer(
                  //     onTap: () {}, image: 'images/4.png', name: "Pizza"),
                  // categoriesContainer(
                  //     onTap: () {}, image: 'images/5.png', name: "Drink"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 510,
              child: GridView.count(
                  shrinkWrap: false,
                  primary: false,
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: singleFoodList
                      .map(
                        (e) => BottomContainer(
                          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context)   => DetailPage(
                                  image: e.image,
                                  name: e.name,
                                  price: e.price,
                                ),
                              ),
                            );
                          }), 
                          image: e.image,
                          price: e.price,
                          name: e.name,
                        ),
                      )
                      .toList()
                  // children: [
                  //   // bottonContainer(
                  //   //   image: 'images/2.png',
                  //   //   name: 'burger1',
                  //   //   price: 12,
                  //   // ),
                  //   // bottonContainer(
                  //   //   image: 'images/2.png',
                  //   //   name: 'burger1',
                  //   //   price: 12,
                  //   // ),
                  //   // bottonContainer(
                  //   //   image: 'images/2.png',
                  //   //   name: 'burger1',
                  //   //   price: 12,
                  //   // ),
                  //   // bottonContainer(
                  //   //   image: 'images/2.png',
                  //   //   name: 'burger1',
                  //   //   price: 12,
                  //   // ),
                  // ],
                  ),
            )
          ],
        ),
      ),
    );
  }
}
