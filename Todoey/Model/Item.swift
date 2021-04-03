//
//  Item.swift
//  Todoey
//
//  Created by user on 30.03.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool  = false
    @objc dynamic var dateCreate : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
