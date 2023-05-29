//
//  Vibration.swift
//  ImageGenerator
//
//  Created by Viktoriya on 27.05.2023.
//

import UIKit

enum Vibration {
    static func vibrate(style: UIImpactFeedbackGenerator.FeedbackStyle,
                        intensity: CGFloat = 1.0) {
        if #available(iOS 13.0, *) {
            UIImpactFeedbackGenerator(style: style).impactOccurred(intensity: intensity)
        } else {
            UIImpactFeedbackGenerator(style: style).impactOccurred()
        }
    }
    
    static func notificationOccured(notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(notificationType)
    }
}
