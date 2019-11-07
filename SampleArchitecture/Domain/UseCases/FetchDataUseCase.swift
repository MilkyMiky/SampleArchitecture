//
//  FetchDataUseCase.swift
//  SampleArchitecture
//
//  Created by user on 06.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import RxSwift

class FetchDataUseCase  {
    
    func execute () -> Observable<String> {
        print("executed")
        return Observable.just("Hello world")
    }
    
}
