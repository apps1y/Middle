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

struct WarningModel {
    let text: String
    let completion: () -> Void
}

struct MessagePreviewModel {
    let type: MessagePreviewType
    let text: String
    let input: [MessageInputType]
    let scheduleTime: String
    let ownerName: String
    
    let accountPhoneNumber: String
    let linkOnChat: String
    
    let warning: WarningModel?
}
