//
//  NetworkResult.swift
//  NetworkAPI
//
//  Created by Иван Лукъянычев on 24.07.2024.
//

import Foundation


/// result с возвращением String в случае ошибки
public enum NResult {
    
    /// A success, storing a `Success` value.
    case success(Decodable)
    
    /// A failure, storing a `Failure` value.
    case failure(String)
}


