//
//  ImdbFetchable.swift
//  ImdbApp
//
//  Created by Tom on 03/02/2022.
//

import Foundation
import RxSwift

protocol ImdbFetchable {
    func getFullCast(of movieId: String) -> Observable<MovieCast>
}
