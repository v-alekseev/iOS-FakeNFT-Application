// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Alert {
    internal enum Error {
      /// Что-то пошло не так.
      internal static let description = L10n.tr("Localizable", "alert.error.description", fallback: "Что-то пошло не так.")
      /// Перезагрузить
      internal static let retry = L10n.tr("Localizable", "alert.error.retry", fallback: "Перезагрузить")
      /// Ошибка
      internal static let title = L10n.tr("Localizable", "alert.error.title", fallback: "Ошибка")
    }
  }
  internal enum Application {
    /// Localizable.strings
    ///   FakeNFT
    /// 
    ///   Created by Vitaly on 06.10.2023.
    internal static let title = L10n.tr("Localizable", "application.title", fallback: "Фейк NFT")
  }
    internal enum Catalog {
        /// Сортировка
        internal static let sort = L10n.tr("Localizable", "catalog.sort", fallback: "Сортировка")
        internal enum Collection {
            /// Автор коллекции
            internal static let authorString = L10n.tr("Localizable", "catalog.collection.authorString", fallback: "Автор коллекции")
        }
        internal enum Sort {
            /// По названию
            internal static let byName = L10n.tr("Localizable", "catalog.sort.byName", fallback: "По названию")
            /// По количеству NFT
            internal static let byNFTQuantity = L10n.tr("Localizable", "catalog.sort.byNFTQuantity", fallback: "По количеству NFT")
            /// Закрыть
            internal static let close = L10n.tr("Localizable", "catalog.sort.close", fallback: "Закрыть")
        }
    }
  internal enum Tabbar {
    /// Корзина
    internal static let basket = L10n.tr("Localizable", "tabbar.basket", fallback: "Корзина")
    /// Каталог
    internal static let catalog = L10n.tr("Localizable", "tabbar.catalog", fallback: "Каталог")
    /// Профиль
    internal static let profile = L10n.tr("Localizable", "tabbar.profile", fallback: "Профиль")
    /// Статистика
    internal static let stats = L10n.tr("Localizable", "tabbar.stats", fallback: "Статистика")
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
