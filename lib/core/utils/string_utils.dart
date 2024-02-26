class AppStrings {
  static const appName = '10Paisa 🚀';
  static const defaultPicture =
      'https://res.cloudinary.com/dio3qwd9q/image/upload/v1703030558/ktsqwgc2zpeiynaekfct.png';
  static const defaultAmount = 100000;
  static const defaultPort = 0;
  static const defaultInvStyle = 0;
  static const defaultIsAdmin = false;
  static const defaultToken = 'Empty';
  static const appTagline = 'Investing made easy';
  static const appVersion = 'version : 1.8';
  static const appDeveloper = 'Developed by: Suraj Rimal';
  static Duration duration = const Duration(milliseconds: 400);
}

//splash
class SplashStrings {
  static const splashScreenTitle = '10Paisa';
  static const splashScreenSubtitle = 'Investing made easy';
  static const splashImage = 'assets/logos/logo.png';
  static const splashAnimationPath = 'assets/animation/loading/loading1.json';
}

//login
class LoginStrings {
  static const sampleid = 'test@test.com';
  static const samplePassword = '00000';
  static const samplePhone = '9840000000';
  static const sampleName = 'Test User';
  static const labelEmailHint = 'Email';
  static const labelPasswordHint = 'Password';
  static const loginText = 'Login to 10Paisa';
  static const loginSubText = 'Please enter your Email and Password';
  static const loginImage = 'assets/images/blite.png';
  static const forgetpassword = 'Forget Password';
  static const signin = 'Sign In';
  static const noAccount = 'Don\'t have an account?';
  static const signup = ' Sign Up';
  static const enterEmail = 'Enter yours email';
  static const passHint = 'Password';
  static const rememberMe = 'Remember Me';
  static const socalLogin = 'Or Social Login with';
}

//error
class ErrorStrings {
  static const linkBrokenAsset = 'assets/images/broken_link.png';
  static const notFound = 'Not Found';
  static const subTitle =
      'The link you followed may be broken,\nor the page may have been removed.';
  static const errorButton = 'Go Back';
  static const errorAnimation = 'assets/animation/notfound/notfound.json';
}

//onboarding

class OnBoarding {
  static const getStarted = 'Get Started Now';
  static const skip = 'Skip';
}

class OnBoardingStrings {
  //final String img;
  final String animation;
  final String title;
  final String subTitle;

  OnBoardingStrings({
    //required this.img,
    required this.animation,
    required this.title,
    required this.subTitle,
  });
}

List<OnBoardingStrings> listOfItems = [
  OnBoardingStrings(
    animation: 'assets/animation/others/others (4).json',
    title: "Best app to transform\nsmall investment to big amount",
    subTitle:
        "An investment in knowledge \npays the best interest. -Benjamin Franklin",
  ),
  OnBoardingStrings(
    animation: 'assets/animation/others/others (2).json',
    title: "Different Opportunities for your\ndifferent investment needs",
    subTitle:
        "Personalized Investment opportunities\n according to your financial goal",
  ),
  OnBoardingStrings(
    animation: 'assets/animation/others/others (3).json',
    title: "Start early with SIPs,\nand let time work its magic.",
    subTitle:
        "Wide variety of SIP, Mutual funds and \nbonds options available in same app",
  ),
];

class NotFound {
  static const animationPath = 'assets/animation/notfound/404.json';
}

class AuthStrings {
  static const authImage = 'assets/images/blite.png';
}

class RegisterStrings {
  static const registerText = 'Sign Up to 10Paisa';
  static const registerSubText = 'Create a new 10Paisa account';
  static const enterNameHint = 'Enter Name';
  static const enterEmailHint = 'Enter Email';
  static const enterPhoneHint = 'Enter Phone';
  static const enterPasswordHint = 'Enter Password';
  static const signupButtonText = 'Sign Up';
  static const alreadyAccount = 'Already have an account? ';
  static const signin = ' Sign In';
}

class OtpStrings {
  static const otpText = 'Email OTP Verification';
  static const otpSubText = 'Please use otp you got in your Email';
  static const otpButtonText = 'Verify Email';
  static const noOTP = 'Did not recieve OTP? ';
  static const resendOtp = 'Resend OTP';
  static const resendToast = 'Please wait';
  static const otpErrorText = 'Please enter OTP';
}

class StyleStrings {
  static const option1 = 'Your Investment Style';
  static const option2 = 'Tell us about your investment style';
  static const option3 = 'Spend and save';
  static const option4 = 'Save for retirement';
  static const option5 = 'Financial speculation';
  static const option6 = 'Others';

  static const skipText = 'Skip';
  static const continueText = 'Continue';
}

class ForgetPasswordStrings {
  static const forgetHead = 'Password recovery';
  static const forgetPasswordSubText = 'Please enter your 10Paisa Email';
  static const forgetPasswordButtonText = 'Reset Password';
  static const noAccount = 'Don\'t have an account?';
  static const signup = ' Sign Up';
  static const otpHint = 'Email OTP';
  static const verifyEmailText = 'Verify Email';
  static const otpEmpty = 'OTP cannot be empty';
  static const pleaseWait = 'Please wait';
  static const checkEmail = 'Check Email for OTP';
  static const updatePassword = 'Update Password';
  static const verifyOtpText = 'Verify OTP';
  static const signInText = ' Sign In ';
}

class DefaultUserValues {
  static const defaultName = 'Empty';
  static const defaultEmail = 'Empty';
  static const defaultPassword = 'Empty';
  static const defaultToken = 'Empty';
  static const defaultPhone = 0;
  static const defaultPicture =
      'https://res.cloudinary.com/dio3qwd9q/image/upload/v1703030558/ktsqwgc2zpeiynaekfct.png';
  static const defaultAmount = 0;
  static const defaultPort = 0;
  static const defaultInvStyle = 0;
  static const defaultIsAdmin = false;
  static const defaultWallets = 0;
}

class NewsStrings {
  static const defaultImage = 'assets/logos/news.jpg';
}

class DashboardStrings {
  static const loadingStocks = 'Loading Stocks';
  static const helloText = 'Hello';
  static const youSure = 'Are you sure?';
  static const exitApp = 'Do you want to exit the app?';
  static const yes = 'Yes';
  static const no = 'No';
}

class DialogStrings {
  static const signOutTitle = 'Are you sure?';
  static const loggingOut = 'Logging out';
  static const yes = 'Yes';
  static const no = 'No';
  static const loggedOutError = 'Not logged out';
}

class ValidatorStrings {
  static const nameEmpty = 'Name can\'t be empty';
  static const nameInvalid = 'Invalid name format';
  static const passwordEmpty = 'Password can\'t be empty';
  static const passwordLength = 'Password should be 6 characters long';
  static const emailEmpty = 'Email can\'t be empty';
  static const emailInvalid = 'Invalid email format';

  static const phoneEmpty = 'Phone can\'t be empty';
  static const phoneInvalid = 'Invalid phone format';
}

class ModelStrings {
  static const authSuccess = 'Authentication Successful';
  static const authFailed = 'Authentication Failed';
  static const updateProfilePicture = 'Updating Profile Picture';
  static const pleaseWait = 'Please wait';
  static const userDeleted = 'User Deleted';
}

class LogoutStrings {
  static const logoutText = 'Are you sure you want to logout?';
}

class FingerprintDialogStrings {
  static const biometricsTitle = 'Biometrics Login';
  static const enableFingerprint = 'Enable Fingerprint Login';
}

class PasswordSuccessDialog {
  static const successImage = 'assets/images/success.png';
  static const passwordChanged = 'Password Changed Successfully';
  static const proceedToSignin = 'Please proceed to signin';
  static const signin = 'Sign In';
}

class InputControllersStrings {
  static const email = 'suraj@rimal.com';
  static const password = '111111';
  static const phone = '9840220290';
  static const name = 'Suraj Rimal';
}

class DrawerWidgetStrings {
  static const myProfile = 'My Profile';
  static const compare = 'Compare';
  static const analytics = 'Analytics';
  static const watchlist = 'Watchlist';
  static const wallet = 'Wallet';
  static const settings = 'Settings';
  static const portfolio = 'Portfolio';
  static const search = 'Search';
  static const indicators = 'Indicators';
  static const exchangeRates = 'Forex Rates';
  static const exit = 'Exit';
}

class AddStockDialogStrings {
  static const addStock = 'Add Stock';
  static const addStockTo = 'Add Stock to: ';
}

class ProfileStrings {
  static const profile = 'Profile';
  static const camera = 'Camera';
  static const gallery = 'Gallery';
  static const name = 'Name';
  static const email = 'Email';
  static const phone = 'Phone';
  static const password = 'Password';
  static const comingSoon = 'Coming Soon';
  static const balance = 'Balance';
  static const accountGoal = 'Account Goal';
  static const admin = 'Admin';
  static const premium = 'Premium Status';
  static const account = 'Account';
  static const theme = 'Theme';
  static const biometricsLogin = 'Biometrics Login';
  static const noHardware = 'No Hardware Biometrics Sensor Found';
  static const shakeToLogout = 'Shake to Logout';
  static const logout = 'Logout';
  static const ok = 'Ok';
  static const deleteAccount = 'Delete Account';
  static const freeUser = 'Free User';
  static const premiumUser = 'Premium User 🎉';
  static const gotoWalletPage = 'Go to wallet page to load amount';
  static const adminStatusCan = 'Admin status can only changed from website';
  static const dataSources = 'Data Sources';
  static const aboutUs = 'About Us';
}

class ThemeStrings {
  static const changeTheme = 'Change Theme';
  static const theme = 'Theme';
  static const light = 'Light Mode';
  static const dark = 'Dark Mode';
  static const system = 'System Mode';
}

class DeleteDialogStrings {
  static const deleteAccount = 'Delete Account';
  static const enterPasswordText = 'Please Enter your password';
  static const delete = 'Delete';
  static const cancel = 'Cancel';
  static const passwordLabel = 'Password';
  static const passwordError = 'Please enter a password';
}

class EmailChangeDialogStrings {
  static const changeEmail = 'Change Email';
  static const currentEmail = 'Current Email: ';
  static const newEmail = 'New Email';
  static const invalidEmail = 'Invalid email';
  static const save = 'Save';
  static const cancel = 'Cancel';
  static const emailError = 'Please enter a valid email';
}

class PhoneChangeDialogStrings {
  static const changePhone = 'Change Phone';
  static const currentPhone = 'Current Phone: ';
  static const newPhone = 'New Phone';
  static const invalidPhone = 'Invalid phone';
  static const save = 'Save';
  static const cancel = 'Cancel';
  static const phoneError = 'Please enter a valid phone number';
}

class SearchStrings {
  static const search = 'Search...';
  static const hydropowerText = 'Hydropower';
  static const commercialBankText = 'Commercial Bank';
  static const financeText = 'Finance';
  static const hotelText = 'Hotel';
  static const insuranceText = 'Insurance';
  static const investmentText = 'Investment';
  static const manufacturingText = 'Manufacturing';
  static const microfinanceText = 'Microfinance';
  static const othersText = 'Others';
  static const tradingText = 'Trading';
  static const developmentBankText = 'Development Bank';
  static const mutualFundText = 'Mutual Fund';
  static const nonLifeInsuranceText = 'Non-Life Insurance';
  static const lifeInsuranceText = 'Life Insurance';
  static const debentureText = 'Debenture';

  static const List<String> searchtabs = [
    'Stocks',
    'Commodities',
    'Metals',
    'Hydropower',
    'Microfinance',
    'Insurance',
    'Development Banks',
    'Banks',
    'Finance',
    'Investment',
    'Mutual Fund',
    'Debenture'
  ];

  static const List<String> sectors = [
    'Hydropower',
    'Microfinance',
    'Insurance',
    'Development Banks',
    'Commercial Banks',
    'Finance',
    'Investment',
  ];

  static const List<String> categories = [
    'Mutual Fund',
    'Debenture',
  ];

  static const searchHint = 'Search Stocks';
  static const noStocks = 'No Stocks Found';
  static const noStocksSub = 'Please try again';
}

class LoadingText {
  static const loading = 'Loading';
  static const pleaseWait = 'Please wait';
}

class PortfolioStrings {
  static const portfolioText = 'Portfolio';
  static const createPortfolioText = 'Add Portfolio';
  static const addStockText = 'Add Stock';
  static const addStockTo = 'Add Stock to: ';
  static const selectPortfolio = 'Select Portfolio';
  static const noPortfolioSelected = 'Please select a portfolio';

  static const highestReturns = 'Highest Returns';

  static const portfolioCostWeightage = 'Portfolio Cost Weightage';
  static const currentValueWeightage = 'Current Value Weightage';

  static const renamePortfolio = 'Rename Portfolio';
  static const deletePortfolio = 'Delete Portfolio';
  static const removeAsset = 'Remove Stocks';
  static const viewPortfolio = 'View Portfolio';
  static const comparePortfolio = 'Compare Portfolio';
  static const createPortfolio = 'Create Portfolio';
  static const emptyPortfolio = 'Portfolio name is empty';
  static const emptyGoal = 'Portfolio goal is empty';

  static const portfolioName = 'Portfolio Name';
  static const portfolioGoal = 'Portfolio Goal';
  static const savePortfolio = 'Save';
  static const cancelPortfolio = 'Cancel';
  static const sureText = 'Got it';

  static const valueText = 'Value: Rs ';
  static const costText = 'Cost: Rs ';
  static const returnsText = 'Returns: ';
  static const pnl = 'P&L: ';
  static const recommendation = 'Recommendation: ';
  static const symbolText = 'Symbol';
  static const waccText = 'WACC';
  static const ltpText = 'LTP';
  static const quantityText = 'Quantity';
  static const valueTxt = 'Value';

  static const searchStock = 'Search for stock';
  static const emptyStock = 'Stock cannot be empty';
  static const stockPrice = 'Price';
  static const emptyPrice = 'Price cannot be empty';

  static const stockQuantity = 'Quantity';
  static const emptyQuantity = 'Quantity cannot be empty';
  static const quantityGreater = 'Quantity > ';

  static const deletePort = 'Delete';
  static const emptyPortfolioUrl = 'assets/logos/empty.png';
  static const deletePortfolioText = 'Are you sure you want to delete ';

  static const emptyPortoflio = 'Please create a new ';

  static const deleteStock = 'Delete Stock';
  static const nostocks = 'No portfolio contains this stock';
  static const removeStockFrom = 'Remove stock from: ';
  static const emptyStocks =
      'Portfolio is empty, please add stocks before removing them';
  static const deleteStockText = 'Are you sure you want to delete?';

  static const selectStock = 'Select Stock';
  static const myPortoflios = 'My Portfolios';
  static const viewAll = 'View All';
  static const loadingPortfolios = 'Loading Portfolios';
  static const noStocks = 'No stocks found';
  static const asOf = 'As of ';
  static const selectStockText = 'Please select a stock';

  static const editPortfolioName = 'Edit Portfolio Name';
  static const oldPortfolioName = 'Old Portfolio Name: ';
  static const newPortfolioName = 'New Portfolio Name';

  static const summaryText = 'Summary';
  static const numberOfPortfolios = 'Number of Portfolios: ';
  static const totalPortfolioCost = 'Portfolio Cost: Rs ';
  static const totalPortfolioValue = 'Portfolio Value: Rs ';
  static const totalStocks = 'Total Stocks: ';
  static const totalUnits = 'Total Units: ';
  static const totalPortfolioReturns = 'Portfolio P&L: Rs ';
}

class OfflineMode {
  static const offline = 'Offline';
  static const noConnection = 'Connection Lost';
  static const offlineSub =
      'App will now switch to offline mode.\nSome features may not work.';
  static const imagePath = 'assets/images/no-internet.png';
}

class InternetConnectedStrings {
  static const connected = 'Connected';
  static const connectedSub =
      'Connection Restored.\nApp will now switch to online mode.';
  static const imagePath = 'assets/images/worldwide.png';
}

class WatchlistStrings {
  static const loadingWatchlist = 'Loading Watchlist';
}

class StockStrings {
  static const loadingWatchlist = 'Loading Stock';
}

class WalletStrings {
  static const yourWalletAmount = 'Your Wallet Amount';
  static const noWalletAdded =
      'No wallet added, please add a wallet first to continue';
  static const yourWallets = 'Your Wallets';
  static const wallet = 'Wallet';
  static const cancelText = 'Cancel';
  static const continueText = 'Continue';
  static const addWallet = 'Add Wallet';
  static const addMoney = 'Add Money';
  static const enterAmount = '  Enter Amount';
  static const proccedText = 'Proceed';
  static const emptyAmount = 'Amount cannot be empty';

  static const chooseWallet = 'Choose Wallet';
  static const khaltiText = 'Khalti';
  static const esewaText = 'eSewa';
  static const khaltiImage = 'assets/images/paymentgateways/khalti.png';
  static const esewaImage = 'assets/images/paymentgateways/esewa.png';
}

class UrlStrings {
  static const goldUrl =
      'https://www.tradingview.com/chart/?symbol=OANDA%3AXAUUSD';
  static const silverurl =
      'https://www.tradingview.com/chart/?symbol=OANDA%3AXAGUSD';

  static const commoUrl = 'https://ramropatro.com/vegetable';
  static const googleMap = 'https://www.google.com/maps/place/Kathmandu+44600';
  static const madefor = 'https://softwarica.edu.np/';
  static const nepseUrl = 'https://www.nepsealpha.com/trading/chart';
  static const stockChart = 'https://www.nepsealpha.com/trading/chart?symbol=';
  static const nrbSite1 = 'https://www.nrb.org.np';
  static const tenpaisaurl = 'https://tenpaisa.tech/';
  static const authorGithub = 'https://github.com/surajrimal07';
  static const backendUrl = 'https://paisabackend.el.r.appspot.com/';
  static const authorEmail = 'davidparkedme@gmail.com';
  static const authorPhone = '+9779840220290';
  static const authorName = 'Suraj Rimal';
  static const authorLocation = 'Kathmandu, Nepal';
  static const authorFacebook = 'https://www.fb.me/MeetTheFlash';
  static const generalWorldMarket = 'https://www.tradingview.com/markets/';
}

class SubsString {
  static const premiumSubs = 'Premium Subscription';
  static const premiumSubsText =
      'You are already a premium member. Thank you for purchasing Premium package and supporting the application.';
  static const purchasePremium = 'Purchase Premium';
  static const choosePackage = 'Choose Subscription Package:';
  static const thankYou =
      'Thank you for purchasing Premium package and supporting the application.';
  static const noBalance =
      'Insufficient balance. Please add funds to your account.';
  static const subsNotSelected = 'Please select a subscription package';
}
