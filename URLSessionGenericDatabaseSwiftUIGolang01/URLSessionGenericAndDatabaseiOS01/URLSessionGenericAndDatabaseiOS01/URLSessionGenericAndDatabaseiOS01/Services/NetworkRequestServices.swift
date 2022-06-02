//
//  NetworkRequestServices.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import Foundation
import SwiftUI


class NetworkRequestServices {
    
    static let shared = NetworkRequestServices()
    
    
    //MARK: Make RequestURL
    func makeRequestURL(urlType: TypeOfAppURL, path: String) throws -> URL {
        switch urlType {
        case .getRequestReqresAPI:
            var components = URLComponents()
            components.scheme = "https"
            components.host = "reqres.in"
            components.path = "/api/users"
            components.queryItems = [URLQueryItem(name: "page", value: "2")]
            
            //MARK: Create URL
            guard let url = components.url else {
                throw MyRequestError.invalidURL
            }
            return url
        case .getRequestLocalhostAPI:
        
            guard let rawURL = URL(string: "http://localhost:5000/users") else {
                throw MyRequestError.invalidURL
            }
            
            guard var components = URLComponents(url: rawURL, resolvingAgainstBaseURL: true) else {
                throw MyRequestError.invalidURLComponents
            }
            
            components.queryItems = [ URLQueryItem(name: "users", value: "all")]
            
            guard let url = components.url else {
                throw MyRequestError.invalidURL
            }
            return url
        
        case .postRequestLocalhostAPI:
            
            guard let rawURL = URL(string: "http://localhost:5000/\(path)") else {
                throw MyRequestError.invalidURL
            }
            
            guard let urlComponents = URLComponents(url: rawURL, resolvingAgainstBaseURL: true) else {
                throw MyRequestError.invalidURLComponents
            }
            
            guard let url = urlComponents.url else {
                throw MyRequestError.invalidURL
            }
            return url
        }
    }
    
    //MARK: Make GET Request
    
    func usersGETRequestAsyncAwaitGeneric<T: Codable>(urlType: TypeOfAppURL, returnType: T.Type) async throws -> (HTTPURLResponse, T) {
        var tempURL: URL?
        
        do {
            
            tempURL = try makeRequestURL(urlType: urlType, path: "")
        } catch (let error) {
            throw error
        }
        
        //MARK: Create URL
        guard let url = tempURL else {
            throw MyRequestError.invalidURL
        }
        
        //MARK: URL Request
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
        
        guard let response = response as? HTTPURLResponse else {
            throw MyRequestError.invalidHTTPURLResponse
        }
        
        let statusCode = response.statusCode
        
        guard (200...299).contains(statusCode) else {
            if let dataString = String(data: data, encoding: .utf8) {
                print("Data String: \(dataString)")
            }
            throw MyRequestError.serverSideErrorWithResponse(statusCode)
        }
        
        let decoder = JSONDecoder()
        do {
            let users = try decoder.decode(T.self, from: data)
            
            return (response, users)
        } catch (let error) {
            throw error
        }
    }
    
    
    //MARK: Make POST Request
    
    func usersPOSTRequestAsyncAwaitGeneric<T: Codable, R: Codable>(inputType: T.Type, returnType: R.Type, urlType: TypeOfAppURL, path: String) async throws -> (HTTPURLResponse, R) {
        
        var tempURL: URL?
        
        do {
            tempURL = try makeRequestURL(urlType: urlType, path: path)
        } catch (let error) {
            throw error
        }
        
        guard let url = tempURL else {
            throw MyRequestError.invalidURL
        }
        
        // MARK: URL Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
    }
}
