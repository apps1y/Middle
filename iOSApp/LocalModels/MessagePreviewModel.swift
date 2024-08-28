//
//  MessagePreviewModel.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 18.08.2024.
//

import Foundation

/// Модель сообщения
/// - Parameters:
///   - type: тип сообщения
///   - text: текст сообщения
///   - input: приложенные файлы к сообщению
///   - scheduleTime: дата отправки сообщения
///   - ownerName: имя + канал владельца сообщения
///   - accountPhoneNumber: номер аккаунта у сообщения
///   - linkOnChat: ссылка на чат с сообщением
///   - warning: предупреждения (опционально)
struct MessagePreviewModel {
    let type: MessagePreviewType
    let text: String
    let input: [MessageInputType]
    let scheduleTime: String
    let ownerName: String
    
    let accountPhoneNumber: String
    let linkOnChat: String
    
    let unravel: UnravelModelType?
}

/// Тип сообщения
/// - Parameters:
///   - basic: обычное
///   - location: локация
///   - poll: опрос
///   - contact: контакт
///   - sticker: стикер
///   - unknown: неизвестный тип
enum MessagePreviewType {
    case basic
    case location
    case poll
    case contact
    case sticker
    case unknown
}

/// типы приложений к сообщению
/// - Parameters:
///   - file: файл
///   - photo: фото
enum MessageInputType {
    case file
    case photo
}


enum UnravelModelType {
    case tooFrequentPublications
    case samePublicationsInDifferentChannels
    case samePublicationsInOneChannel
    
    var description: String {
        switch self {
        case .tooFrequentPublications:
            return "Слишком частые публикации в канал"
        case .samePublicationsInDifferentChannels:
            return "Одинаковые публикации в разные каналы"
        case .samePublicationsInOneChannel:
            return "Одинаковые публикации в один канал"
        }
    }
}
