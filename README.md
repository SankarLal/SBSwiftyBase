# SBSwiftyBase
  This is simple swift base setup files which we are using frequently.
  
  ## Benefits:

1. SBSwiftyBase will hepls us to write minimal code and faster implementation.
2. Makes it easy to quickly integration of Alamofire, APNs, FCM, Google and FB Login.
3. One step functionality to acheive Aler View, Action Sheet, Send SMS, Send Email, ActivityController, DocumentInteractionController and Scan QRcode.
4. Easily Save/Update/Delete the Files, Images, Arrays, Dictionaries and Objects in Document Directory.
5. Easily Save/Update/Delete the Objects in Plist and Userdefaults.

## Demo
## APNs Integration
1. Add `PushNotification.swift` class to your project.
2. Call the `PushNotification.initialisePushNotifications()` function to initialize the PushNotifications.
3. Enable `PushNotifications` and `Backgroud Modes` in Capabilities.

## FCM Integration
1. Follow the URL (https://firebase.google.com/docs/cloud-messaging/ios/client) to Setting Up a Firebase Cloud Messaging (FCM).
2. Add `FCMIntegration.swift` class to your project.
3. Call the functions which has FCM commented line (// FCM) in `PushNotification.swift` class
 
## Navigation Bar Item Integration
1. Add `CustomNavigationItems.swift` class to your project.

```objective-c

// For Titles
CustomNavigationItems.navigationButtonsWithTitles(rightTitleNames: ["Right1", "Right2"],
                                                  rightActionNames: ["performRight1BarButton", "performRight2BarButton"],
                                                  title: "Right Bar Button") 
             
 // For Images
 CustomNavigationItems.navigationButtonsWithImages(leftImageNames: ["Left1Image", "Left2Image"],
                                                          leftActionNames: ["performLeft1BarImage", "performLeft2BarImage"],
                                                          title: "Left Bar Image")
                                                 

```

## Google Login Integration
1. Follow the URL (https://developers.google.com/identity/sign-in/ios/start-integrating) to Setting Up Google Login.
2. Add `GoogleIntegrationController.swift` class to your project.

```objective-c

self.loginWithGoogle(successHandler: { (userInfo) in
            print("Google User Info", userInfo)
            if let googelUser = userInfo as? GIDGoogleUser {
                let name : String = (googelUser.profile.name) as String
                let email : String = (googelUser.profile.email) as String
                print("Name", name, "Email", email)
            }

        }) { (error) in
            print("Google Login Error", error)
        }
        
 ```
  
## FB Login Integration
1. Follow the URL (https://developers.facebook.com/docs/ios/getting-started) to Setting Up FB Login.
2. Add `FBIntegrationController.swift` class to your project.

```objective-c

self.loginWithFacebook(successHandler: { (userInfo) in
            
            print("FB User Info", userInfo)
            let name : String = userInfo["name"] as! String
            let email : String = userInfo["email"] as! String
            print("Name", name, "Email", email)
            
        }) { (error) in
            print("FB Login Error", error)

        }
        
 ```
## Storage (Document Directory)
1. Add `DDModel.swift` class to your project.

#### Store / Retive / Delete Array Values

```objective-c

// Store Array Values Into Document Directory
print("ARRAY STATUS", DDModel.addUpdateCacheWithArray(["Array_1", "Array_2", "Array_3"], inNamedCache: "DD_ARRAY"))

// Retrive Array Values From Document Directory
print("GET ARRAY VALUES", DDModel.getArrayFromNamedCache("DD_ARRAY"))
       
// Delete Array Values From Document Directory
print("DELTE THE DD_ARRAY Key", DDModel.deleteCacheName("DD_ARRAY"))

```

#### Store / Retive / Delete Dictionary Values

```objective-c

// Store Dictionary Values Into Document Directory
print("DICT STATUS", DDModel.addUpdateCacheWithDictionary(["Values" : "Dict_1", "Values1" : "Dict_2", "Values2" : "Dict_3"], inNamedCache: "DD_DICT"))        
        
// Retrive Dictionary Values From Document Directory
print("GET DICT VALUES", DDModel.getDictionaryFromNamedCache("DD_DICT"))

// Delete Dictionary Values From Document Directory
print("DELTE THE DD_DICT Key", DDModel.deleteCacheName("DD_DICT"))
       
```

#### Store / Retive / Delete Array Of Dictionary Values

```objective-c
        
// Store Array Of Dictionary Values Into Document Directory
print("ARRAY OF DICTIONARY STATUS", DDModel.addUpdateCacheWithArray([["Values" : "Dict_Array_1", "Values1" : "Dict_Array_2", "Values2" : "Dict_Array_3"]], inNamedCache: "DD_ARRAY_OF_DICT"))

// Retrive Array Of Dictionary Values From Document Directory
print("GET ARRAY OF DICT VALUES", DDModel.getArrayFromNamedCache("DD_ARRAY_OF_DICT"))

// Delete Array Of Dictionary Values From Document Directory
print("DELTE THE DD_ARRAY_OF_DICT Key", DDModel.deleteCacheName("DD_ARRAY_OF_DICT"))

```

#### Store / Retive / Delete Plist File

```objective-c

 // Store Plist File Into Document Directory
 print("SAVE PLIST STATUS", DDModel.savePlistData("HELLO HOW ARE YOU!!!", inNamedCache: "PlistStorage", dataKey: "myItem"))

// Retrive Plist Full Values From Document Directory
print("GET PLIST VALUES", DDModel.getPlistDataFromNamedCache("PlistStorage", dataKey: nil) ?? "NO VALUE")
        
// Retrive Plist 'myItem' Key Value From Document Directory
print("GET PLIST 'myItem' KEY VALUE", DDModel.getPlistDataFromNamedCache("PlistStorage", dataKey: "myItem") ?? "KEY DOESN'T EXISTS")

```
## Alert View Integration
1. Add `ShowAlertController.swift` class to your project.

```objective-c

self.showAlertWithTitle("Title",
                        message: "Text Message",
                        actionTitles: ["Ok", "Cancel"]) { (action) in
                             if action == "Ok" {
                                 print("Ok Button Pressed")
                             } else {
                                  print("Cancel Button Pressed")
                             }
        }
        
```

## Action Sheet Integration
1. Add `ShowActionSheetController.swift` class to your project.

```objective-c

self.showActionSheetWithTitle("Action Title",
                              message: "Sample Message",
                              actionTitles: ["Ok"]) { (action) in
        }
        
```

## Send SMS
1. Add `SendMessageController.swift` class to your project.

```objective-c

self.sendMessage(recipients: ["9789537536"],
                 body: "Test Body",
                 subject: "Test Subject",
                 successHandler: { successMessage in
                      print("Message Success - ", successMessage)
                            
        }) { failureMessage in
            print("Message Failure Reason - ", failureMessage)
        }
```

## Send Mail
1. Add `SendMailController.swift` class to your project.

```objective-c

self.sendEmail(toRecipients: ["sankarlal20@gmail.com"],
               ccRecipients: nil,
               bccRecipients: nil,
               messageBody: "Sample Message Body Text",
               isHTML: false,
               subject: "Test Subject",
               attachment: nil,
               mimeType: nil,
               fileName: nil,
               successHandler: { successMessage in
                  print("EMail Success - ", successMessage)
                        
        }) { failureMessage in
            print("EMail Failure Reason - ", failureMessage)
        }
```

## ActivityController And DocumentInteractionController
1. Add `OpenInAppActivity.swift` class to your project.

```objective-c

// ActivityController
let text = "This is some text that I want to share."
let image = #imageLiteral(resourceName: "Left2Image")

self.openActivityController(activityItems: [text, image])

/**
// OR - With Exclude Activity Types
         
self.openActivityController(activityItems: [text, image],
                            excludedActivityTypes: [.airDrop, .postToFacebook])

*/

// DocumentInteractionController
let fileURLPath = Bundle.main.path(forResource: "iPhoneImage", ofType: "png")
let fileURL = URL.init(fileURLWithPath: fileURLPath!)
self.openDocumentInteractionController(fileURL: fileURL)

```


## Requirements
* iOS 8.0+
* Xcode 8.0+
* Swift 3.0+

## Contact
sankarlal20@gmail.com

## License

SBSwiftyBase is available under the MIT license.

Copyright © 2018 SBSwiftyBase

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

