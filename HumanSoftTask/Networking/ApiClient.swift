//
//  ApiClient.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class ApiClient {
    
    static func getUsers() -> Observable<[User]> {
        return request(ApiRouter.getUsers)
    }
    
    static func getAlbums(userId: Int) -> Observable<[Album]> {
        return request(ApiRouter.getAlbums(userId: userId))
    }
    
    static func getAlbumItems(albumId: Int) -> Observable<[AlbumItem]> {
        return request(ApiRouter.getAlbumItems(albumId: albumId))
    }

    //MARK: - request function to get results as Observable
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        
        //Create RxSwift observable
        return Observable<T>.create { observer in
            let request = AF
                .request(urlConvertible)
                .responseJSON { (response) in
                    switch response.result{
                    case .success(let value):

                        let decoder = JSONDecoder()
                        let data = try! JSONSerialization.data(withJSONObject: value)

                        do {
                            let decodedData = try decoder.decode(T.self, from: data)
                            observer.onNext(decodedData)
                            observer.onCompleted()
                        } catch let error {
                            observer.onError(error)
                        }
                        
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

