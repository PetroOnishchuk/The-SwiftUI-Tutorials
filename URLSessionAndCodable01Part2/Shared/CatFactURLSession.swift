//
//  CatFactURLSession.swift
//  URLSessionAndCodable01Part2
//
//  Created by Petro Onishchuk on 5/12/21.
//

import Foundation


class CatFactURLSession {
    
    static let shared = CatFactURLSession()
    
    func loadFacts(completionHandler: @escaping([CatFact]) -> Void){
        
        //URLComponents
        var components = URLComponents()
        components.scheme = "https"
        components.host = "cat-fact.herokuapp.com"
        components.path = "/facts/random"
        components.queryItems = [
        URLQueryItem(name: "animal_type", value: "cat"),
            URLQueryItem(name: "amount", value: "20")
        ]
        
        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        
        // URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //URLSession
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    
                    // MARK: Change DateFormatter
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormatter)
                   
                    let catFacts = try decoder.decode([CatFact].self, from: data)
                    
                    completionHandler(catFacts)
                    
                } catch(let error) {
                    print(error.localizedDescription)
                }
            } else {
                print("No data")
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
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
 
