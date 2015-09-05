//
//  Bookbase.swift
//  BookTrade
//
//  Created by Apple on 9/5/15.
//  Copyright © 2015 BookTrade. All rights reserved.
//

import Foundation

class Bookbase
{
    var books = [Book]()
    let Name: String
    
    init(N: String)
    {
        Name = N
    }
    
    func addBook(N: String, I: Int)
    {
        books.append(Book(N: N, I: I))
    }
    
    func searchBook(N: String) -> Book
    {
        for b in books
        {
            if b.Name == N
            {
                return b
            }
        }
        return Book(N: "Nil", I: 0)
    }
}