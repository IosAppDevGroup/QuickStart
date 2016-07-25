//
//  Meal.swift
//  QuickStart
//
//  Created by Flonly on 7/25/16.
//  Copyright © 2016 FlonlyIos. All rights reserved.
//

import UIKit

class Meal{
    var name: String
    var photo: UIImage?
    var rating: Int
    
    init?(name:String, photo: UIImage?, rating: Int){
        if(name.isEmpty || rating < 0 ){
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}