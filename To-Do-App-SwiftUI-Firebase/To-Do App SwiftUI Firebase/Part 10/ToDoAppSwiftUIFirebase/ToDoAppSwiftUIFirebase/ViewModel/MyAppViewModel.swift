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
import GoogleSignIn
import GoogleSignInSwift

class MyAppViewModel: ObservableObject {
    @Published var userSignedIn: Bool = false
    @Published var path = NavigationPath()
    let auth = Auth.auth()
    @Published var isPresentAlert = false
    @Published var customAlertInfo = CustomAlertInfo(title: "", description: "")
    // PART #3
    @Published var mainUser = User(  firstName: "", lastName: "", email: "")
    let db = Firestore.firestore()
    // PART #4
    @Published var allTasks = [Task]()
    // PART #6
    @Published var isRunInitTasks = true
    // PART #8
    @Published var isAppleProvider = false
    @Published var isGoogleProvider = false
    
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
    
    
    
    // MARK: PART #4
    // MARK: Work with Tasks
    // MARK: Add a new Task
    
    func addNewTask(taskText: String) {
        
        let currentUserUID = auth.currentUser?.uid ?? ""
        
        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList")
        let newTask = Task(text: taskText, dateCreated: Date(), isCompleted: false)
        
        do {
            try docPath.document().setData(from: newTask, merge: true)
            showAlertWith(title: "Add Task in DB successful", description: "Successful Add Task in Firestore Database")
        } catch {
            showAlertWith(title: "Add Task Error", description: "Error: \(String(describing: error))")
            return
        }
        
    }
    
    
    
    
    
    
    // MARK: Updating User Data in the Firebase Firestore
    func updateUserData(firstName: String, lastName: String) {
        let currentUserUID = auth.currentUser?.uid ?? ""
        let currentUserEmail = auth.currentUser?.email ?? ""
        // We don't use updated data with SignIN with Apple method, because when we SignIN with Apple we don't create a user immediately after we SingIn, and without a user, we can't update data, which means we have an error. Must use setData.
        let updatingUser = User(firstName: firstName, lastName: lastName, email: currentUserEmail)
        do {
            try   db.collection("users").document(currentUserUID).setData(from: updatingUser, merge: true)
            showAlertWith(title: "The Update was successful", description: "The update of users firstName and LastName was successful")
        } catch {
            showAlertWith(title: "Error with Update Users Data", description: "Error: \(String(describing: error))")
            
            
        }
        
        
    }
    
    
    // MARK: Updating Users Email in the Firebase Authentication
    func updateUsersEmailAuth(email: String) {
        //        guard checkEmail(email: email) else {
        //            return
        //        }
        
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
            
        }
    }
    
    // MARK: Updating Task status
    
    func updateTasksStatus(selectedTask: Task) {
        let currentUserUID  = auth.currentUser?.uid ?? ""
        var isCompletedTask = selectedTask.isCompleted
        
        isCompletedTask.toggle()
        
        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList")
        // IN last updated section you can select
        //FieldValue.serverTimestamp() and server will set last time update of date
        //Or you can use Date() for update data in real device.
        //you could also using setData() and update whole Task.
        // in this method I use Date() 
        docPath.document(selectedTask.id ?? "").updateData(["isCompleted" : isCompletedTask, "lastUpdated": Date()]) {
            [weak self] error in
            
            guard error == nil else {
                self?.showAlertWith(title: "Error while updating Task", description: "Error while updating Task in DB: \(String(describing: error))")
                return
            }
            
            self?.showAlertWith(title: "Successful updated Task.", description: "Successful updated Task in Firebase Firestore")
            
        }
    }
    
    // MARK: Updating Task text
    func updateTaskText(updateTask: Task) {
        let currentUserUID = auth.currentUser?.uid ?? ""
        
        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList")
        // MARK: about FieldValue.serverTimestamp()
        // IN last updated section you can select
        //FieldValue.serverTimestamp() and server will set last time update of date
        //Or you can use Date() for update data in real device.
        //you could also using setData() and update whole Task.
        docPath.document(updateTask.id ?? "").updateData(["text": updateTask.text, "lastUpdated" : FieldValue.serverTimestamp()]) {
            [weak self] error in
            // FieldValue.serverTimestamp()
            guard error == nil else {
                self?.showAlertWith(title: "Error while updating Task text", description: "Error while updating Task text in Firebase Firestore: \(String(describing: error))")
                return
            }
            
            self?.showAlertWith(title: "Successful Updated Task", description: "Successful updated Task text in Firebase Firestore")
            
        }
    }
    
    // MARK: PART #6
    // MARK: Delete Task
    func deleteUsersTask(selectedTask: Task) {
        let currentUserUID = auth.currentUser?.uid ?? ""
        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList")
        let selectedTaskID = selectedTask.id ?? ""
        docPath.document(selectedTaskID).delete() {
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
                        case "google.com":
                            self?.isGoogleProvider = true
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
                self?.isGoogleProvider = false
            }
        }
        
    }
    
    // MARK: Real-Time Listener User Data
    func runRealTimeListenerUserData() {
        let currentUserUID = auth.currentUser?.uid ?? ""
        let docPath = db.collection("users").document(currentUserUID)
        
        
        docPath.addSnapshotListener { [weak self] documentSnapshot, error in
            
            
            
            guard error == nil else {
                if self?.auth.currentUser != nil {
                    self?.showAlertWith(title: "Error: Real-Time User Updates", description: "Error: \(String(describing: error))")
                } else {
                    print("Error: \(String(describing: error))")
                }
                return
            }
            
            guard let document = documentSnapshot else {
                self?.showAlertWith(title: "Error: documentSnapshot == nil", description: "documentSnapshot == nil, we don't take date from DB")
                return
            }
            // MARK: Part 10
            // Check DocumentID
            do {
                let newUser = try document.data(as: User.self)
                DispatchQueue.main.async {
                    self?.mainUser = newUser
                }
                
            } catch {
                self?.showAlertWith(title: "User Data Error", description: "\(error.localizedDescription)")
            }
        }
    }
    
    // MARK: Real-Time Listener List of Task Collections
    func runRealTimeListenerTaskList() {
        
        let currentUserUID = auth.currentUser?.uid ?? ""
        
        let docPath = db.collection("users").document(currentUserUID).collection("ToDoList").order(by: "dateCreated")
        
        docPath.addSnapshotListener { [weak self] querySnapshot, error in
            guard  error == nil else {
                if self?.auth.currentUser != nil {
                    self?.showAlertWith(title: "Real-Time List Listener Error", description: "Error: \(String(describing: error))")
                } else {
                    print("Real-Time List Listener Error")
                    
                }
                return
                
            }
            guard let querySnapshot = querySnapshot else {
                self?.showAlertWith(title: "querySnapshot == nil", description: "Error: don't have data (list of tasks) in querySnapshot")
                return
            }
            
            let allTasks = querySnapshot.documents.compactMap { queryDocumentSnapshot in
                let result = Result {
                    try queryDocumentSnapshot.data(as: Task.self)}
                switch result {
                case .success(let task):
                    // A Task value was successfully initialized from DocumentSnapshot
                    return task
                case .failure(let error):
                    self?.showAlertWith(title: "Fetch Task Error", description: "A Task value could not be initialized from the DocumentSnapshot \(error)")
                    return nil
                }
            }
            DispatchQueue.main.async {
                [weak self] in
                self?.allTasks = allTasks
                print("All Tassk: \(allTasks)")
            }
            
            
        }
    }
    
    //MARK: PART: #5
    //MARK: Check Email V2.0
    //    func checkEmail(email: String) -> Bool {
    //        let isValidEmail = email.isValidEmail
    //        switch isValidEmail {
    //        case true:
    //            return true
    //        case false: //showAlertWith(title: "Email is invalid", description: "Incorrect Email format")
    //            return false
    //        }
    //    }
    
    func checkEmailFields(email: String) -> String {
        let isValidEmail =  email.isValidEmail
        switch isValidEmail {
        case false:
            return "Incorrect Email format"
        case true:
            return ""
        }
    }
    
    
    //MARK: Check Password Fields
    
    func checkFirstName(firstName: String) -> Bool {
        return firstName.count >= 3
    }
    
    func checkLastName(lastName: String) -> Bool {
        return lastName.count >= 3
    }
    
    func checkUserFields(firstName: String, lastName: String) -> String {
        
        if  !checkFirstName(firstName: firstName) && !checkLastName(lastName: lastName) {
            return "First name and Last name too short. Needs to be at least 3 characters."
        } else if  !checkFirstName(firstName: firstName) {
            return "First name too short. Needs to be at least 3 characters."
        } else if  !checkLastName(lastName: lastName) {
            return "Last name too short. Needs to be at least 3 characters."
        }
        return ""
    }
    func checkPasswordField(firstField: String) -> Bool {
        if firstField.isEmpty {
            return  false
        }
        return true
    }
    func checkMatchedPasswords(password: String, passwordConfirmation: String) -> Bool {
        
        return (password == passwordConfirmation)
    }
    func checkPasswordFields(firstField: String,secondField: String) -> String {
        
        if !checkPasswordField(firstField: firstField) {
            return "Password must not be empty"
        } else if  !checkMatchedPasswords(password: firstField, passwordConfirmation: secondField)  {
            return "Passwords do not match"
        }
        return ""
    }
    // this method I use for disable SignUP Button.
    func checkSignUPFields(firstName: String, lastName: String, email: String, password: String, passwordConfirmation: String ) -> Bool {
        
        return checkFirstName(firstName: firstName) && checkLastName(lastName: lastName) && checkPasswordField(firstField: password) && checkMatchedPasswords(password: password, passwordConfirmation: passwordConfirmation) && email.isValidEmail
    }
    
    // This method I use for disable SignIn Button
    func checkSignInFields(email: String,password: String, passwordConfirmation: String) -> Bool {
        
        return checkPasswordField(firstField: password) && checkMatchedPasswords(password: password, passwordConfirmation: passwordConfirmation) && email.isValidEmail
        
    }
    
}
