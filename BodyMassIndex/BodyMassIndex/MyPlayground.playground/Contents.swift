//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy.MM.dd"

let date: Date = Date()

print(dateFormatter.string(from: date))