//
//  APIClient.swift
//  theMovie-app
//
//  Created by Adriel Alves on 17/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
    var configuration: URLSessionConfiguration { get }
    
}
