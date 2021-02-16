#  FNMotivation App
Future Now Motivation is a social community where everyone can share their stories about their issues for others to read, learn, engage and connect.

[You can view the website here](https://www.fnmotivation.com/)

## Pods
### Alamofire
- The URL Session Manager that makes all calls
### DLRadioButton
- Radio buttons for the Articles view
### DZNEmptyDataSet
- Display of the empty data state
### Firebase
- Third party sign in and real time database 
### GoogleSignIn
- Third party sign in from Google Firebase
### IQKeyboardManagerSwift
- Managing the visibility of the Textfileds on KeyboardWillShowNotification 
### JWTDecode
- Decoder for the JWT Token received
### KeychainSwift
- Storing and suggesting passwords in Keychain for Login
### SwiftyJSON
- Decoding JSON in Swift - deprecated
### XLPagerTabStrip
- Tab pages on the app
### SCLAlertView
- The alert controller for the app

## Architecture
The architecture revolves around MVC and MVVM as it morphs into a MVVM architecture. In the view Model is a dataObject that holds all the functions tied to the view. POST requests have been conformed to these. GET requests are currently made directly because of the need to utilize the Decodable class extensions. This was to be improved to become componentalized.

### Naming conventions
The vars and constants are named as per the specific action or object e.g usernameLabel or usernameTextField for context and using camelCase. Within request parameters, there's a mix of kebab_case and camelCase as per the API naming conventions.

### Storyboards
The UI is accurate as per spec, broken down into each storyboard named appropriately. Uses a mix of TableViews and Xibs to achieve the complex UI.

## Known Issues
JWT Token doesn't return all necessary data - missing number of followers and follows - The API also misses those.\
Notifications are still static - no endpoint\
Profile page also has partially static data, no endpoints or filters from the /notifications endpoint\
Google Sign in returns an error in the API - all correct data is sent but returns an error - the googleToken is too long\
Publishing stories always fails despite correct data being sent\
Getting Articles fails - request returns a 400-500 error\
Getting communities fails - the endpoint was changed to require auth (not as per spec)\
Story Likes button si halfway implemented, remaining to plug into the endpoint\
Share buttons exists but with static content as API response doesn't return a web url to the post\
Form Validation is implemented just not attached\


