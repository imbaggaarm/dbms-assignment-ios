//
//  RESTfulAPIClient.swift
//  lab_mmt
//
//  Created by Imbaggaarm on 10/30/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import Alamofire
import PromisedFuture

final class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route: URLRequestConvertible, decoder: JSONDecoder = JSONDecoder()) -> Future<T> {
        return Future(operation: { completion in
            AF.request(route).responseDecodable(decoder: decoder, completionHandler: { (response: AFDataResponse<T>) -> Void in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        })
    }
    
    static func register(email: String, password: String) -> Future<LoginResponse> {
        let route = AuthRouter.register(email: email, password: password)
        return performRequest(route: route)
    }
    
    static func login(email: String, password: String) -> Future<LoginResponse> {
        let route = AuthRouter.login(email: email, password: password)
        return performRequest(route: route)
    }
    
    static func logout() -> Future<LogoutResponse> {
        let route = AuthRouter.logout
        return performRequest(route: route)
    }
    
    static func deleteAccount() -> Future<BaseResponse> {
        let route = AuthRouter.delete
        return performRequest(route: route)
    }
    
    static func getUserCourses() -> Future<CoursesResponse> {
        let route = UserEndPoint.courses
        return performRequest(route: route)
    }
    
    static func getCourses(offSet: UInt) -> Future<CoursesResponse> {
        let route = CourseEndpoint.getCourses(offSet: offSet)
        return performRequest(route: route)
    }
    
    static func courseDetail(id: UInt) -> Future<CourseDetailReponse> {
        let route = CourseEndpoint.courseDetail(id: id)
        return performRequest(route: route)
    }
    
    static func updateUserProfile(firstName: String, lastName: String) -> Future<UserProfileResponse> {
        let route = UserEndPoint.updateProfile(firstName: firstName, lastName: lastName)
        return performRequest(route: route)
    }
    
    static func getComments(courseID: UInt, offSet: UInt) -> Future<CommentsResponse> {
        let route = CommentEndpoint.getComments(courseID: courseID, offSet: offSet)
        return performRequest(route: route)
    }
    
    static func createComment(cmt: [String: Any]) -> Future<CommentResponse> {
        let route = CommentEndpoint.createComment(comment: cmt)
        return performRequest(route: route)
    }

}
