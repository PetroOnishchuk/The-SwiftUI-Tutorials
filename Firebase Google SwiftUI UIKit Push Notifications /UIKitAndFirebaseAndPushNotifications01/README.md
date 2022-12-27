# # UIKit Project & Firebase &  Cloud Messaging

## Push Notifications

## [Apple Developer](https://developer.apple.com)
## [Firebase](https://firebase.google.com/)

## 1. Setup Xcode Project 
### 1.1 Start a new Xcode Project.
### 1.2 Completed project with code you can download from this repository. 
### 1.3 Add Firebase Package.   
 ![FirebaseAndSwiftUIAndUIKit041.jpeg](images/FirebaseAndSwiftUIAndUIKit041.jpeg)  
 ![FirebaseAndSwiftUIAndUIKit042.jpeg](images/FirebaseAndSwiftUIAndUIKit042.jpeg)
  ![FirebaseAndSwiftUIAndUIKit043.jpeg](images/FirebaseAndSwiftUIAndUIKit043.jpeg)
   ![FirebaseAndSwiftUIAndUIKit044.jpeg](images/FirebaseAndSwiftUIAndUIKit044.jpeg)
    ![FirebaseAndSwiftUIAndUIKit045.jpeg](images/FirebaseAndSwiftUIAndUIKit045.jpeg)  
              
### 1.4 Add capability (Background modes Push Notification).  
  ![FirebaseAndSwiftUIAndUIKit041.jpeg](images/FirebaseAndSwiftUIAndUIKit046.jpeg)  

        
## 2. Setup Apple Developer Account
### 2.1. In Section: Certificates, Identifiers & Profiles, select Keys. We will be creating a key for work with Push Notification. 
### Tap +.  
 ![FirebaseAndSwiftUIAndUIKit047.jpeg](images/FirebaseAndSwiftUIAndUIKit047.jpeg)    

### 2.2. Select: Apple Push Notifications service (APNs)  
 Tap: Continue.  
 ![FirebaseAndSwiftUIAndUIKit048.jpeg](images/FirebaseAndSwiftUIAndUIKit048.jpeg)  
### 2.3. Tap: Register.    
 ![FirebaseAndSwiftUIAndUIKit049.jpeg](images/FirebaseAndSwiftUIAndUIKit049.jpeg)  
### 2.4. We have Key ID and then Download Your Key.    
 ![FirebaseAndSwiftUIAndUIKit050.jpeg](images/FirebaseAndSwiftUIAndUIKit050.jpeg)  
### 2.5. Tap Done.    
 ![FirebaseAndSwiftUIAndUIKit051.jpeg](images/FirebaseAndSwiftUIAndUIKit051.jpeg)  
### 2.6. I have a two keys, first for AmazonSNS and second our new for work with Firebase.  
 ![FirebaseAndSwiftUIAndUIKit052.jpeg](images/FirebaseAndSwiftUIAndUIKit052.jpeg)  
### 2.7. In section Membership we have Team ID.  
 ![FirebaseAndSwiftUIAndUIKit053.jpeg](images/FirebaseAndSwiftUIAndUIKit053.jpeg)

## 3. [Setup Google Firebase & Cloud Messaging](https://console.firebase.google.com)  

### 3.1. (Create account, if you don't have)
### 3.2. In All Projects section you can create a new project. Tap + "Add project".   
 ![FirebaseAndSwiftUIAndUIKit054.jpeg](images/FirebaseAndSwiftUIAndUIKit054.jpeg)  
### 3.3. Enter you project name.
  ![FirebaseAndSwiftUIAndUIKit055.jpeg](images/FirebaseAndSwiftUIAndUIKit055.jpeg)  
### 3.4. Tap "Continue".
 ![FirebaseAndSwiftUIAndUIKit056.jpeg](images/FirebaseAndSwiftUIAndUIKit056.jpeg)
 ### 3.5. Tap "Continue".
 ![FirebaseAndSwiftUIAndUIKit057.jpeg](images/FirebaseAndSwiftUIAndUIKit057.jpeg) 
### 3.6. Choose or create a Google Analytics account, then Tap "Continue".
 ![FirebaseAndSwiftUIAndUIKit058.jpeg](images/FirebaseAndSwiftUIAndUIKit058.jpeg)  

### 3.7. Please wait...
 ![FirebaseAndSwiftUIAndUIKit059.jpeg](images/FirebaseAndSwiftUIAndUIKit059.jpeg)
### 3.8. Select a created project "Name of Your Project".  
  ![FirebaseAndSwiftUIAndUIKit060.jpeg](images/FirebaseAndSwiftUIAndUIKit060.jpeg)  

### 3.9. Start adding iOS App to Firebase. (You ca see I already add SwiftUI iOS App). Tap "Add app" then select "iOS". 
  ![FirebaseAndSwiftUIAndUIKit061.jpeg](images/FirebaseAndSwiftUIAndUIKit061.jpeg) 
  ![FirebaseAndSwiftUIAndUIKit062.jpeg](images/FirebaseAndSwiftUIAndUIKit062.jpeg)

### 3.10. Register App. Fill selected field.  
  ![FirebaseAndSwiftUIAndUIKit063.jpeg](images/FirebaseAndSwiftUIAndUIKit063.jpeg)  

### 3.11. Download GoogleService-Info.plist and add to our iOS Project.  
  ![FirebaseAndSwiftUIAndUIKit064.jpeg](images/FirebaseAndSwiftUIAndUIKit064.jpeg)  
  ![FirebaseAndSwiftUIAndUIKit065.jpeg](images/FirebaseAndSwiftUIAndUIKit065.jpeg) 
   
### 3.12. Tap "Next".   
 ![FirebaseAndSwiftUIAndUIKit066.jpeg](images/FirebaseAndSwiftUIAndUIKit066.jpeg) 
### 3.13. Tap "Next". 
 ![FirebaseAndSwiftUIAndUIKit067.jpeg](images/FirebaseAndSwiftUIAndUIKit067.jpeg)

### 3.14. Tap "Continue to console".
  ![FirebaseAndSwiftUIAndUIKit068.jpeg](images/FirebaseAndSwiftUIAndUIKit068.jpeg)
### 3.15. Select our UIKit iOS Project and then "Project Setting".
 ![FirebaseAndSwiftUIAndUIKit069.jpeg](images/FirebaseAndSwiftUIAndUIKit069.jpeg)  
  ![FirebaseAndSwiftUIAndUIKit070.jpeg](images/FirebaseAndSwiftUIAndUIKit070.jpeg) 
### 3.16. Select "Cloud Messaging". Then tap "Upload" APNs auth key.
 ![FirebaseAndSwiftUIAndUIKit071.jpeg](images/FirebaseAndSwiftUIAndUIKit071.jpeg)  
### 3.17. Fill selected fields. Then, tap "Upload".
 ![FirebaseAndSwiftUIAndUIKit072.jpeg](images/FirebaseAndSwiftUIAndUIKit072.jpeg)  
 ![FirebaseAndSwiftUIAndUIKit073.jpeg](images/FirebaseAndSwiftUIAndUIKit073.jpeg)  
## 4. Start Messaging. 
### 4.1. Select new created project. My is: "FirebaseSwiftUIUIKitProject". 
 ![FirebaseAndSwiftUIAndUIKit074.jpeg](images/FirebaseAndSwiftUIAndUIKit074.jpeg)  
### 4.2 Select "Cloud Messaging". 
 ![FirebaseAndSwiftUIAndUIKit075.jpeg](images/FirebaseAndSwiftUIAndUIKit075.jpeg)
### 4.3 Select "Send your first message". 
 ![FirebaseAndSwiftUIAndUIKit076.jpeg](images/FirebaseAndSwiftUIAndUIKit076.jpeg)  
### 4.4. Fill selected fields and then tap "Send text message"  
 ![FirebaseAndSwiftUIAndUIKit077.jpeg](images/FirebaseAndSwiftUIAndUIKit077.jpeg)  
### 4.4. Run our iOS Project. In Output area we must see: FMC registration token. Add this token, for send message to our device. Tap "Test". 
 ![FirebaseAndSwiftUIAndUIKit078.jpeg](images/FirebaseAndSwiftUIAndUIKit078.jpeg)
 ### 4.5. Must see in your device (not Simulator)
  ![FirebaseAndSwiftUIAndUIKit079.jpeg](images/FirebaseAndSwiftUIAndUIKit079.jpeg) 
   ![FirebaseAndSwiftUIAndUIKit080.jpeg](images/FirebaseAndSwiftUIAndUIKit080.jpeg)   
     
## 5. Thank You for Visiting. 
## 6. The END. 



 

  
 





    

   
   
