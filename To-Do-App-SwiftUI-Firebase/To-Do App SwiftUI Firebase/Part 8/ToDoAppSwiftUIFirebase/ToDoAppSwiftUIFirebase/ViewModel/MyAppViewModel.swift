//
//  MyAppViewModel.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/23/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import CryptoKit

class MyAppViewModel: ObservableObject {
    @Published var userSignedIn: Bool = false
    @Published var path = NavigationPath()
    let auth = Auth.auth()
    @Published var isPresentAlert = false
    @Published var customAlertInfo = CustomAlertInfo(title: "", description: "")
    // PART #3
    @Published var mainUser = User(id: "", firstName: "", lastName: "", email: "")
    let db = Firestore.firestore()
    // PART #4
    @Published var allTasks = [Task]()
    // PART #6
    @Published var isRunInitTasks = true
    // PART #8
    @Published var isAppleProvider = false
    
    
    // MARK: Format Date
    let formatDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    // MARK: Check isUserSignIn
    func isUserSignedIn() {
        let result = auth.currentUser != nil
        
        if result {
            if isRunInitTasks {
            // Commit in Part 7
//                takeCurrentUserData()
//                takeTaskList()
                
                // PART 7
                runAuthStateListener()
                runRealTimeListenerUserData()
                runRealTimeListenerTaskList()
                isRunInitTasks.toggle()
            }
            
        }
        DispatchQueue.main.async {
            [weak self] in
            self?.userSignedIn = result
        }
    }
    
    //MARK: Back to the Root Screen
    func backToRootScreen() {
        DispatchQueue.main.async {
            [weak self] in
            self?.path = .init()
        }
    }
    
    //MARK: SignUp
    //If You want to create a new account
    func signUp(firstName: String, lastName: String, email: String, password: String) {
        
        guard checkEmailAndPassword(email: email, password: password) == true else {
            print("Error while check an email and password")
            return
        }
        auth.createUser(withEmail: email, password: password) { [weak self]
            result, error in
            
            guard error == nil else {
                self?.showAlertWith(title: "Error with Sing Up", description: "Error: \(String(describing: error))")
                print("Error with SignUp \(String(describing: error))")
                return
            }
            
            guard let mainResult = result else {
                self?.showAlertWith(title: "Result is Nil", description: "The result with users data is Nil")
                return
            }
            
            let userUID = mainResult.user.uid
            
            guard let userEmail = result?.user.email else {
                print("Don't take 'result?.user.email' Error")
                self?.showAlertWith(title: "Error with 'result.user", description: "Error: 'result?.user.email == nil' ")
                return
            }
            print("SignUp with email: \(userEmail)\n")
            
            // MARK: Add user to Firestore
            self?.db.collection("users").document(userUID).setData(["firstName": firstName, "lastName": lastName, "email": userEmail], merge: true) { error in
                guard error == nil else {
                    self?.showAlertWith(title: "Error set users data to the Firestore", description: "Error: \(String(describing: error))")
                    return
                }
            }
            //  Commit in the PART #6.
           // self?.isUserSignedIn()
            self?.backToRootScreen()
        }
    }
    
    //MARK: SignIn with email
    //Using  when you already have an account
    
    func signIn(email: String, password: String) {
        
        guard checkEmailAndPassword(email: email, password: password) == true else {
            print("Error while check email and password")
            return
        }
        
        auth.signIn(withEmail: email, password: password) { [weak self]
            result, error in
            
            guard error == nil else {
                print("Error with SignIn with email: \(String(describing: error))")
                self?.showAlertWith(title: "Error with Sign In", description: "Error: \(String(describing: error))")
                return
            }
            
            guard let userEmail = result?.user.email else {
                print("Don't take 'result?.user.email' error")
                self?.showAlertWith(title: "Error with result.user", description: "Error: 'result?.user.email == nil'")
                return
            }
            print("SignIn with email: \(userEmail)\n")
            
            
            //  Commit in the PART #6.
          //  self?.isUserSignedIn()
            self?.backToRootScreen()
        }
    }
    
    //MARK: SignOut
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            showAlertWith(title: "Error with signOut", description: "Error: \(error)")
        }
        
        //  Commit in the PART #6.
    //   isUserSignedIn()
        // Commit in Part #7
        //backToRootScreen()
        isRunInitTasks = true
    }
    
    //MARK: Show Alert
    func showAlertWith(title: String, description: String) {
        DispatchQueue.main.async {
            [weak self] in
            self?.customAlertInfo.title = title
            self?.customAlertInfo.description = description
            self?.isPresentAlert = true
        }
    }
    
    //MARK: Check Email and Password
    func checkEmailAndPassword(email: String, password: String) -> Bool {
        
        let isValidEmail = email.isValidEmail
        //V 1.0
        let isValidPassword = password.count >= 6
        
        // V 2.0
        //let isValidPassword = password.isValidPassword
        
        switch (isValidEmail, isValidPassword) {
        case (true, true):
            return true
        case (false, false):
            showAlertWith(title: "Email & Password are invalid", description: "Email is invalid & Password < 6 characters")
            return false
        case (false, _):
            showAlertWith(title: "Email is invalid", description: "Incorrect Email format")
            return false
        case (_, false):
            showAlertWith(title: "Password is Invalid", description: "You password < 6 characters. Make password more longer.")
            return false
        }
        
    }
    
    
    
    // MARK: Take a user's data from the database.
//    func takeCurrentUserData() {
//        let currentUserUID = auth.currentUser?.uid ?? ""
//        let currentUserEmail = auth.currentUser?.email ?? ""
//
//        let docRef = db.collection("users").document(currentUserUID)
//
//
//        docRef.getDocument {[weak self] snapshot, error in
//
//            guard error == nil else {
//                self?.showAlertWith(title: "Take Document Info Error", description: "Error \(String(describing: error))")
//                return
//            }
//
//            guard let userData = snapshot else {
//                self?.showAlertWith(title: "Snapshot is Nil", description: "Snapshot with user info is Nil")
//                return
//            }
//
//            let firstName = userData["firstName"] as? String ?? ""
//            let lastName = userData["lastName"] as? String ?? ""
//
//            let newUser = User(id: currentUserUID, firstName: firstName, lastName: lastName, email: currentUserEmail)
//            DispatchQueue.main.async {
//                self?.mainUser = newUser
//            }
//        }
//    }
    
    // MARK: PART #4
    // MARK: Work with Tasks
    // MARK: Add a new Task
    
    func addNewTask(taskText: String) {
        
        let currentUserUID = auth.currentUser?.uid ?? ""
        
        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList")
        
        docPath.document().setData(["text": taskText, "isCompleted": false, "dateCreated": Date()], merge: true) {
            [weak self] error in
            guard error == nil else {
                self?.showAlertWith(title: "Add Task Error", description: "Error: \(String(describing: error))")
                return
            }
            self?.showAlertWith(title: "Add Task in DB successful", description: "Successful Add Task in Firestore Database")
            
            // Commit in Part #7
           // self?.takeTaskList()
        }
    }
    
    // MARK: Get a List of the Tasks / To-Do List
//    func takeTaskList() {
//
//        let currentUserUID = auth.currentUser?.uid ?? ""
//
//        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList").order(by: "dateCreated", descending: false)
//
//        docPath.getDocuments { [weak self] snapshot, error in
//
//            guard error == nil else {
//                self?.showAlertWith(title: "Take Task List Error", description: "Error: \(String(describing: error))")
//                return
//            }
//
//            guard let querySnapshot = snapshot else {
//                self?.showAlertWith(title: "To-Do List Snapshot Error", description: "Snapshot is nil")
//                return
//            }
//
//            var tempToDoList = [Task]()
//
//            for document in querySnapshot.documents {
//
//                let documentData = document.data()
//                let taskID = document.documentID
//                let taskText = documentData["text"] as? String ?? ""
//                let rawTaskData = documentData["dateCreated"] as? Timestamp ?? Timestamp(date: Date())
//                let dateCreated = rawTaskData.dateValue()
//                let lastUpdated = (documentData["lastUpdated"] as? Timestamp)?.dateValue()
//                let isCompletedTask = documentData["isCompleted"] as? Bool ?? false
//
//                let newTask = Task(id: taskID, text: taskText, dateCreated: dateCreated, isCompleted: isCompletedTask, lastUpdated: lastUpdated)
//
//                tempToDoList.append(newTask)
//            }
//            DispatchQueue.main.async {
//                [weak self] in
//                self?.allTasks = tempToDoList
//            }
//        }
//    }
    
    
    //MARK: PART: #5
    //MARK: Check Email V2.0
    func checkEmail(email: String) -> Bool {
        let isValidEmail = email.isValidEmail
        switch isValidEmail {
        case true:
            return true
        case false: showAlertWith(title: "Email is invalid", description: "Incorrect Email format")
            return false
        }
    }
    
    // MARK: Check Password
//    func checkPassword(password: String) -> Bool {
//        let isValidPassword = password.count >= 6
//
//        switch isValidPassword {
//        case true:
//            return true
//        case false:
//            showAlertWith(title: "Password is invalid", description: "Password < 6 characters")
//            return false
//        }
//    }
    
    // MARK: Updating User Data in the Firebase Firestore
    func updateUserData(firstName: String, lastName: String) {
        let currentUserUID = auth.currentUser?.uid ?? ""
        let currentUserEmail = auth.currentUser?.email ?? ""
        // We don't use updated data with SignIN with Apple method, because when we SignIN with Apple we don't create a user immediately after we SingIn, and without a user, we can't update data, which means we have an error. Must use setData.
        
        db.collection("users").document(currentUserUID).setData(["firstName": firstName, "lastName": lastName, "email": currentUserEmail, "lastUpdated": FieldValue.serverTimestamp()], merge: true) {[weak self] error in
            
            guard error == nil else {
                self?.showAlertWith(title: "Error with Update Users Data", description: "Error: \(String(describing: error))")
                return
            }
            
            self?.showAlertWith(title: "The Update was successful", description: "The update of users firstName and LastName was successful")
        }
        
        
//        db.collection("users").document(currentUserUID).updateData(["firstName": firstName, "lastName": lastName, "lastUpdated": FieldValue.serverTimestamp()]) { [weak self] error in
//
//            guard error == nil else {
//                self?.showAlertWith(title: "Error with Update Users Data", description: "Error: \(String(describing: error))")
//                return
//            }
//
//            self?.showAlertWith(title: "The Update was successful", description: "The update of users firstName and LastName was successful")
            
            //Commit Part #7
            //self?.takeCurrentUserData()
       // }
    }
    
    
    // MARK: Updating Users Email in the Firebase Authentication
    func updateUsersEmailAuth(email: String) {
        guard checkEmail(email: email) else {
            return
        }
        
        auth.currentUser?.updateEmail(to: email) {
            [weak self] error in
            guard error == nil else {
                self?.showAlertWith(title: "Error with updating users' email.", description: "Error with updating users' email in Firebase Auth. \(String(describing: error))")
                return
            }
            
             self?.updateUsersEmailDB()
        }
    }
    
    // MARK: Updating Users Email in Firestore DB
    func updateUsersEmailDB() {
        let currentUserUID = auth.currentUser?.uid ?? ""
        
        let currentUserEmail = auth.currentUser?.email ?? ""
       
        db.collection("users").document(currentUserUID).updateData(["email" : currentUserEmail, "lastUpdated" : FieldValue.serverTimestamp()]) {
            [weak self] error in
            guard error == nil else {
                self?.showAlertWith(title: "Error with updating users email", description: "Error with updating users email in Firebase DB: \(String(describing: error))")
                return
            }
            // Commit in Part #7
           // self?.takeCurrentUserData()
        }
    }
    
    // MARK: Updating Task status
    
    func updateTasksStatus(selectedTask: Task) {
        let currentUserUID  = auth.currentUser?.uid ?? ""
        var isCompletedTask = selectedTask.isCompleted
        isCompletedTask.toggle()
        
        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList")
        
        docPath.document(selectedTask.id).updateData(["isCompleted" : isCompletedTask, "lastUpdated": FieldValue.serverTimestamp()]) {
            [weak self] error in
            
            guard error == nil else {
                self?.showAlertWith(title: "Error while updating Task", description: "Error while updating Task in DB: \(String(describing: error))")
                return
            }
            
            self?.showAlertWith(title: "Successful updated Task.", description: "Successful updated Task in Firebase Firestore")
            
            // Commit in Part #7
           // self?.takeTaskList()
        }
    }
    
    // MARK: Updating Task text
    func updateTaskText(updateTask: Task) {
        let currentUserUID = auth.currentUser?.uid ?? ""
        
        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList")
        
        docPath.document(updateTask.id).updateData(["text": updateTask.text, "lastUpdated" : FieldValue.serverTimestamp()]) {
            [weak self] error in
            
            guard error == nil else {
                self?.showAlertWith(title: "Error while updating Task text", description: "Error while updating Task text in Firebase Firestore: \(String(describing: error))")
                return
            }
            
            self?.showAlertWith(title: "Successful Updated Task", description: "Successful updated Task text in Firebase Firestore")
            
            // Commit in Part #7
           // self?.takeTaskList()
        }
    }
    
    // MARK: PART #6
    // MARK: Delete Task
    func deleteUsersTask(selectedTask: Task) {
        let currentUserUID = auth.currentUser?.uid ?? ""
        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList")
        
        docPath.document(selectedTask.id).delete() {
            [weak self] error in
            guard error == nil else {
                self?.showAlertWith(title: "Delete Task Error", description: "Error: \(String(describing: error))")
                return
            }
            
            self?.allTasks.removeAll(where: { $0.id == selectedTask.id })
        }
    }
 
    // MARK: PART #7
    // MARK: Real-Time Update Data
    // MARK: Listener for Authentication State
    func runAuthStateListener() {
        auth.addStateDidChangeListener { [weak self] auth, user in
            
            if let user = user {
                if let providerData = auth.currentUser?.providerData {
                    for userInfo in providerData {
                        switch userInfo.providerID {
                        case "apple.com":
                            self?.isAppleProvider = true
                        default:
                            self?.isAppleProvider = false
                        }
                    }
                }
                print("User Real-Time UID: \(user.uid)")
                print("Auth Real-Time UID: \(String(describing: auth.currentUser?.uid))")
                
            } else {
                print("Sign Out")
                self?.isRunInitTasks = true
                self?.backToRootScreen()
                self?.isAppleProvider = false
            }
        }
        
    }
    
    // MARK: Real-Time Listener User Data
    func runRealTimeListenerUserData() {
        let currentUserUID = auth.currentUser?.uid ?? ""
        let docPath = db.collection("users").document(currentUserUID)
       // let currentUserEmail = self.auth.currentUser?.email ?? ""
        
        docPath.addSnapshotListener { [weak self] documentSnapshot, error in
            let currentUserEmail = self?.auth.currentUser?.email ?? ""
         
            guard error == nil else {
                self?.showAlertWith(title: "Error: Real-Time User Updates", description: "Error: \(String(describing: error))")
                return
            }
            
            guard let document = documentSnapshot else {
                self?.showAlertWith(title: "Error: documentSnapshot == nil", description: "documentSnapshot == nil, we don't take date from DB")
                return
            }
            
            let firstName = document["firstName"] as? String ?? ""
            let lastName = document["lastName"] as? String ?? ""
            
         let emailDB = document["email"] as? String ?? ""
            
            let newUser = User(id: currentUserUID, firstName: firstName, lastName: lastName, email: emailDB)
            
            DispatchQueue.main.async {
                self?.mainUser = newUser
            }
        }
    }
    
    // MARK: Real-Time Listener List of Task Collections
    func runRealTimeListenerTaskList() {
        
        let currentUserUID = auth.currentUser?.uid ?? ""
        
        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList").order(by: "dateCreated")
        
        docPath.addSnapshotListener { [weak self] querySnapshot, error in
            guard  error == nil else {
                self?.showAlertWith(title: "Real-Time List Listener Error", description: "Error: \(String(describing: error))")
                return
            }
            guard let querySnapshot = querySnapshot else {
                self?.showAlertWith(title: "querySnapshot == nil", description: "Error: don't have data (list of tasks) in querySnapshot")
                return
            }
            
            var tempArrayOfTasks = [Task]()
            for document in querySnapshot.documents {
                
                let documentData = document.data()
                let taskID = document.documentID
                let taskText = documentData["text"] as? String ?? ""
                let rawTaskDate = documentData["dateCreated"] as? Timestamp ?? Timestamp(date: Date())
                let dateCreated = rawTaskDate.dateValue()
                let lastUpdated = (documentData["lastUpdated"] as? Timestamp)?.dateValue()
                let isCompleted = documentData["isCompleted"] as? Bool ?? false
                
                let newTask = Task(id: taskID, text: taskText, dateCreated: dateCreated, isCompleted: isCompleted, lastUpdated: lastUpdated)
                
                tempArrayOfTasks.append(newTask)
            }
            
            DispatchQueue.main.async {
                [weak self] in
                self?.allTasks = tempArrayOfTasks
            }
            
            
        }
    }
    
    // MARK: PART: #8
    // MARK: Sign IN with Apple
    // support function for Sign In with Apple and Firebase Authentication
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length
      
      while remainingLength > 0 {
          let randoms: [UInt8] = (0 ..< 16).map { _ in
              var random: UInt8 = 0
              let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
              if errorCode != errSecSuccess {
                  fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
              }
              return random
          }
          
          randoms.forEach { random in
              if remainingLength == 0 {
                  return
              }
              
              if random < charset.count {
                  result.append(charset[Int(random)])
                  remainingLength -= 1
              }
          }
      }
      
      return result
  }
    
    // MARK: SignIn with Apple
    // MARK: Second support function for Sign In with Apple
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
     
}
