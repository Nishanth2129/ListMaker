//
//  Item.swift
//  ListMaker
//
//  Created by Padmasri Nishanth on 9/15/19.
//  Copyright © 2019 Padmasri Nishanth. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done:Bool = false
    @objc dynamic var dateCreated : Date?
    
    // To Establish a RelationShip Between the Item Class and Swift Category Class or Linking the property category 
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
