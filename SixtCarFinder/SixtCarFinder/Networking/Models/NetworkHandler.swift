//
//  NetworkHandler.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/31/19.
//  Copyright © 2019 CA. All rights reserved.
//
// swiftlint:disable force_cast

import Foundation

public final class NetworkHandler {

  // MARK: - Instance Properties
  internal let baseURL: URL
  internal let session = URLSession.shared

  // MARK: - Class Properties
  static let serverResource = "ServerEnvironments"

  // MARK: - Class Constructors
  public static let shared: NetworkHandler? = {
    if let serverInfo = getServerInfo(for: serverResource) {
      let urlString = serverInfo["base_url"] as! String
      let url = URL(string: urlString)!
      return NetworkHandler(baseURL: url)
    }
    return nil
  }()

  // MARK: - Object Lifecycle
  private init(baseURL: URL) {
    self.baseURL = baseURL
  }

  // MARK: - Public methods
  public static func getServerInfo(for resource: String) -> NSDictionary? {
    if let file = Bundle.main.path(forResource: resource, ofType: "plist") {
      let dictionary = NSDictionary(contentsOfFile: file)!
      return dictionary
    }
    return nil
  }

  // MARK: - Endpoint
  public func getCarList(success: @escaping ([CarItem]) -> Void,
                         failure: @escaping (NetworkError) -> Void) {

    guard let serverInfo = NetworkHandler.getServerInfo(for: NetworkHandler.serverResource) else {
      failure(NetworkError(error: CustomError(message: "Couldn't load server resources file")))
      return
    }

    let carsEndpoint = serverInfo["cars_enpoint"] as! String
    let url = baseURL.appendingPathComponent(carsEndpoint)

    performGeRequest(for: url, success: { carList in
        success(carList)
    }, failure: { error in
      failure(NetworkError(error: error))
    })
  }

  // MARK: - Requests execution
  public func performGeRequest(
    for url: URL, success: @escaping ([CarItem]) -> Void, failure: @escaping (NetworkError) -> Void) {

    let success: ([CarItem]) -> Void = { cars in
      DispatchQueue.main.async { success(cars) }
    }
    let failure: (NetworkError) -> Void = { error in
      DispatchQueue.main.async { failure(error) }
    }

    let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode.isSuccessHTTPCode,
        let data = data else {
          if let error = error {
            failure(NetworkError(error: error))
          } else {
            failure(NetworkError(response: response))
          }
          return
      }

      do {
        let carList = try JSONDecoder().decode([CarItem].self, from: data)
        success(carList)
      } catch {
        failure(NetworkError(error: error))
      }

    })
    task.resume()
  }

}

extension Int {
  public var isSuccessHTTPCode: Bool {
    return 200 <= self && self < 300
  }
}
