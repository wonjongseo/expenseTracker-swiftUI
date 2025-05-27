//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Jongseo Won on 5/25/25.
//

import SwiftUI


extension Color {
    static let abackground       = Color("Background")
    static let aicon             = Color("Icon")
    static let atext             = Color("Text")
    static let systemBackground  = Color(uiColor: .systemBackground)
}


extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String  {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        return parsedDate
    }
}


extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roundedTo2Digits()-> Double {
        return (self * 100).rounded() / 100
    }
}
