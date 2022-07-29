# Flutter Architecture 2

## using MVVM design pattern for many reasons

1. Business logic is separate from the UI.
2. The view is independent from the ViewModel class and only reading the state from ViewModel.
3. Code will be easy to maintain and update in terms of logic & UI.
4. Easy to Write the test cases for the project.


## using those packages :

- **bloc** : for state managment there are other state managment like (provider , getx) but bloc is the most common one and recommanded by google for large app scale
- **flutter_bloc** : make it easy to implement the BLoC pattern.
- **auto_route** : simplify routing in app as everything needed for navigation is automatically generated for you
- **flutter_local_notifications** : plugin for displaying and scheduling local notifications for Flutter applications.
- **shared_preferences** : plugin for reading and writing simple key-value pairs.
- **flutter_launcher_icons** : package which simplifies the task of updating your Flutter app's launcher icon
- **url_launcher** : plugin for launching a URL. Supports web, phone, SMS, and email schemes
- **firebase_messaging** : plugin for Firebase Cloud Messaging, a cross-platform messaging solution that lets you  
  reliably deliver messages on Android and iOS.

- **firebase_core** : it's nesseccary for implementing firebase messaging
- **google_maps_flutter** : plugin for integrating Google Maps in iOS and Android applications
- **location** : plugin to easily handle realtime location in iOS and Android
- **geocode** : It exposes two methods to translate coordinates into locations and addresses into coordinates
- **photo_view** : Photo View provides a gesture sensitive zoomable widget
- **intl** : Contains code to deal with date and number formatting and parsing
- **flutter_easyloading** : clean and lightweight loading/toast widget for Flutter
- **flutter_phoenix** : Easily restart your application from scratch, losing any previous state
- **flutter_swiper** : The best swiper(carousel) for flutter, with multiple layouts
- **share** : Flutter plugin for sharing content via the platform share UI through (whatsapp,facebook and etc)
- **flutter_rounded_date_picker** : plugin that help you can choose dates and years with rounded calendars
- **map_launcher** : plugin to find available maps installed on a device
- **flutter_html** : widget rendering static HTML and CSS as Flutter widgets
- **pin_code_fields** : package which will help you to generate pin code fields. Can be useful for OTP for example
- **image_picker** : plugin for selecting images from the Android and iOS image library, and taking new pictures with the camera

- **flutter_svg** : allows painting and displaying Scalable Vector Graphics
- **json_serializable** : Automatically generate code for converting to and from JSON by annotating Dart classes
- **json_annotation** : Classes and helper functions that support JSON code generation via the `json_serializable` package
- **infinite_scroll_pagination** : Lazily load and display pages of items as the user scrolls down your screen
- **dio** : a powerful Http client for Dart, which supports Interceptors, FormData, Request Cancellation, File Downloading, Timeout etc -- there are othere libraries like (http , retrofit) but dio the most simple and powerful one.
- **flutter_inappwebview** : for opening live chat webview in the app
- **flutter_web_auth** : to handle app SSO 
- **file_picker** : a Utility to 
- **syncfusion_flutter_pdfviewer** : 
- **hijri_picker** : 
- **flutter_archive**: Un compress Micro app zip file

## Code Structure
---


```bash

lib
├── execution
│   └── screens
│       └── home
│           ├── bloc
│           ├── home.dart
│           ├── home_data.dart
│           ├── home_data_imports.dart
│           ├── models
│           │   ├── model.dart
│           │   └── repo.dart
│           └── widgets
├── furijat
│   └── screens
│       └── home
│           ├── bloc
│           ├── home.dart
│           ├── home_data.dart
│           ├── home_data_imports.dart
│           ├── models
│           │   ├── model.dart
│           │   └── repo.dart
│           └── widgets
├── general
│   ├── app.dart
│   ├── blocs
│   │   ├── auth_cubit
│   │   │   ├── auth_cubit.dart
│   │   │   └── auth_state.dart
│   │   ├── lang_cubit
│   │   │   ├── lang_cubit.dart
│   │   │   └── lang_state.dart
│   │   └── user_cubit
│   │       ├── user_cubit.dart
│   │       └── user_state.dart
│   ├── constants
│   │   ├── GlobalNotification.dart
│   │   ├── MyColors.dart
│   ├── models
│   │   ├── user.model.dart
│   │   ├── user.model.g.dart
│   ├── screens
│   │   ├── about
│   │   │   ├── about.dart
│   │   │   ├── about_data.dart
│   │   │   ├── about.imports.dart
│   │   │   └── widgets
│   │   │       ├── about_widgets.imports.dart
│   │   │       └── about_view.dart
│   │   ├── change_password
│   │   │   ├── ChangePassword.dart
│   │   │   ├── ChangePasswordData.dart
│   │   │   ├── ChangePasswordImports.dart
│   │   │   └── widgets
│   │   │       ├── BuildChangeForm.dart
│   │   │       ├── BuildSaveButton.dart
│   │   │       └── ChangePassWidgetsImports.dart
│   │   ├── confirm_password
│   │   │   ├── ConfirmPassword.dart
│   │   │   ├── ConfirmPasswordData.dart
│   │   │   ├── ConfirmPasswordImports.dart
│   │   │   └── widgets
│   │   │       ├── BuildButtonList.dart
│   │   │       ├── BuildFormInputs.dart
│   │   │       ├── BuildText.dart
│   │   │       └── ConfirmPasswordWidgetsImports.dart
│   │   ├── contact_us
│   │   │   ├── ContactUs.dart
│   │   │   ├── ContactUsData.dart
│   │   │   ├── ContactUsImports.dart
│   │   │   └── widgets
│   │   │       └── ContactUsWidgetsImports.dart
│   │   ├── forget_password
│   │   │   ├── ForgetPassword.dart
│   │   │   ├── ForgetPasswordData.dart
│   │   │   ├── ForgetPasswordImports.dart
│   │   │   └── widgets
│   │   │       ├── BuildButton.dart
│   │   │       ├── BuildFormInputs.dart
│   │   │       ├── BuildText.dart
│   │   │       └── ForgetPasswordWidgetsImports.dart
│   │   ├── login
│   │   │   ├── Login.dart
│   │   │   ├── LoginData.dart
│   │   │   ├── LoginImports.dart
│   │   │   └── widgets
│   │   │       ├── BuildForgetText.dart
│   │   │       ├── BuildFormInputs.dart
│   │   │       ├── BuildLoginButton.dart
│   │   │       ├── BuildNewRegister.dart
│   │   │       ├── BuildRegisterButton.dart
│   │   │       ├── BuildText.dart
│   │   │       └── LoginWidgetsImports.dart
│   │   ├── reset_password
│   │   │   ├── ResetPassword.dart
│   │   │   ├── ResetPasswordData.dart
│   │   │   ├── ResetPasswordImports.dart
│   │   │   ├── reset_password_cubit
│   │   │   │   ├── reset_password_cubit.dart
│   │   │   │   └── reset_password_state.dart
│   │   │   └── widgets
│   │   │       ├── BuildButton.dart
│   │   │       ├── BuildFormInputs.dart
│   │   │       ├── BuildText.dart
│   │   │       └── ResetPasswordWidgetsImports.dart
│   ├── utilities
│   │   ├── main_data
│   │   │   ├── main_data.dart
│   │   │   └── main_data.imports.dart
│   │   ├── routers
│   │   │   ├── router.dart
│   │   │   ├── router.imports.dart
│   │   │   └── router.imports.gr.dart
│   │   └── utils_functions
│   │       ├── adaptive_picker.dart
│   │       ├── api_names.dart
│   │       ├── loading_dialog.dart
│   │       ├── utils.imports.dart
│   │       └── utils.dart
│   └── widgets
│       ├── auth_header_text.dart
│       ├── auth_scaffold.dart
│       ├── default_appbar.dart
│       └── header_logo.dart
├── generated_plugin_registrant.dart
├── main.dart
├── resources.dart
└── user
    └── screens
        └── home
            ├── bloc
            ├── home.dart
            ├── home_data.dart
            ├── home_data_imports.dart
            ├── models
            │   ├── model.dart
            │   └── repo.dart
            └── widgets


```
<br>

## Testing
---

```
 test
 ├── shared
 │   ├── network
 │   │   └── network_auth_test.dart
 ├── fixtures
 │   ├── fixture_reader.dart
 │   ├── user_data.json
 │   └── user_token.json
 └── screens
     ├── home
     │   ├── home_repository_test.dart
     │   └── home_bloc_test.dart
     │   └── home_test.dart

```

## Naming Convention
---
<br>

**files, directories ,packages names**

`snake_case | lowercase with underscore`

Ex: 
my_awesome_file.dart


**class Names**

`PascalCase | Upper with Camel Case`

Ex: 
class MyNewClass {}

**Variables and other identifiers**

`camelCase | Lower with UpperCase`

Ex: 
var myNewVar = 10; 


<br>

## Editor Lint
---

* line width = 120
* word wrap = off

``` bash
$ flutter format lib -l 120
```



## Import Convention
---

- if the file resides in the same package folder 
user `relative path`
    
    _path/to/file_ , 
    _../path/to/file_


- if the file in different layer or different package user `absolute package path`  
_package:[package_name]/path/to/file_





## Unit Testing
---
1. A unit test tests a single function, method, or class.
2. A widget test (in other UI frameworks referred to as component test) tests a single widget.
3. An integration test tests a complete app or a large part of an app.


