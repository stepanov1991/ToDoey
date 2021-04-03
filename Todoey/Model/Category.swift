//
//  Category.swift
//  Todoey
//
//  Created by user on 30.03.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift


class Category: Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var backgroundColor : String = ""
    let items = List<Item>()
}
