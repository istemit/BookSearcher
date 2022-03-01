//
//  BaseNetwork.swift
//  SupermomsClub
//
//  Created by Arman Turalin on 01.03.2022.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol BaseNetworkProtocol {
    associatedtype Target: BaseTarget

    func requestJson(with target: Target, completion: @escaping (_ json: [String: Any]?, _ error: Error?) -> Void)
    func request(with target: Target, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
}

final class BaseNetwork<Target: BaseTarget>: BaseNetworkProtocol {
    private var basePath: String {
        "https://www.googleapis.com"
    }
        
    func requestJson(with target: Target, completion: @escaping (_ json: [String: Any]?, _ error: Error?) -> Void) {
        guard let url = URL(string: basePath + target.path) else { return }
        request(with: url, method: target.method) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                completion(json, nil)
            } catch let error {
                completion(nil, error)
            }
        }
    }
    
    func request(with target: Target, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = URL(string: basePath + target.path) else { return }
        request(with: url, method: target.method, completion: completion)
    }
}

// MARK: - Private methods
private extension BaseNetwork {
    func request(with url: URL, method: HttpMethod, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let configuration = URLSessionConfiguration.default

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let session = URLSession(configuration: configuration)
            session.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async { [weak self] in
                    guard let httpResponse = response as? HTTPURLResponse else { return }
                    self?.log(data: data, response: httpResponse, error: error)

                    guard let data = data else {
                        completion(nil, error)
                        return
                    }
                    completion(data, nil)
                }
            }.resume()
        }
    }
}

// MARK: - Configurations
private extension BaseNetwork {
            
    func log(data: Data?, response: HTTPURLResponse?, error: Error?){
//        let urlString = response?.url?.absoluteString
//        let components = NSURLComponents(string: urlString ?? "")
//
//        let path = "\(components?.path ?? "")"
//        let query = "\(components?.query ?? "")"
//
//        var responseLog = "\n<---------- IN ----------\n"
//        if let urlString = urlString {
//            responseLog += "\(urlString)"
//            responseLog += "\n\n"
//        }
//
//        if let statusCode =  response?.statusCode{
//            responseLog += "HTTP \(statusCode) \(path)?\(query)\n"
//        }
//        if let host = components?.host{
//            responseLog += "Host: \(host)\n"
//        }
//        for (key,value) in response?.allHeaderFields ?? [:] {
//            responseLog += "\(key): \(value)\n"
//        }
//        if let body = data{
//            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
//            responseLog += "\n\(bodyString)\n"
//        }
//        if let error = error{
//            responseLog += "\nError: \(error.localizedDescription)\n"
//        }
//
//        responseLog += "<------------------------\n";
//        print(responseLog)
    }
}
