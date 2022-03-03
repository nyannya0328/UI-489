//
//  User.swift
//  UI-489
//
//  Created by nyannyan0328 on 2022/03/03.
//

import SwiftUI

struct User: Identifiable {
    var id = UUID().uuidString
    var name : String
    var image : String
    var type : String
    var amount : String
    var color : Color
}

var users: [User] = [

    User(name: "Degrom", image: "p1", type: "Sent", amount: "-$120", color: Color.black),
    User(name: "Erika", image: "p2", type: "Received", amount: "+$35", color: Color("Orange")),
    User(name: "Manami", image: "p3", type: "Rejected", amount: "-$20", color: Color.red),
    User(name: "Roki", image: "p4", type: "Received", amount: "+$40", color: Color("Orange")),
]
