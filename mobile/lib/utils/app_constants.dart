class AppConstants{

  static final String BaseUrl = "http://192.168.1.33:80/";

  static final String PopularProductsURI = "api/v1/products/popular";
  static final String RecommendedProductsURI = "api/v1/products/recommended";

  //user, register and login
  static final String RegisterURI = "api/v1/auth/register";
  static final String LoginURI = "api/v1/auth/login";
  static final String UserURI = "api/v1/customer/info";
  static final String AddAddressURI = "api/v1/customer/address/add";
  static final String GetAllAddressURI = "api/v1/customer/address/list";
  static final String PlaceOrderURI = "api/v1/customer/order/place";
  static final String GetOrderURI = "api/v1/customer/order/list";

  //address
  static final String UserAddress = "user_address";
  static final String GeoCodeURI = "api/v1/config/geocode-api";


  static final String uploadImg = 'uploads/';

  //shared preference
  static final String TOKEN = "DBToken";
  static final String CartList_SH_P = 'cart_list';
  static final String CartHistoryList_SH_P = 'cart_history_list';

  //auth pages
  static final String SIGNUP = 'Sign up';
  static final String LOGIN = 'Log in';
  static final String HAVEACCOUNT = 'Already have an account!';
  static final String DONTHAVEACCOUNT = 'Don\'t have an account!';

}