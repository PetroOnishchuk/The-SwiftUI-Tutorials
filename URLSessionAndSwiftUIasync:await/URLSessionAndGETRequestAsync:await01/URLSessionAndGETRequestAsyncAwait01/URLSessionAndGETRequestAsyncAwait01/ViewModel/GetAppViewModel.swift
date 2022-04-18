//
//  GetAppViewModel.swift
//  URLSessionAndGETRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/13/22.
//

import Foundation
import SwiftUI


 //@MainActor
class GetAppViewModel: ObservableObject {
    
    @Published var mainUser = AllUserData(user: User(id: 0, email: "", firstName: "", lastName: "", avatar: ""), support: Support(url: "", text: ""))
    
    @Published var mainPage = Page(page: 0, perPage: 0, total: 0, totalPages: 0, allUsers: [], support: Support(url: "", text: ""))
    
    let networkGETRequest = NetworkGETRequest.shared
    
    
    //MARK: Cleaning user field
    func cleanUserFields() {
        DispatchQueue.main.async {[weak self] in
            self?.mainUser = AllUserData(user: User(id: 0, email: "", firstName: "", lastName: "", avatar: ""), support: Support(url: "", text: ""))
        }
       
    }
    
    //MARK: Cleaning Page fields
    func cleanPageFields() {
        DispatchQueue.main.async {
            [weak self] in
            self?.mainPage = Page(page: 0, perPage: 0, total: 0, totalPages: 0, allUsers: [], support: Support(url: "", text: ""))
        }
    }
    
    //MARK: Run UserGETRequest with @escaping
    func runUserGetRequestEscaping() {
        networkGETRequest.userGetRequestEscaping { result in
            switch result {
            case .success((let response, let newUser)):
                DispatchQueue.main.async { [weak self] in
                    self?.mainUser = newUser
                    print("RESPONSE Status Code: \(response.statusCode)")
                }
            case .failure(let error as NSError):
                print("Error:\(error) \(error.localizedDescription) \(error.userInfo)")
            }
        }
    }
    
    //MARK: Run UserGETRequest with async/await
    @MainActor
    func runUserGetRequestAsyncAwait() async {
        do {
            let (response, newUser) = try await networkGETRequest.userGetRequestAsyncAwait()
            mainUser = newUser
            print("Response Status Code \(response.statusCode)")
            
        } catch (let error as NSError) {
            print("Error:\(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    //MARK: Run UserGETRequest with @escaping and async/await
    @MainActor
    func runUserGetRequestEscapingAndAsyncAwait() async {
        do {
            let (response, newUser) = try await networkGETRequest.userRequestEscapingAndAsyncAwait()
            mainUser = newUser
            print("Response Status Code \(response.statusCode)")
            
        } catch (let error as NSError) {
            print("Error:\(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    //MARK: Run PageGetRequest with @escaping
    func runPageGetRequestEscaping() {
        networkGETRequest.pageGetRequestEscaping { result in
            switch result {
            case .success((let response, let newPage)):
                DispatchQueue.main.async { [weak self] in
                    self?.mainPage = newPage
                    print("Response Status Code \(response.statusCode)")
            
                }
            case .failure(let error as NSError):
                print("Error: \(error) \(error.localizedDescription) \(error.userInfo)")
            }
        }
    }
    
    //MARK: Run PageGetRequest with async/await
    @MainActor
    func runPageGetRequestAsyncAwait() async {
        
        do {
            let (response, newPage) = try await networkGETRequest.pageGetRequestAsyncAwait()
            mainPage = newPage
            print("Response Status Code \(response.statusCode)")
            
        } catch (let error as NSError) {
            print("Error: \(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    //MARK: Run PageGetRequest with @escaping and async/await
    @MainActor
    func runPageGetRequestEscapingAndAsyncAwait() async {
        do {
            let (response, newPage) = try await networkGETRequest.pageGetRequestEscapingAndAsyncAwait()
            mainPage = newPage
            print("Response Status Code \(response.statusCode)")
            
        } catch (let error as NSError) {
            print("Error: \(error) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    //MARK: Run Users Get Request with LocalHost
    @MainActor
    func runUsersGetRequestAsyncAwaitLocal() async {
        do {
            let (response, newUsers) = try await networkGETRequest.usersGetRequestAsyncAwaitLocal()
            mainPage.allUsers = newUsers
            print("Response Status Code \(response.statusCode)")
        } catch (let error as NSError) {
            print ("Error LocalHost: \(error) \(error.localizedDescription) \(error.userInfo)")
        }
            
    }
}
