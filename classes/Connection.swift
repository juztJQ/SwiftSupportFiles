//
//  Connection.swift
//  BoyacaTerritorioDeSabores
//
//  Created by Juan Quiroga on 28/04/18.
//  Copyright © 2018 Juan Quiroga. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Connection {
    static let URL_SITE = "http://boyacaterritoriodesabores.com/"
    //static let URL_SITE = "http://bts.appsolution.co/" //dev
    static let URL_API = URL_SITE + "api/"
    
    static let URL_FACTORY = URL_API + "factories"
    static let URL_FACTORY_DETAILS  = URL_API + "factories/"
    static let URL_PRODUCT = URL_API + "products"
    static let URL_PRODUCT_DETAIL = URL_API + "product/"
    static let URL_PRODUCT_SEARCH = URL_API + "products?"
    static let URL_NEWS = URL_API + "news"
    static let URL_NEWS_DETAIL = URL_API + "new/"
    static let URL_EVENT = URL_API + "events"
    static let URL_EVENT_DETAIL = URL_API + "event/"
    static let URL_ANNOUNCEMENT = URL_API + "announcements"
    static let URL_ANNOUNCEMENT_DETAIL = URL_API + "announcements/"
    static let URL_SECTORS = URL_API + "sectors_list/"
    static let URL_CITY = URL_API + "towns_list/"
    static let URL_SEND_MESSAGE = URL_API + "sendmessage"
    static let URL_REGISTER_TOKEN = URL_API + "sendPushToken"
    
    
    static let sharedInstance=Connection()
    static let TIME_OUT=25.0
    
    var manager:SessionManager?
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = Connection.TIME_OUT
        configuration.timeoutIntervalForRequest = Connection.TIME_OUT
        manager = Alamofire.SessionManager(configuration:configuration)
    }
    
    func getFactory(onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        manager?.request(Connection.URL_FACTORY, method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getFactoryDetails(id : String , onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        manager?.request("\(Connection.URL_FACTORY_DETAILS)\(id)", method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getProduct(onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        manager?.request(Connection.URL_PRODUCT, method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getProductDetail( id: String , onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        manager?.request("\(Connection.URL_PRODUCT_DETAIL)\(id)", method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getProductSearch( idCity: String ,idSector :String , onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        print("\(Connection.URL_PRODUCT_SEARCH)town_id=\(idCity)&sector_id=\(idSector)")
        manager?.request("\(Connection.URL_PRODUCT_SEARCH)town_id=\(idCity)&sector_id=\(idSector)", method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getNews(onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        manager?.request(Connection.URL_NEWS, method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getNewDetail(id : String, onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        print("\(Connection.URL_NEWS_DETAIL)\(id)")
        manager?.request("\(Connection.URL_NEWS_DETAIL)\(id)", method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getAnoncment(onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        manager?.request(Connection.URL_ANNOUNCEMENT, method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getAnoncmentDetail(id : String ,onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        manager?.request("\(Connection.URL_ANNOUNCEMENT_DETAIL)\(id)", method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getCityList(onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        manager?.request(Connection.URL_CITY, method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func getSector(onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        manager?.request(Connection.URL_SECTORS, method: .get).responseString{response in
            //print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func sendMessage(name : String , email : String, message : String , onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        let params = [
            "name" : name,
            "email" : email,
            "message" : message
        ]
        
        manager?.request("\(Connection.URL_SEND_MESSAGE)", method: .post, parameters:params).responseString{response in
            print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func sendRegisterToken( token : String, onSuccess:@escaping ((JSON)->Void),onError:@escaping ((Error)->Void)) {
        let params = [
            "push_token" : token
        ]
        
        manager?.request("\(Connection.URL_REGISTER_TOKEN)", method: .post, parameters:params).responseString{response in
            print(response)
            switch response.result {
            case .success(let value):
                let encodedString : Data = (value.trimmingCharacters(in:.whitespaces) as NSString).data(using: String.Encoding.utf8.rawValue)!
                do{
                    let json = try! JSON(data:encodedString)
                    // json["statusCode"] = JSON("\(response.response!.statusCode)")
                    onSuccess(json)
                }
                
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    
}
