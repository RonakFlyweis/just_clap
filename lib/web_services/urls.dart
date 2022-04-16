final baseUrl = 'https://brijesh-patel.herokuapp.com';
final imageBaseUrl = 'https://brijesh-patel.herokuapp.com/upload/image/';
class UserUrl {
  static String otpSend = baseUrl + '/api/userOtp';
  static String verifyOtp = baseUrl + '/api/verifyOtp';
  static String addUserDetail = baseUrl + '/api/userdetail';
  static String getSingleUser = baseUrl + '/api/getuser';
  static String updateUserDetail = baseUrl + '/api/updateuser';
}

class Support {
  static String addSupport = baseUrl + '/api/addsupport';
}

class Category {
  static String getCategory = baseUrl + '/api/getcategory';
  static String getSubCategory = baseUrl + '/api/getsubcategory';
  //TODO implement get subcategory by category
  // static String getSubCategoryByCategoryId = baseUrl + '';
}

class Services {
  static String getServiceProvider = baseUrl + 'api/getservice';
}

class Review {
  static String addReview = baseUrl + '/api/addreview';
  static String getALlReviewByUser = baseUrl + '/api/getreview';
  static String getALlReview = baseUrl + '/api/getallreview';
}

class Address {
  static String addAdress = baseUrl + '/api/addaddress';
  static String getAddress = baseUrl + '/api/getaddress';
}

class Booking {
  static String addBooking = baseUrl + '/api/Booking';
  static String getBooking = baseUrl + '/api/getbooking';
  static String getBookingAfter = baseUrl + '/api/getafterdate';
  static String getBookingBefore = baseUrl + '/api/getbeforedate';
  static String deleteBooking = baseUrl + '/api/deletebooking';
}

class Favourite {
  // TODO Implement favourite requests
}

class AddNotification {
  static String addNotification = baseUrl + '/api/addnotification';
  static String getNotification = baseUrl + '/api/getNotification';
  static String deleteNotification = baseUrl + '/api/deletenotification';
}

class Offer {
  static String addOffer = baseUrl + '/api/offer';
  static String getOffer = baseUrl + '/api/getoffer';
}
