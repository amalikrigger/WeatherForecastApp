//
//  NetworkManager.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import Foundation

enum NetworkError: Error {
  case incorrectURL
  case dataTaskError(Error)
  case decodingError(Error)
}

enum RequestType: String {
  case GET
  case POST
}

protocol Networkable {
  func execute<T: Decodable>(_ request: Requestable, modelType: T.Type) async throws -> T
}

struct NetworkManager: Networkable {
  func execute<T>(_ request: Requestable, modelType: T.Type) async throws -> T where T: Decodable {
    do {
      let urlRequest = try request.getURLRequest()
      let (data, _) = try await URLSession.shared.data(for: urlRequest)
      print(data)
      return try decodeResponse(data, modelType: modelType)
    } catch {
      print(error)
      throw NetworkError.dataTaskError(error)
    }
  }

  private func decodeResponse<T: Decodable>(_ data: Data, modelType: T.Type) throws -> T {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
      return try decoder.decode(modelType, from: data)
    } catch {
      print(error)
      throw NetworkError.decodingError(error)
    }
  }
}

protocol Requestable {
  var baseUrl: String { get }
  var apiKey: URLQueryItem? { get }
  var path: String? { get }
  var type: RequestType { get }
  var params: [URLQueryItem]? { get }
  var headers: [String: String]? { get }
}

extension Requestable {
  var baseUrl: String {
    return ""
  }

  var apiKey: URLQueryItem? {
    return nil
  }

  var path: String? {
    return ""
  }

  var type: RequestType {
    return .GET
  }

  var params: [URLQueryItem]? {
    return []
  }

  var headers: [String: String]? {
    return [:]
  }
}

extension Requestable {
  func getURLRequest() throws -> URLRequest {
    guard var url = URL(string: baseUrl.appending(path ?? "")) else {
      throw NetworkError.incorrectURL
    }
    url.append(queryItems: [apiKey].compactMap { $0 } + (params ?? []))
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = type.rawValue
    return urlRequest
  }
}

extension URL {
  mutating func append(queryItems: [URLQueryItem]) {
    guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
      return
    }
    components.queryItems = (components.queryItems ?? []) + queryItems
    self = components.url ?? self
  }
}
