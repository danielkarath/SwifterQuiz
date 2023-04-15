//
//  IDQStatsMetricBoxViewViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//

import Foundation
import SwiftUI
import CoreData

final class IDQStatsMetricBoxViewViewModel {
    
    //MARK: - Public
    enum ResultValueType {
        case percentage
        case wholeNum
        case time
    }
    
    public func convertToString(value: Double, type: ResultValueType) -> String {
        if type == .percentage {
            let myDouble = value * 100
            if myDouble.truncatingRemainder(dividingBy: 1) == 0 {
                return String(String((myDouble.rounded())).dropLast(2))//.appending("%")
            } else {
                return String(String((round(myDouble * 10) / 10)))//.appending("%")
            }
        } else if type == .wholeNum {
            return String(String(value.rounded()).dropLast(2))
        } else {
            let myDouble = ceil(value)
            return String(String(myDouble).dropLast(2))
        }
    }
    
}
