//
//  Book.swift
//  BookTrade
//
//  Created by Apple on 9/5/15.
//  Copyright © 2015 BookTrade. All rights reserved.
//

import Foundation

class Book
{
    let Name: String
    let ISBN: Int
    var SpecBooks = [SpecificBook]()
    
    init(N: String, I: Int)
    {
        Name = N
        ISBN = I
    }
    
    func addSpecBook(P: Double, S: Student)
    {
        SpecBooks.append(SpecificBook(P: P, S: S))
    }
}