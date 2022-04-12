//
//  NetworkGETRequest.swift
//  URLSessionAndGETRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/12/22.
//

import Foundation
import SwiftUI

class NetworkGETRequest {
    
    static let shared = NetworkGETRequest()
    
    //MARK: Get User Request with @escaping
    func userGetRequestEscaping(completionHandler: @escaping (Result<(HTTPURLResponse, AllUserData), Error>) -> Void) {
        
        //MARK: URLComponents
        var components = URLComponents()
        components.scheme = "https"
        components.host = "reqres.in"
        components.path = "/api/users/2"
        
        // MARK: Create URL
        guard let url = components.url else {
            completionHandler(.failure(MyRequestError.invalidURL))
            return
        }
        
        // MARK: URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // optional
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(MyRequestError.invalidHTTPURLResponse))
                return
            }
            
            let statusCode = response.statusCode
            
            guard (200...299).contains(statusCode) else {
                completionHandler(.failure(MyRequestError.serverSideErrorWithResponse(statusCode)))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(MyRequestError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let newUser = try decoder.decode(AllUserData.self, from: data)
                completionHandler(.success((response, newUser)))
                
            } catch (let decodingError) {
                completionHandler(.failure(decodingError))
            }
        }.resume()
    }
    
    // MARK: GET UserRequest with async/await
    
    func userGetRequestAsyncAwait() async throws -> (HTTPURLResponse, AllUserData) {
        
        // MARK: URLComponents
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "reqres.in"
        components.path = "/api/users/2"
        
        // MARK: Create URL
        guard let url = components.url else {
            throw MyRequestError.invalidURL
        }
        
        // MARK: URLRequest
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // optional
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
        
        guard let response = response as? HTTPURLResponse else {
            throw MyRequestError.invalidHTTPURLResponse
        }
        
        let statusCode = response.statusCode
        
        guard (200...299).contains(statusCode) else {
            throw MyRequestError.serverSideErrorWithResponse(statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(AllUserData.self, from: data)
            
            return (response, user)
            
        } catch (let decodingError) {
            throw decodingError
            
        }
        
    }
    
    // MARK: User Request with @escaping and async/await
    
    
    func userRequestEscapingAndAsyncAwait() async throws -> (HTTPURLResponse, AllUserData) {
        
        do {
            return try await withCheckedThrowingContinuation({ continuation in
                userGetRequestEscaping { result in
                    switch result {
                    case .success((let response, let newUser)):
                        continuation.resume(returning: (response, newUser))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            })
            
        } catch (let error) {
            throw error
        }
    }
}
