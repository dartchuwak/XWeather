//
//  NetworkService.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 17.01.2026.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T:Decodable>(url: String) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    func fetchData<T: Decodable>(url: String) async throws -> T {
        let url = URL(string: url)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
}
