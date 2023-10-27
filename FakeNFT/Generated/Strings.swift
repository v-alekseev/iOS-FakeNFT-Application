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
    /// Понятно
    internal static let button = L10n.tr("Localizable", "alert.button", fallback: "Понятно")
    /// Отмена
    internal static let cancel = L10n.tr("Localizable", "alert.cancel", fallback: "Отмена")
    /// Ошибка
    internal static let error = L10n.tr("Localizable", "alert.error", fallback: "Ошибка")
    /// Сообщение для вас!
    internal static let header = L10n.tr("Localizable", "alert.header", fallback: "Сообщение для вас!")
    /// Повторить
    internal static let `repeat` = L10n.tr("Localizable", "alert.repeat", fallback: "Повторить")
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
  internal enum Cart {
    /// К сожалению, не получилось загрузить данные. Попробуйте еще раз попозже.
    internal static let getOrderError = L10n.tr("Localizable", "cart.getOrderError", fallback: "К сожалению, не получилось загрузить данные. Попробуйте еще раз попозже.")
    /// К оплате
    internal static let paymentButtonTitle = L10n.tr("Localizable", "cart.payment_button_title", fallback: "К оплате")
    /// Цена
    internal static let priceLabelName = L10n.tr("Localizable", "cart.price_label_name", fallback: "Цена")
    internal enum DeleteConfirmScreen {
      /// Вы уверены, что хотите удалить объект из корзины?
      internal static let confiremText = L10n.tr("Localizable", "cart.DeleteConfirmScreen.confiremText", fallback: "Вы уверены, что хотите удалить объект из корзины?")
      /// Удалить
      internal static let deleteButtonTitle = L10n.tr("Localizable", "cart.DeleteConfirmScreen.deleteButtonTitle", fallback: "Удалить")
      /// Вернуться
      internal static let returnButtonTitle = L10n.tr("Localizable", "cart.DeleteConfirmScreen.returnButtonTitle", fallback: "Вернуться")
    }
    internal enum PayScreen {
      /// Выберите способ оплаты
      internal static let screenHeader = L10n.tr("Localizable", "cart.PayScreen.screenHeader", fallback: "Выберите способ оплаты")
      /// Совершая покупку, вы соглашаетесь с условиями
      internal static let termOfUseFirstString = L10n.tr("Localizable", "cart.PayScreen.termOfUseFirstString", fallback: "Совершая покупку, вы соглашаетесь с условиями")
      /// Пользовательского соглашения
      internal static let termOfUseSecondString = L10n.tr("Localizable", "cart.PayScreen.termOfUseSecondString", fallback: "Пользовательского соглашения")
    }
    internal enum CartScreen {
      /// Корзина пуста
      internal static let emptyCartMessage = L10n.tr("Localizable", "cart.cartScreen.emptyCartMessage", fallback: "Корзина пуста")
    }
    internal enum PayResultScreen {
      /// Вернуться в каталог
      internal static let buttonText = L10n.tr("Localizable", "cart.payResultScreen.buttonText", fallback: "Вернуться в каталог")
      /// Попробуйте ещё раз!
      internal static let errorAlertMessage = L10n.tr("Localizable", "cart.payResultScreen.errorAlertMessage", fallback: "Попробуйте ещё раз!")
      /// Упс! Что-то пошло не так :(
      internal static let errorAlertTitle = L10n.tr("Localizable", "cart.payResultScreen.errorAlertTitle", fallback: "Упс! Что-то пошло не так :(")
      /// Успех! Оплата прошла,
      /// поздравляем с покупкой!
      internal static let succsesPaymentText = L10n.tr("Localizable", "cart.payResultScreen.succsesPaymentText", fallback: "Успех! Оплата прошла,\nпоздравляем с покупкой!")
    }
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
  internal enum Filter {
    /// По названию
    internal static let byName = L10n.tr("Localizable", "filter.byName", fallback: "По названию")
    /// По цене
    internal static let byPrice = L10n.tr("Localizable", "filter.byPrice", fallback: "По цене")
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
  internal enum Statfilter {
    /// По имени
    internal static let byName = L10n.tr("Localizable", "statfilter.byName", fallback: "По имени")
    /// По рейтингу
    internal static let byRating = L10n.tr("Localizable", "statfilter.byRating", fallback: "По рейтингу")
    /// Сортировка
    internal static let caption = L10n.tr("Localizable", "statfilter.caption", fallback: "Сортировка")
    /// Закрыть
    internal static let close = L10n.tr("Localizable", "statfilter.close", fallback: "Закрыть")
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
