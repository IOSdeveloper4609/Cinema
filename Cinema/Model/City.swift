//
//  City.swift
//  Cinema
//
//  Created by Азат Киракосян on 09.01.2021.
//

import UIKit

struct CityModel {
    var image: URL?
    let title: String
    let city: City

    init(city: City) {
        self.city = city

        title = city.kkTitleRu
        image = city.picture.url
    }
}
        
       
    


    
    
    
    

