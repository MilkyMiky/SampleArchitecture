//
//  UserAPIService.swift
//  SampleArchitecture
//
//  Created by user on 07.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import Moya

enum UserAPIService {
    case getUsers
}

extension UserAPIService: TargetType {
    var baseURL: URL { URL(string: "https://jsonplaceholder.typicode.com")!}
    var headers: [String : String]? { ["Content-Type": "application/json"] }
    var path : String {
        switch self {
            case .getUsers: return "/todos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
}
