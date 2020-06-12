//
//  BaseApiClient.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

open class BaseApiClient {

    static let BASE_URL =  "https://api.themoviedb.org/3/"
    
    func reuqestApiWithHeaders<T>(
        url:String,
        method:HTTPMethod,
        params:Parameters,
        value: T.Type,
        headers:HTTPHeaders = [:],
        encoding: ParameterEncoding = URLEncoding.default
    ) -> Observable<T>  where T : Codable {
        
        let headers: HTTPHeaders = []
        
        return Observable<T>.create { (observer) -> Disposable in
            
            let main_url = BaseApiClient.BASE_URL + url
            let request = AF.request( main_url , method: method, parameters: params, encoding: encoding ,  headers : headers)
                .responseJSON{ response in
                    
                    
                    switch response.result {
                        
                    case .success:
                        
                        if  200 ... 299 ~= response.response?.statusCode ?? 500   {
                            
                            let data:T? =  response.data?.seralizeData()
                            if let data = data {
                                observer.onNext(data)
                                observer.onCompleted()
                            }else{
                                observer.onError(NSError(domain: "Serailize Error", code: -1, userInfo: nil))
                            }
                            
                            
                        } else {
                        
                            if response.response?.statusCode ?? 500 == 403 {
                                

                                observer.onError(NSError(domain:  "Invalid Token", code: 403, userInfo: nil))
                                
                            }else{
                                
                                let error:ErrorResponse? = response.data?.seralizeData()
                        
                                observer.onError(NSError(domain: error?.message ?? "", code: response.response?.statusCode ?? 500, userInfo: nil))
                            }
                        
                            
                        }
                        
                    case .failure(let error):
                        
                        observer.onError(error)
                    }
            }
            
            return Disposables.create(with: {
                request.cancel()
            })
            
        }
        
    }
    
    func requestApiWithoutObservable(
        url: String,
        method: HTTPMethod,
        params: Parameters,
        encoding: ParameterEncoding = URLEncoding.default,
        success: @escaping(Data) -> Void,
        fail: @escaping(String) -> Void
    ){
        AF.request(BaseApiClient.BASE_URL + url, method: method, parameters: params, encoding: encoding).responseJSON { (response) in
            
            switch response.result {
            case .success:
                success(response.data!)
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                
                fail(error.localizedDescription)
            }
        }
    }
}
