//
//  MessagePreviewModel.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 18.08.2024.
//

import Foundation

enum MessagePreviewType {
    case basic
    case location
    case poll
    case contact
    case sticker
    case unknown
}

enum MessageInputType {
    case file
    case photo
}

struct DayModel {
    let messages: [MessagePreviewModel]
    let date: Date
}

struct MessagePreviewModel {
    let type: MessagePreviewType
    let text: String
    let input: [MessageInputType]
    let scheduleTime: Date
    let chanelName: String
    let accountPhone: String
    let accountName: String
}
