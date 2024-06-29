//
//  NetworkingManager.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 04/06/24.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case barURLResponse(url: URL)
        case unknow
        
        var errorDescription: String? {
            switch self {
            case .barURLResponse(let url): return "[🔥] Bad response from URL: \(url)"
            case .unknow: return "[⚠️] Unknow error occured."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error>  {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
        response.statusCode >= 200 &&  response.statusCode < 300 else {
            throw NetworkingError.barURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
