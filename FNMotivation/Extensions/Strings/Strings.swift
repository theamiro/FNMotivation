//
//  Strings.swift
//  FNMotivation
//
//  Created by Michael Amiro on 21/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation

extension String {
    func truncate(toLength length: Int) -> String {
        if self.count > length {
            return "\(self.prefix(length))"
        } else {
            return self
        }
    }
}
