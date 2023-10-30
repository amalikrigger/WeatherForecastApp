//
//  NetworkManager.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import Foundation

enum NetworkError: Error {
  case incorrectURL
}

enum RequestType: String {
  case GET
  case POST
}

protocol Networkable {
  func execute<T: Decodable>(_ request: Requestable, modelType: T.Type) async throws -> T?
}

struct NetworkManager: Networkable {
  func execute<T>(_ request: Requestable, modelType: T.Type) async throws -> T? where T: Decodable {
    let urlRequest = try request.getURLRequest()
    let (data, _) = try await URLSession.shared.data(for: urlRequest)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try decoder.decode(modelType.self, from: data)
  }
}

protocol Requestable {
  var baseUrl: String { get set }
  var apiKey: URLQueryItem { get set }
  var path: String { get set }
  var type: RequestType { get set }
  var params: [URLQueryItem] { get set }
  var headers: [String: String] { get set }
}

extension Requestable {
  var baseUrl: String {
    return ""
  }
  var apiKey: URLQueryItem {
    return URLQueryItem(name: "", value: nil)
  }
  var path: String {
    return ""
  }
  var type: RequestType {
    return RequestType.GET
  }
  var params: [URLQueryItem] {
    return []
  }
  var headers: [String: String] {
    return [:]
  }
}

extension Requestable {
  func getURLRequest() throws -> URLRequest {
    guard var url = URL(string: baseUrl.appending(path)) else {
      throw NetworkError.incorrectURL
    }
    url.append(queryItems: [apiKey] + params)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = type.rawValue
    return urlRequest
  }
}
