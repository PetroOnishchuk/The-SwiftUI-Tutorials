//
//  MyAppViewModel.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import Foundation
import SwiftUI

class MyAppViewModel: ObservableObject {
    @Published var typeOfSearch = TypeOfSearch.off
    @Published var allUsers = [User]()
    @Published var mainPage = Page()
    
    @Published var userID: String = "" {
        didSet {
            let filtered = userID.filter { $0.isNumber }
            if userID != filtered {
                userID = filtered
            }
        }
    }
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var avatar: String = ""
    
    
    //MARK: Set a User for Update
    func setUserForUpdate(selectedUser: User) {
        userID = String(selectedUser.id)
        firstName = selectedUser.firstName
        lastName = selectedUser.lastName
        email = selectedUser.email
        avatar = selectedUser.avatar
    }
    
    //MARK: Check find Fields
    func checkFindFields() -> Bool {
        return userID.isEmpty && firstName.isEmpty
    }
    
    
    //MARK: Check New User Fields
    func checkNewUserFields() -> Bool {
        return firstName.isEmpty && lastName.isEmpty && email.isEmpty && avatar.isEmpty
    }
    
    //MARK: Clean New and update user fields
    func cleanNewAndUpdateUserFields() {
        userID = ""
        firstName = ""
        lastName = ""
        email = ""
        avatar = ""
        typeOfSearch = .off
    }
    
    //MARK: Clean All users
    func cleanAllUsers() {
        allUsers = []
    }
    
    // MARK: Clean Page Fields
    func cleanPageFields() {
        mainPage = Page()
    }
    
    // MARK: Cancel Search User
    func cancelSearchUser() {
        Task {
            await runAllUsersGETRequestAsyncAwaitGenericLocalHost()
            typeOfSearch = .off
        }
    }
    
    //MARK: Make trimming
    func makeTrimming(item: String) -> String {
        return item.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    
    //MARK: Create New User
    func createNewUser() -> User {
        let newFirstName = makeTrimming(item: firstName)
        let newLastName = makeTrimming(item: lastName)
        let newEmail = makeTrimming(item: email)
        let newAvatar = makeTrimming(item: avatar)
        
        let newUser = User(id: Int(userID) ?? 0, firstName: newFirstName, lastName: newLastName, email: newEmail, avatar: newAvatar)
        
        return newUser
    }
    
    //MARK: Sort list of Users
    func sortListOfUsersByID(inputList: [User]) -> [User] {
        let sortedList = inputList.sorted { firstUser, secondUser in
            return firstUser.id < secondUser.id
        }
        return sortedList
    }
    
    // MARK: Delete Item (User)
    func deleteItem(at indexSet: IndexSet) {
        let selectedUsers = indexSet.map { index in
            return allUsers[index]
        }
        
        selectedUsers.forEach { user in
            Task {
                switch typeOfSearch {
                case .multipleSearch:
                    await runDeleteUserPOSTRequestAsyncAwaitAndGeneric(deleteUser: user)
                    await runSelectMultipleUsersPOSTRequestAsyncAwaitAndGeneric()
                case .singleSearch:
                    await runDeleteUserPOSTRequestAsyncAwaitAndGeneric(deleteUser: user)
                    await runSelectSingleUserPOSTRequestAsyncAwaitAndGeneric()
                case .off:
                    await runDeleteUserPOSTRequestAsyncAwaitAndGeneric(deleteUser: user)
                    await runAllUsersGETRequestAsyncAwaitGenericLocalHost()
                }
            }
        }
    }
    
    //MARK: RUN GET Request with Localhost
    @MainActor
    func runAllUsersGETRequestAsyncAwaitGenericLocalHost() async {
        do {
            let (response, inputUsers) = try await NetworkRequestServices.shared.usersGETRequestAsyncAwaitGeneric(returnType: [User].self, urlType: .getRequestLocalhostAPI)
            allUsers = sortListOfUsersByID(inputList: inputUsers)
            
            print("Response Status Code \(response.statusCode)")
            cleanNewAndUpdateUserFields()
            
        } catch(let error) {
            let error = error as NSError
            print("Error GET Request All Users localhost: \(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    
    //MARK: RUN GET Page request with Generic & REQRES API
    @MainActor
    func runPageGETRequestAsyncAwaitGenericREQRESApi() async {
        do {
            let (response, inputPage) = try await NetworkRequestServices.shared.usersGETRequestAsyncAwaitGeneric(returnType: Page.self, urlType: .getRequestReqresAPI)
            
            mainPage = inputPage
            
            print("Response Status Code \(response.statusCode)")
            cleanNewAndUpdateUserFields()
            
        } catch (let error) {
            let error = error as NSError
            print("Error Page GET Request REQRES API: \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    //MARK: Run SELECT Single User with LocalHost
    @MainActor
    func runSelectSingleUserPOSTRequestAsyncAwaitAndGeneric() async {
        do {
            let newUser  = createNewUser()
            let (response, singleUser) = try await NetworkRequestServices.shared.usersPOSTRequestAsyncAwaitGeneric(inputType: User.self, returnType: User.self, urlType: .postRequestLocalhostAPI, userForm: newUser, path: "selectSingle")
            if singleUser.id == 0 {
                allUsers = []
            } else {
                allUsers = []
                allUsers.append(singleUser)
            }
            
            print("Response Status Code \(response.statusCode)")
            
        } catch (let error) {
            let error = error as NSError
            print("Error LocalHost: \(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    //MARK: Run SELECT multiple users Localhost
    @MainActor
    func runSelectMultipleUsersPOSTRequestAsyncAwaitAndGeneric() async {
        do {
            let newUser = createNewUser()
            let (response, inputUsers) = try await NetworkRequestServices.shared.usersPOSTRequestAsyncAwaitGeneric(inputType: User.self, returnType: [User].self, urlType: .postRequestLocalhostAPI, userForm: newUser, path: "select")
            allUsers = sortListOfUsersByID(inputList: inputUsers)
            
            print("Response Status Code \(response.statusCode)")
            
        } catch (let error) {
            let  error = error as NSError
            print("Error Run SELECT multiple Users LocalHost \(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    
    
    //MARK: RUN Insert a New User POST Request
    @MainActor
    func runInsertNewUserPOSTRequestAsyncAwaitAndGeneric() async {
        do {
            let newUser = createNewUser()
            let (response, lastUserID) = try await NetworkRequestServices.shared.usersPOSTRequestAsyncAwaitGeneric(inputType: User.self, returnType: Int.self, urlType: .postRequestLocalhostAPI, userForm: newUser, path: "newUser")
            
            print("Last User created with ID: \(lastUserID)")
            print("Response Status Code \(response.statusCode)")
            
        } catch (let error) {
            let error = error as NSError
            print("Error RUN Insert a New User POST Request \(error), \(error.localizedDescription), \(error.userInfo)")
        }
    }
    
    
    //MARK: RUN UPDATE User POST Request
    @MainActor
    func runUpdateUserPOSTRequestAsyncAwaitAndGeneric() async {
        let updateUser = createNewUser()
        
        do {
            let (response, updatedUserID) = try await NetworkRequestServices.shared.usersPOSTRequestAsyncAwaitGeneric(inputType: User.self, returnType: Int.self, urlType: .postRequestLocalhostAPI, userForm: updateUser, path: "update")
            
            print("Update User with ID: \(updatedUserID)")
            print("Response Status Code \(response.statusCode)")
            
        } catch (let error) {
            let error = error as NSError
            print("Error RUN UPDATE User POST Request Localhost \(error), \(error.localizedDescription), \(error.userInfo)")
        }
    }
    
    
    //MARK: RUN DELETE User with Localhost
    @MainActor
    func runDeleteUserPOSTRequestAsyncAwaitAndGeneric(deleteUser: User) async {
        do {
            let (response, deletedUserID) = try await NetworkRequestServices.shared.usersPOSTRequestAsyncAwaitGeneric(inputType: User.self, returnType: Int.self, urlType: .postRequestLocalhostAPI, userForm: deleteUser, path: "delete")
            
            print("User Deleted ID: \(deletedUserID)")
            print("Response Status Code: \(response.statusCode)")
            
        } catch (let error) {
            let error = error as NSError
            print("Error with DELETE User POST Request \(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    
    
}
