//
//  File.swift
//  foldy-foldy-draw-draw
//
//  Created by Bruno Scheele on 29/06/16.
//  Copyright © 2016 Marijn Schilling. All rights reserved.
//

import UIKit

protocol PasteBinServiceDelegate {
    func getStarted()
    func getFinished(result: Result<String>)
    func postStarted()
    func postFinished(result: Result<String>)
}

enum Result<T> {
    case Success(T)
    case Failure(ErrorProtocol)
}

enum Error: ErrorProtocol {
    case CouldNotCreateURL
    case CouldNotGet
    case NoData
}

struct PasteBinService {
    let pasteBinIdentifier: String
    var delegate: PasteBinServiceDelegate?
    
    init(pasteBinIdentifier: String = "xZt6jckd") {
        self.pasteBinIdentifier = pasteBinIdentifier
    }
    
    func get() {
        delegate?.getStarted()
        
        guard let url = URL(string: "https://pastebin.com/raw/\(pasteBinIdentifier)") else {
            delegate?.getFinished(result: Result.Failure(Error.CouldNotCreateURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession(configuration: URLSessionConfiguration.default()).dataTask(with: request) { (data, response, error) in
            if let _ = error {
                self.delegate?.getFinished(result: .Failure(Error.CouldNotGet))
            }
            
            guard let data = data, let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
                self.delegate?.getFinished(result: .Failure(Error.NoData))
                return
            }
            
            print(dataString)
            self.delegate?.getFinished(result: Result<String>.Success(String(dataString)))
        }.resume()
    }
    
    func post(string: String = "All your base are belong to us!", apiKey: String = "961376e4825c04153b64f7c2d26bd345") {
        delegate?.postStarted()
        
        guard let url = URL(string: "https://pastebin.com/api/api_post.php") else {
            self.delegate?.postFinished(result: .Failure(Error.CouldNotCreateURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "api_dev_key=\(apiKey)&api_option=paste&api_paste_code=\(string)".data(using: String.Encoding.utf8)
        
        URLSession(configuration: URLSessionConfiguration.default()).dataTask(with: request) { (data, response, error) in
            if let _ = error {
                self.delegate?.getFinished(result: .Failure(Error.CouldNotGet))
            }
            
            guard let data = data, let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
                self.delegate?.getFinished(result: .Failure(Error.NoData))
                return
            }
            
            print(dataString)
            self.delegate?.getFinished(result: Result<String>.Success(String(dataString)))
        }.resume()
    }
}
