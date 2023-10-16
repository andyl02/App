//  NetworkManager.swift

import Foundation

/// Manages network requests for the application.
class NetworkManager {
    
    /// Singleton instance of `NetworkManager`.
    static let shared = NetworkManager()
    
    /// Private initializer to enforce singleton pattern.
    private init() {}
    
    /// Fetches data from a REST API.
    /// - Parameters:
    ///   - url: The URL to fetch data from.
    ///   - completion: The completion handler to call when the request is complete.
    func fetchData(url: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, NSError(domain: "Invalid URL", code: 400, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, error)
        }.resume()
    }
    
    /// Fetches JSON data from a REST API.
    /// - Parameters:
    ///   - url: The URL to fetch data from.
    ///   - completion: The completion handler to call when the request is complete.
    func fetchJSONData<T: Decodable>(url: String, completion: @escaping (T?, Error?) -> Void) {
        fetchData(url: url) { (data, error) in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(decodedData, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
    }
}
