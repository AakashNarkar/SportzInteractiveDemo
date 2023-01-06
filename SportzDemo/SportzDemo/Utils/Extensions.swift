//
//  Extensions.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import Foundation

extension String {
    func getFormattedDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yyyy"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"
        
        let date = dateFormatterGet.date(from: self)
        return dateFormatterPrint.string(from: date!)
    }
}
