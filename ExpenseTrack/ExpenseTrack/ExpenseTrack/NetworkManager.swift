import Foundation

/// A class that manages network requests for the application.
///
/// `NetworkManager` is responsible for fetching data from a REST API. It provides methods to fetch raw data and JSON data.
///
/// - Tag: NetworkManager
class NetworkManager {
    
    /// The singleton instance of `NetworkManager`.
    ///
    /// This instance is used to perform all network requests in the application.
    static let shared = NetworkManager()
    
    /// A private initializer to enforce the singleton pattern.
    ///
    /// This initializer is private to ensure that only one instance of `NetworkManager` is created.
    private init() {}
    
    /// Fetches data from a REST API.
    ///
    /// This method fetches raw data from a given URL. It calls the completion handler when the request is complete.
    ///
    /// - Parameters:
    ///   - url: The URL to fetch data from.
    ///   - completion: The completion handler to call when the request is complete. This handler is passed the fetched data and any error that occurred.
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
    ///
    /// This method fetches JSON data from a given URL and decodes it into a specified type. It calls the completion handler when the request is complete.
    ///
    /// - Parameters:
    ///   - url: The URL to fetch data from.
    ///   - completion: The completion handler to call when the request is complete. This handler is passed the decoded data and any error that occurred.
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
