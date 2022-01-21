//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by A101Mac on 20.01.2022.
//

import Foundation
import Combine


class NetworkManager {
    
    static let shared = NetworkManager()
    
   
    
    private var cancellables = Set<AnyCancellable>()

    
    
    func getData<T: Codable>(endpoint: ApiPath, id: Int? = nil, type: EDecode<T.Type> , baseUrl : BaseUrls ) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = URL(string: endpoint.withBaseUrl(baseUrl: baseUrl).appending(id == nil ? "" : "/\(id ?? 0)")) else {
                print("")
                return promise(.failure(NetworkError.invalidURL))
            }
            
            
            print("URL is \(url.absoluteString)")
            URLSession.shared.dataTaskPublisher(for: url)
            
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                 
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                      
                    }
                }, receiveValue: { promise(.success($0.self)) })
                .store(in: &self.cancellables)
        }
    }


    
}

enum EDecode<T> {
     case CurrencyModel
    
}

extension EDecode: PrEdecode {
    func type() -> T.Type {
        return T.self
    }
}
protocol PrEdecode {
    associatedtype T
    func type() -> T.Type
}
