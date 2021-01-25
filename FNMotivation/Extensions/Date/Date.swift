//
//  Date.swift
//  FNMotivation
//
//  Created by Michael Amiro on 27/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

extension Date {
    
    enum StringTypes{
        case full
        case minimized
    }
    
    func calendarTimeSinceNow(returnType: StringTypes) -> String {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        let years = components.year!
        let months = components.month!
        let days = components.day!
        let hours = components.hour!
        let minutes = components.minute!
        let seconds = components.second!
        
        switch returnType {
            case .full:
                if years > 0 {
                    return years == 1 ? "1 year ago": "\(years) years ago"
                } else if months > 0 {
                    return months == 1 ? "1 month ago": "\(months) months ago"
                } else if days >= 7 {
                    let weeks = days / 7
                    return weeks == 1 ? "1 week ago": "\(weeks) weeks ago"
                } else if days > 0 {
                    return days == 1 ? "1 day ago": "\(days) days ago"
                } else if hours > 0 {
                    return hours == 1 ? "1 hour ago": "\(hours) hours ago"
                } else if minutes > 0 {
                    return minutes == 1 ? "1 minute ago": "\(minutes) minutes ago"
                } else {
                    return seconds == 1 ? "1 second ago": "\(seconds) seconds ago"
            }
            case .minimized:
                if years > 0 {
                    return years == 1 ? "1 yr ago": "\(years) yrs ago"
                } else if months > 0 {
                    return months == 1 ? "1 mnth ago": "\(months) mnths ago"
                } else if days > 0 {
                    return days == 1 ? "1 dy ago": "\(days) days ago"
                } else if hours > 0 {
                    return hours == 1 ? "1 hr ago": "\(hours) hrs ago"
                } else if minutes > 0 {
                    return minutes == 1 ? "1 min ago": "\(minutes) mins ago"
                } else {
                    return seconds == 1 ? "1 sec ago": "\(seconds) secs ago"
            }
        }
    }
    
    func getDateTime(date: String) -> [String: Any] {
        
        return ["Date": ""]
    }
}
