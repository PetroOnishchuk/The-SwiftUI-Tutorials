//
//  PostRequestViewModel.swift
//  URLSessionAndPOSTRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/16/22.
//

import Foundation
import SwiftUI

//@MainActor
class PostRequestViewModel: ObservableObject {
    
    
    @Published var name = "morpheus"
    @Published var job = "leader"
    @Published var mainUser = User(name: "", job: "", id: "", dateCreated: nil)
    
    let networkPOSTRequest = NetworkPOSTRequest()
    
    
    //MARK: makeFromUserRequest
    private func makeFormUserRequest() -> UserForm {
        let trimName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimJob = job.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let newUserForm = UserForm(name: trimName, job: trimJob)
        
        return newUserForm
    }
    
    //MARK: Run UserPOSTRequest with @escaping
    
    func runUserPOSTRequestEscaping() {
        
        networkPOSTRequest.userPOSTRequestEscaping(userForm: makeFormUserRequest()) { result in
            switch result {
            case .success((let response, let newUser)):
                DispatchQueue.main.async { [weak self] in
                    self?.mainUser = newUser
                    print("Response Status Code \(response.statusCode)")
                }
            case .failure(let error as NSError):
                print("Error: \(error) \(error.localizedDescription) \(error.userInfo)")
            }
        }
    }
    
    //MARK: Run UserPOSTRequest and async/await
    @MainActor
    func runUserPOSTRequestAsyncAwait() async {
        do {
            let (response, newUser) = try await networkPOSTRequest.userPOSTRequestAsyncAwait(userForm: makeFormUserRequest())
            mainUser = newUser
            print("Response Status Code: \(response.statusCode)")
            
        } catch (let error as NSError) {
            print("Error: \(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    
    //MARK: Run UserPOSTRequestEscapingAsyncAwait
    @MainActor
    func runUserPOSTRequestEscapingAsyncAwait() async {
        do {
            let (response, newUser) = try await networkPOSTRequest.userPOSTRequestEscapingAsyncAwait(userForm: makeFormUserRequest())
            mainUser = newUser
            print("Response Status Code: \(response.statusCode)")
            
        } catch (let error as NSError) {
            print("Error: \(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    
    //MARK: Run UserPostRequest and LocalHost
    @MainActor
    func runUserPOSTRequestAndLocalHost() async {
        do {
            let (response, newUser) = try await networkPOSTRequest.userPOSTRequestLocalhost(userForm: makeFormUserRequest())
            mainUser = newUser
            
            print("Response Status Code: \(response.statusCode)")
        } catch (let error as NSError) {
            print("Error: \(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    //MARK: Clean Users Fields
    
    func cleanUsersFields() {
        DispatchQueue.main.async { [weak self] in
            self?.name = ""
            self?.job = ""
            self?.mainUser = User(name: "", job: "", id: "", dateCreated: nil)
        }
        
    }
}
