//
//  NetworkHandler.swift
//  SixtCarFinderTest
//
//  Created by Carlos Arenas on 5/31/19.
//  Copyright © 2019 CA. All rights reserved.
//

import Foundation

public final class NetworkClient {
  
  // MARK: - Instance Properties
  internal let baseURL: URL
  internal let session = URLSession.shared
  
  // MARK: - Class Constructors
  public static let shared: NetworkClient = {
    let file = Bundle.main.path(forResource: "ServerEnvironments", ofType: "plist")!
    let dictionary = NSDictionary(contentsOfFile: file)!
    let urlString = dictionary["service_url"] as! String
    let url = URL(string: urlString)!
    return NetworkClient(baseURL: url)
  }()
  
  // MARK: - Object Lifecycle
  private init(baseURL: URL) {
    self.baseURL = baseURL
  }
  
  public func getProducts(success _success: @escaping (CarsReponse) -> Void,
                          failure _failure: @escaping (NetworkError) -> Void) {
    
    let success: (CarsReponse) -> Void = { products in
      DispatchQueue.main.async { _success(products) }
    }
    let failure: (NetworkError) -> Void = { error in
      DispatchQueue.main.async { _failure(error) }
    }
    
    let task = session.dataTask(with: baseURL, completionHandler: { (data, response, error) in
      
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
        let carList = try JSONDecoder().decode(CarsReponse.self, from: data)
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
