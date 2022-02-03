//
//  ApiClient.swift
//  ImdbApp
//
//  Created by Tom on 03/02/2022.
//

import Foundation
import Alamofire
import RxSwift

final class ApiClient: ImdbFetchable {
    func getFullCast(of movieId: String) -> Observable<MovieCast> {
        return request(ApiRouter.getFullCast(movieId: movieId))
    }
    
    private func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible).responseDecodable { (result: DataResponse<T, AFError>) in
                switch result.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
