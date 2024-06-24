abstract class API {
  // API BASE URL
  static const BASE_URL = 'https://ms.itmd-b1.com:5123/api';
  // AUTHENTICATION
  static const LOGIN = '$BASE_URL/login';
  static const REGISTER = '$BASE_URL/register';
  static const RESET_PASSWORD = '$BASE_URL/forgot-password';

  // COMPANY
  static const COMPANIES = '$BASE_URL/Companies';

  // CONTACTS
  static const CONTACTS = '$BASE_URL/Contacts';

  // USERS
  static const USERS = '$BASE_URL/Users';
  static const CURRENT_USER = '$USERS/current-user';


  
}
