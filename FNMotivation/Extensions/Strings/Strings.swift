//
//  Strings.swift
//  FNMotivation
//
//  Created by Michael Amiro on 21/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation

extension String {
//    Reduce the length of the string
    func truncate(toLength length: Int) -> String {
        if self.count > length {
            return "\(self.prefix(length))"
        } else {
            return self
        }
    }
    
    // MARK: - Date Time functions
    func getDate() -> Date {
        
        let dateComponents = self.components(separatedBy: "T")
        let splitDate = dateComponents[0]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "M/dd/yyyy"
        
        let date = dateFormatter.date(from: splitDate)
        return date!
    }
    
    func getTime() -> Date {
        
        let dateComponents = self.components(separatedBy: "T")
        let splitTime = dateComponents[1]
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss.SSSX"
        let newTimeFormatter = DateFormatter()
        newTimeFormatter.dateFormat = "H:mm a"
        
        let time = timeFormatter.date(from: splitTime)
        return time!
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    ///
    /// Provides a humanised date. For instance: 1 minute, 1 week ago, 3 months ago
    ///
    /// - Parameters:
    //      - numericDates: Set it to true to get "1 year ago", "1 month ago" or false if you prefer "Last year", "Last month"
    ///
    func timeAgo(date: Date, numericDates:Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = date < now ? date : now
        let latest =  date > now ? date : now
        
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfMonth, .month, .year, .second]
        let components: DateComponents = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        
        if let year = components.year {
            if (year >= 2) {
                return "\(year) years ago"
            } else if (year >= 1) {
                return numericDates ?  "1 year ago" : "Last year"
            }
        }
        if let month = components.month {
            if (month >= 2) {
                return "\(month) months ago"
            } else if (month >= 1) {
                return numericDates ? "1 month ago" : "Last month"
            }
        }
        if let weekOfMonth = components.weekOfMonth {
            if (weekOfMonth >= 2) {
                return "\(weekOfMonth) weeks ago"
            } else if (weekOfMonth >= 1) {
                return numericDates ? "1 week ago" : "Last week"
            }
        }
        if let day = components.day {
            if (day >= 2) {
                return "\(day) days ago"
            } else if (day >= 1) {
                return numericDates ? "1 day ago" : "Yesterday"
            }
        }
        if let hour = components.hour {
            if (hour >= 2) {
                return "\(hour) hours ago"
            } else if (hour >= 1) {
                return numericDates ? "1 hour ago" : "An hour ago"
            }
        }
        if let minute = components.minute {
            if (minute >= 2) {
                return "\(minute) minutes ago"
            } else if (minute >= 1) {
                return numericDates ? "1 minute ago" : "A minute ago"
            }
        }
        if let second = components.second {
            if (second >= 3) {
                return "\(second) seconds ago"
            }
        }
        return "Just now"
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
//    MARK: - Name Functions
    func getFirstName() -> String {
        guard let firstName = self.split(separator: " ").first else {
            return ""
        }
        return String(firstName)
    }

    func getLastName() -> String {
        guard let lastName = self.split(separator: " ").last else {
            return ""
        }
        return String(lastName)
    }
}
