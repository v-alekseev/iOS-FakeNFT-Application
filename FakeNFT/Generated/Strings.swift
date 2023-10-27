// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Коллекция NFT
  internal static let nftCollection = L10n.tr("Localizable", "nftCollection", fallback: "Коллекция NFT")
  internal enum Alert {
    /// Отмена
    internal static let cancel = L10n.tr("Localizable", "alert.cancel", fallback: "Отмена")
    /// Ошибка
    internal static let error = L10n.tr("Localizable", "alert.error", fallback: "Ошибка")
    /// Повторить
    internal static let `repeat` = L10n.tr("Localizable", "alert.repeat", fallback: "Повторить")
  }
  internal enum Application {
    /// Фейк NFT
    internal static let title = L10n.tr("Localizable", "application.title", fallback: "Фейк NFT")
  }
  internal enum Filter {
    /// По имени
    internal static let byName = L10n.tr("Localizable", "filter.byName", fallback: "По имени")
    /// По рейтингу
    internal static let byRating = L10n.tr("Localizable", "filter.byRating", fallback: "По рейтингу")
    /// Сортировка
    internal static let caption = L10n.tr("Localizable", "filter.caption", fallback: "Сортировка")
    /// Закрыть
    internal static let close = L10n.tr("Localizable", "filter.close", fallback: "Закрыть")
  }
  internal enum HandlingError {
    /// Не удалось получить данные
    internal static let `default` = L10n.tr("Localizable", "handlingError.default", fallback: "Не удалось получить данные")
    /// По запросу ничего не найдено
    internal static let error404 = L10n.tr("Localizable", "handlingError.error404", fallback: "По запросу ничего не найдено")
    /// Ошибка обновления ресурса
    internal static let error409 = L10n.tr("Localizable", "handlingError.error409", fallback: "Ошибка обновления ресурса")
    /// Запрошенный ресурс больше недоступен
    internal static let error410 = L10n.tr("Localizable", "handlingError.error410", fallback: "Запрошенный ресурс больше недоступен")
    /// Слишком много запросов
    internal static let error429 = L10n.tr("Localizable", "handlingError.error429", fallback: "Слишком много запросов")
    /// Ошибка на стороне сервера
    internal static let error500526 = L10n.tr("Localizable", "handlingError.error500_526", fallback: "Ошибка на стороне сервера")
    /// Не удалось конвертировать полученные данные
    internal static let parsingError = L10n.tr("Localizable", "handlingError.parsingError", fallback: "Не удалось конвертировать полученные данные")
    /// Ошибка выполнения запроса
    internal static let urlRequestError = L10n.tr("Localizable", "handlingError.urlRequestError", fallback: "Ошибка выполнения запроса")
    /// Проверьте интернет-соединение
    internal static let urlSessionError = L10n.tr("Localizable", "handlingError.urlSessionError", fallback: "Проверьте интернет-соединение")
  }
  internal enum UserCard {
    /// Перейти на сайт пользователя
    internal static let userWebSite = L10n.tr("Localizable", "userCard.userWebSite", fallback: "Перейти на сайт пользователя")
  }
  internal enum UsersCollection {
    /// У пользователя ещё нет NFT
    internal static let stub = L10n.tr("Localizable", "usersCollection.stub", fallback: "У пользователя ещё нет NFT")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
