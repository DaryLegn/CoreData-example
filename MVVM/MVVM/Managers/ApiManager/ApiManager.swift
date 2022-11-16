//
//  ApiManager.swift
//  MVVM
//

import Foundation

class ApiManager {

    enum ResultTypes <T> {
        case success(T)
        case error(String)
    }

    // MARK: - Properties
    static let shared = ApiManager()
    private let baseURL = "https://api.themoviedb.org/3/discover/movie"
    private let key = "238acdd4115e187bd9b9f15502309718"

    // MARK: - Get Movies Request
    func getMoviesRequest(completion: @escaping (ResultTypes<MoviesResult>) -> Void) {
        guard var component = URLComponents(string: baseURL) else { return }

        component.queryItems = [
            URLQueryItem(name: "api_key", value: key)
        ]

        guard let url = component.url else { return }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.error(error.localizedDescription))
            } else {
                if let data = data, let result = try? JSONDecoder().decode(MoviesResult.self, from: data) {
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
            }
        }
        task.resume()
    }
}
