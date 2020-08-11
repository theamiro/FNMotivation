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
    func getDate() -> String {
        var convertedDate: String = ""
        
        let dateComponents = self.components(separatedBy: "T")
        let splitDate = dateComponents[0]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "M/dd/yyyy"
        
        if let date = dateFormatter.date(from: splitDate){
            convertedDate = newDateFormatter.string(from: date)
        }
        return convertedDate
    }
    func getTime() -> String {
        var convertedTime: String = ""
        
        let dateComponents = self.components(separatedBy: "T")
        let splitTime = dateComponents[1]
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss.SSSX"
        let newTimeFormatter = DateFormatter()
        newTimeFormatter.dateFormat = "H:mm a"
        
        if let time = timeFormatter.date(from: splitTime){
            convertedTime = newTimeFormatter.string(from: time)
        }
        
        return convertedTime
    }
    func getDateTime() -> String {
        var dateTime: String = ""
        
        dateTime = getTime() + getDate()
        
        return dateTime
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
