//
//  DateTimeFormattedAsTimeAgo.swift
//  Swift Time Ago
//
//  Created by Julien Colin on 4/17/15.
//  Copyright (c) 2015 Toldino. All rights reserved.
//

import Foundation

class DateTimeFormattedAsTimeAgo {
    
    public class func displayDate(date: Date, referenceDate now: Date = Date()) -> String {
        
        let secondsFromDate = now.secondsFrom(date: date)
        if secondsFromDate < 60 {
            return secondsFormatter()
        }
        
        let minutesFromDate = now.minutesFrom(date: date)
        if minutesFromDate < 60 {
            return minutesFormatter(minutes: minutesFromDate)
        }
        
        let hoursFromDate = now.hoursFrom(date: date)
        if hoursFromDate < 24 {
            return hoursFormatter(hours: hoursFromDate)
        }
        
        let daysFromDate = now.daysFrom(date: date)
        switch daysFromDate {
        case 1:
            return yesterdayFormatter()
        case 2...6:
            return daysFormatter(days: daysFromDate)
        default:
            break
        }
        
        let weeksFromDate = now.weeksFrom(date: date)
        let monthsFromDate = now.monthsFrom(date: date)
        switch monthsFromDate {
        case 0:
            return weeksFormatter(weeks: weeksFromDate)
        case 1...11:
            return monthsFormatter(months: monthsFromDate)
        default:
            break
        }
        
        let yearsFromDate = now.yearsFrom(date: date)
        return yearsFormatter(years: yearsFromDate)
    }
}

// MARK: Formatter Private Functions
extension DateTimeFormattedAsTimeAgo {
    
    private class func classicFormatterAgo(quantity: Int, unit: String) -> String {
        var formattedString = "\(quantity) \(unit)"
        if quantity > 1 {
            formattedString += "s"
        }
        formattedString += " ago"
        return formattedString
    }
    
    private class func secondsFormatter() -> String {
        return "Just now"
    }
    
    private class func minutesFormatter(minutes: Int) -> String {
        return classicFormatterAgo(quantity: minutes, unit: "minute")
    }
    
    private class func hoursFormatter(hours: Int) -> String {
        return classicFormatterAgo(quantity: hours, unit: "hour")
    }
    
    private class func yesterdayFormatter() -> String {
        return "Yesterday"
    }
    
    private class func daysFormatter(days: Int) -> String {
        return classicFormatterAgo(quantity: days, unit: "day")
    }
    
    private class func weeksFormatter(weeks: Int) -> String {
        return classicFormatterAgo(quantity: weeks, unit: "week")
    }
    
    private class func monthsFormatter(months: Int) -> String {
        return classicFormatterAgo(quantity: months, unit: "month")
    }
    
    private class func yearsFormatter(years: Int) -> String {
        return classicFormatterAgo(quantity: years, unit: "year")
    }
}

// MARK: Extension of Date
private extension Date {
    
    func yearsFrom(date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    func monthsFrom(date:Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    func weeksFrom(date:Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    
    func daysFrom(date:Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func hoursFrom(date:Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func minutesFrom(date:Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func secondsFrom(date:Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
}
