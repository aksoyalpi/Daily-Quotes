//
//  Quote_WidgetBundle.swift
//  Quote-Widget
//
//  Created by Alperen Aksoy on 15.09.25.
//

import WidgetKit
import SwiftUI

@main
struct Quote_WidgetBundle: WidgetBundle {
    var body: some Widget {
        Quote_Widget()
        Quote_WidgetControl()
    }
}
