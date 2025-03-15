class Urls {
  static const String _baseUrl = "https://ecommerce-api.codesilicon.com/api";

  static String sendEmailOtp(String email) => "$_baseUrl/UserLogin/$email";

  static String verifyOtp(String email, String otp) =>
      "$_baseUrl/VerifyLogin/$email/$otp";
  static String readProfile = "$_baseUrl/ReadProfile";
  static String createProfile = "$_baseUrl/CreateProfile";
  static String homeBanner = "$_baseUrl/ListProductSlider";
  static String categoryList = "$_baseUrl/CategoryList";
  static String popularProduct = "$_baseUrl/ListProductByRemark/Popular";
  static String specialProduct = "$_baseUrl/ListProductByRemark/Special";
  static String newProduct = "$_baseUrl/ListProductByRemark/New";
  static String trendingProduct = "$_baseUrl/ListProductByRemark/Trending";
  static String topProduct = "$_baseUrl/ListProductByRemark/Top";
  static String regularProduct = "$_baseUrl/ListProductByRemark/Regular";
  static String brandList = "$_baseUrl/BrandList";

  static String productListByBrand(int brandId) =>
      "$_baseUrl/ListProductByBrand/$brandId";

  static String productsByCategory(int categoryId) =>
      "$_baseUrl/ListProductByCategory/$categoryId";

  static String productDetails(int productId) =>
      "$_baseUrl/ProductDetailsById/$productId";

  static String addToCart = "$_baseUrl/CreateCartList";
  static String cartList = "$_baseUrl/CartList";

  static String deleteCartList(int cartItemId) =>
      "$_baseUrl/DeleteCartList/$cartItemId";

  static String createInvoice = "$_baseUrl/InvoiceCreate";
  static String invoiceList = "$_baseUrl/InvoiceList";

  static String invoiceProductList(invoiceId) =>
      "$_baseUrl/InvoiceProductList/$invoiceId";

  static String policy = "$_baseUrl/PolicyByType/about";
  static String productWishList = "$_baseUrl/ProductWishList";

  static String createWishList(productId) =>
      "$_baseUrl/CreateWishList/$productId";

  static String removeWishList(productId) =>
      "$_baseUrl/RemoveWishList/$productId";

  static String reviewList(productId) =>
      "$_baseUrl/ListReviewByProduct/$productId";
  static String createReview = "$_baseUrl/CreateProductReview";
}
