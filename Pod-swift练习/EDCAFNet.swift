//
//  EDCAFNnet.swift
//  Pod-swift练习
//
//  Created by edc on 2017/4/7.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit
import AFNetworking


enum EDCHTTPMethod {
    case GET
    case POST
}

class EDCAFNet: AFHTTPSessionManager {

    /// 静态区／常量／闭包
    /// 在第一次访问时，执行闭包，并且将结果保存在 shared 常量中
    static let shared:EDCAFNet = {
        // 实例化对象
        let manager = EDCAFNet()
        
        // 设置响应反序列化支持的数据类型
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        //申明上传的数据是json类型
        manager.requestSerializer = AFJSONRequestSerializer.init()
        //申明返回的结果是json类型
 
        //Swift
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField:
            "Content-Type")
        manager.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json","text/json","text/javascript","text/html") as? Set<String>
        
        
        //配置 OC
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        
        
        // 如果报接受类型不一致请替换一致text/html或别的
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//            @"text/json",
//             @"text/javascript",
//              @"text/html", nil];
//        
//       manager.responseSerializer =AFHTTPResponseSerializer.init()
       
        manager.requestSerializer.timeoutInterval = 10
        
        
        // 返回对象
        return manager
        
    }()
    
    // 将成功和失败的回调写在一个逃逸闭包中(请求)
    // MARK: 封装 AFN 的 GET / POST 请求
    ///
    /// - parameter method:     GET / POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter completion: 完成回调[json(字典／数组), 是否成功]
    
    func request(requestType :EDCHTTPMethod, url : String, parameters : [String : Any], resultBlock : @escaping([String : Any]?, Error?) -> ()) {
        
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            resultBlock(responseObj as? [String : Any], nil)
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            resultBlock(nil, error)
        }
        
        // Get 请求
        if requestType == .GET {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // Post 请求
        if requestType == .POST {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }
    
    // MARK: - 封装 AFN 上传方法
    /// 上传文件必须是 POST 方法，GET 只能获取数据
    /// 封装 AFN 的上传文件方法
    ///
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter name:       接收上传数据的服务器字段(name - 要咨询公司的后台) `pic`
    /// - parameter data:       要上传的二进制数据
    /// - parameter completion: 完成回调
    func unload(urlString: String, parameters: AnyObject?, constructingBodyWithBlock:((_ formData:AFMultipartFormData) -> Void)?, uploadProgress: ((_ progress:Progress) -> Void)?, success: ((_ responseObject:AnyObject?) -> Void)?, failure: ((_ error: NSError) -> Void)?) -> Void {
        
        
        EDCAFNet.shared.post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            
            
        }, progress: { (progress) in
            uploadProgress!(progress)
        }, success: { (task, objc) in
            if objc != nil {
                
                success!(objc as AnyObject?)
                
            }
        }, failure: { (task, error) in
            failure!(error as NSError)
            
        })
        
    }
    
    
    
    //
    
    /*
     // 将成功和失败的回调分别写在两个逃逸闭包中
     func request(requestType : WZYRequestType, url : String, parameters : [String : Any], succeed : @escaping([String : Any]?) -> (), failure : @escaping(Error?) -> ()) {
     
     // 成功闭包
     let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
     succeed(responseObj as? [String : Any])
     }
     
     // 失败的闭包
     let failureBlock = { (task: URLSessionDataTask?, error: Error) in
     failure(error)
     }
     
     // Get 请求
     if requestType == .Get {
     get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
     }
     
     // Post 请求
     if requestType == .Post {
     post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
     }
     }
     
     */
    
}
    
    

