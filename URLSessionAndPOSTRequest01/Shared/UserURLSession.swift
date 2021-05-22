//
//  UserURLSession.swift
//  URLSessionAndPOSTRequest01
//
//  Created by Petro Onishchuk on 5/15/21.
//

import Foundation

class UserURLSession {
    static let shared = UserURLSession()
    
    func userPostRequest(completionHandler: @escaping (User) -> Void) {
        
        // MARK: URL Components
        var components = URLComponents()
        components.scheme = "https"
        components.host = "reqres.in"
        components.path = "/api/users"
        
        
        //MARK: Create URL
        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        
        // MARK: URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //MARK: POST Request V.1.0
        let firstUser = User(name: "morpheus", job: "leader", id: nil, dateCreated: nil)
        
        guard let httpBody = try? JSONEncoder().encode(firstUser) else {
            print("Invalid httpBody")
            return
        }
        
        //MARK: POST Request V.2.0
        var secondUser = ["name" : "morpheus", "job" : "leader"]
        guard let httpBody2 = try? JSONSerialization.data(withJSONObject: secondUser, options: []) else {
            return
        }
        
        // MARK: Set httpBody
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormatter)
                    
                    let user = try decoder.decode(User.self, from: data)
                    
                    completionHandler(user)
                    
                }catch(let error) {
                    print(error.localizedDescription)
                }
            } else {
                print("No Data")
            }
        }.resume()
    }
}



extension DateFormatter {
    static let customFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_us_POSIX")
        return formatter
    }()
}
