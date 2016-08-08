//
//  Meal.swift
//  QuickStart
//
//  Created by Flonly on 7/25/16.
//  Copyright © 2016 FlonlyIos. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding{
    
    struct  PropertyKey {
        static let nameKey = "name"
        static let photKey = "photo"
        static let ratingKey = "rating"
    }
   
    //MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meal")
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    init?(name:String, photo: UIImage?, rating: Int){
        
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        if(name.isEmpty || rating < 0 ){
            return nil
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
       aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
       aCoder.encodeObject(photo, forKey: PropertyKey.photKey)
       aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name   = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo  = aDecoder.decodeObjectForKey(PropertyKey.photKey) as! UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        self.init(name:name, photo: photo, rating: rating)
    }
}