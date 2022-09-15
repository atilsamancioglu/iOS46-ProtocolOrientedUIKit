//
//  UserViewModelOutput.swift
//  ProtocolOrientedUIKit
//
//  Created by Atil Samancioglu on 15.09.2022.
//

import Foundation

protocol UserViewModelOutput : AnyObject {
    func updateView(name: String, email: String, userName:String)
}
