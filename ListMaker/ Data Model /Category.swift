 //
//  Category.swift
//  ListMaker
//
//  Created by Padmasri Nishanth on 9/15/19.
//  Copyright © 2019 Padmasri Nishanth. All rights reserved.
//

import Foundation
import RealmSwift
 
 class Category: Object {
    
    @objc dynamic var name : String = ""
    
    // To Establish a RelationShip with the parent category 
    let items = List<Item>()
 }
