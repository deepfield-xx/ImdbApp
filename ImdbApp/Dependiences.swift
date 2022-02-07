//
//  Dependencies.swift
//  ImdbApp
//
//  Created by Tom on 03/02/2022.
//

import Foundation

struct Dependencies {
    private(set) var api: ImdbFetchable
    
    init(api: ImdbFetchable = ApiClient()) {
        self.api = api
    }
}
