//
//  IDQStreakWidgetBundle.swift
//  IDQStreakWidget
//
//  Created by Daniel Karath on 4/29/23.
//

import WidgetKit
import SwiftUI

@main
struct IDQStreakWidgetBundle: WidgetBundle {
    var body: some Widget {
        IDQStreakWidget()
        IDQStreakWidgetLiveActivity()
    }
}
