//  NetworkManager.swift

import Foundation

class NetworkManager {
    
    // Singleton instance
    static let shared = NetworkManager()
    
    private init() {}
    
    // Fetch data from a REST API
    func fetchData(url: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, NSError(domain: "Invalid URL", code: 400, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, error)
        }.resume()
    }
    
    // Example usage with JSON decoding
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
