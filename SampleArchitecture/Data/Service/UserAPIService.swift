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
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com/todos")!}
    
    var path : String {
        switch self {
            case .getUsers: return ""
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
