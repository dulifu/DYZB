//
//  NetworkManager.swift
//  DYZB
//
//  Created by apple on 2020/3/11.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit
import Alamofire

enum RequestMethodType {
    case GET
    case POST
}

class NetworkManager {
    static func requestData(method: RequestMethodType, urlString: String, params: [String : String]? = nil, resultCallBack: (_ result: AnyObject) ->()) {
        let currentMethod = method == RequestMethodType.GET ? HTTPMethod.get : HTTPMethod.post
        AF.request(urlString, method: currentMethod, parameters: nil, encoder: nil, headers: nil, interceptor: nil).
    }
}
