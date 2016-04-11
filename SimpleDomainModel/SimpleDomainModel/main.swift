//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

public class TestMe {
    public func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : String
    
    //Convertion Ratios
    // 1 USD = .5 GBP (2 USD = 1 GBP)
    // 1 USD = 1.5 EUR (2 USD = 3 EUR)
    // 1 USD = 1.25 CAN (4 USD = 5 CAN)
    // 1 GPB = 3 EUR
    // 1 GPB = 2.5 CAN (2 GPB = 5 CAN)
    // 3 EUR = 2.5 CAN (6 EUR = 5 CAN)
    
    public func convert(to: String) -> Money {
        var newAmount: Int;
        switch currency {
        case "USD":
            if to == "GBP" {
                newAmount = amount / 2;
                return Money(amount: newAmount, currency: "GBP")
            } else if to == "EUR" {
                newAmount = (amount * 3) / 2;
                return Money(amount: newAmount, currency: "EUR")
            } else if to == "CAN" {
                newAmount = (amount * 5) / 4;
                return Money(amount: newAmount, currency: "CAN")
            } else {
                return self;
            }
        case "GBP" :
            if to == "USD" {
                newAmount = amount * 2;
                return Money(amount: newAmount, currency: "USD")
            } else if to == "EUR" {
                newAmount = amount * 3;
                return Money(amount: newAmount, currency: "EUR")
            } else if to == "CAN" {
                newAmount = (amount * 5) / 2;
                return Money(amount: newAmount, currency: "CAN")
            } else {
                return self;
            }
        case "EUR" :
            if to == "USD" {
                newAmount = (amount * 2) / 3;
                return Money(amount: newAmount, currency: "USD")
            } else if to == "GBP" {
                newAmount = amount / 3;
                return Money(amount: newAmount, currency: "GBP")
            } else if to == "CAN" {
                newAmount = (amount * 5) / 6;
                return Money(amount: newAmount, currency: "CAN")
            } else {
                return self;
            }
        case "CAN" :
            if to == "USD" {
                newAmount = (amount * 4) / 5;
                return Money(amount: newAmount, currency: "USD")
            } else if to == "GBP" {
                newAmount = (amount * 2) / 5;
                return Money(amount: newAmount, currency: "GBP")
            } else if to == "EUR" {
                newAmount = (amount * 6) / 5;
                return Money(amount: newAmount, currency: "EUR")
            } else {
                return self;
            }
        default:
            print("Looks like the given currency doesn't match known currencies.  Please try again.")
            return self;
        }
    }
    
    
    public func add(to: Money) -> Money {
        if to.currency == currency {
            return Money(amount: amount + to.amount, currency: to.currency);
        }
        let convertedAmount = convert(to.currency);
        return Money(amount: convertedAmount.amount + to.amount, currency: to.currency);
    }
    
    
    public func subtract(from: Money) -> Money {
        if from.currency == currency {
            return Money(amount: from.amount - amount, currency: from.currency);
        }
        let convertedAmount = convert(from.currency);
        return Money(amount: from.amount - convertedAmount.amount, currency: from.currency);
    }
    
    
}

////////////////////////////////////
// Job
//
public class Job {
    public var title : String
    public var job : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title;
        self.job = type;
    }
    
    public func calculateIncome(hours: Int) -> Int {
        switch job {
        case .Hourly(let value):
            return Int(Double(hours) * value);
        case .Salary(let value):
            return value;
        }
    }
    
    public func raise(amt : Double) {
        switch job {
        case .Hourly(let value):
            self.job = Job.JobType.Hourly(amt + value);
        case .Salary(let value):
            self.job = Job.JobType.Salary(Int(amt) + value);
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    public var firstName : String = ""
    public var lastName : String = ""
    public var age : Int = 0
    private var _job : Job?
    private var _spouse: Person?
    
    public var job : Job? {
        get {
            return _job
        }
        set(value) {
            if age > 16 {
                _job = value;
            }
        }
    }
    
    public var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if (age > 18) {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    public func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]";
    }
}

////////////////////////////////////
// Family
//
public class Family {
    private var members : [Person] = []
    private var canHaveKids : Bool = false //QUESTION: CAN I HAVE THIS ADDITIONAL VAR?
    
    public init(spouse1: Person, spouse2: Person) {
        if (spouse1.spouse == nil && spouse2.spouse == nil && spouse1.age > 18 && spouse2.age > 18) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
            canHaveKids = spouse1.age > 21 || spouse2.age > 21
        }
    }
    
    // QUESTION: DO YOU WANT ME TO SET THE AGE TO 0?? 
    public func haveChild(child: Person) -> Bool {
        if canHaveKids {
            members.append(child)
            return true
        }
        return false
    }
    
    
    //QUESTION: HOW TO CALCULATE HOURLY INCOME PEOPLE
    public func householdIncome() -> Int {
        var total: Int = 0
        for person in members {
            if person.job != nil {
                total = total + (person.job?.calculateIncome(2000))!
            }
        }
        return total;
    }
}





