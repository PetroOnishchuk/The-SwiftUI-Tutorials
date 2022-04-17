//
//  NetworkPOSTRequest.swift
//  URLSessionAndPOSTRequestAsyncAwait01
//
//  Created by Petro Onishchuk on 4/16/22.
//

import Foundation
import SwiftUI

class NetworkPOSTRequest {
    
    static let shared = NetworkPOSTRequest()
    
    //MARK: UserPOSTRequest and @escaping
    
    func userPOSTRequestEscaping(userForm: UserForm, completionHandler: @escaping (Result<(HTTPURLResponse, User), Error>) -> Void) {
        
        
        //MARK: URLComponents
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "reqres.in"
        urlComponents.path = "/api/users"
        
        //MARK: Create URL
        
        guard let url = urlComponents.url else {
            completionHandler(.failure(MyRequestError.invalidURL))
            return
        }
        
        //MARK: URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        //MARK: HTTPBody
        
        do {
            let encoder = JSONEncoder()
            let httpBody = try encoder.encode(userForm)
            request.httpBody = httpBody
            
            // V.2.0
            //            let secUserForm = ["name" : userForm.name, "job" : userForm.job]
            //            let secHTTPBody = try JSONSerialization.data(withJSONObject: secUserForm, options: [])
            //            request.httpBody = secHTTPBody
            
        } catch (let encoderError) {
            completionHandler(.failure(encoderError))
        }
        
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
                decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormatter)
                
                let newUser = try decoder.decode(User.self, from: data)
                
                completionHandler(.success((response, newUser)))
                
                
            } catch (let decodingError) {
                completionHandler(.failure(decodingError))
            }
            
            
        }.resume()
    }
    
    
    //MARK: UserPOSTRequest with async/await
    
    func userPOSTRequestAsyncAwait(userForm: UserForm) async throws -> (HTTPURLResponse, User) {
        
        //MARK: URLComponents
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "reqres.in"
        urlComponents.path = "/api/users"
        
        //MARK: Create URL
        guard let url = urlComponents.url else {
            throw MyRequestError.invalidURL
        }
        
        //MARK: URLRequest
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let httpBody = try encoder.encode(userForm)
            request.httpBody = httpBody
            
        } catch (let encodeError) {
            throw encodeError
        }
        
        //MARK: Make Request
        
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
            decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormatter)
            
            let newUser = try decoder.decode(User.self, from: data)
            return (response, newUser)
            
        } catch (let decoderError) {
            throw decoderError
        }
        
    }
    
    //MARK: POST UserRequest with @escaping and async/await
    func userPOSTRequestEscapingAsyncAwait(userForm: UserForm) async throws -> (HTTPURLResponse, User) {
        
        do {
            return try await withCheckedThrowingContinuation({ continuation in
                userPOSTRequestEscaping(userForm: userForm) { result in
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
    
    
    //MARK: UserPOSTRequest async/await and localhost
    
    func userPOSTRequestLocalhost(userForm: UserForm) async throws -> (HTTPURLResponse, User) {
        
        //MARK: Create URL
        
        guard let rawURL = URL(string: "http://localhost:5000/users") else {
            throw MyRequestError.invalidURL
        }
        
        guard let urlComponents = URLComponents(url: rawURL, resolvingAgainstBaseURL: true) else {
            throw MyRequestError.invalidURLComponents
        }
        
        guard let url = urlComponents.url else {
            throw MyRequestError.invalidURL
        }
        
        //MARK: URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let httpBody = try encoder.encode(userForm)
            request.httpBody = httpBody
            
        } catch (let encoderError) {
            throw encoderError
        }
        
        
        let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
        
        
        guard let response = response as? HTTPURLResponse else {
            throw MyRequestError.invalidHTTPURLResponse
        }
        
        let statusCode = response.statusCode
        
        guard (200...299).contains(statusCode) else {
            if let errorMessage = String(data: data, encoding: .utf8) {
                print("Message error: \(errorMessage)")
            }
            throw MyRequestError.serverSideErrorWithResponse(statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormatter)
            
            let newUser = try decoder.decode(User.self, from: data)
            return (response, newUser)
            
        } catch (let decoderError) {
            throw decoderError
        }
        
        
    }
}
