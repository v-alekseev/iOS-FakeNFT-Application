# Fake NFT Application
## Описание приложения
Приложение помогает пользователям просматривать и покупать NFT (Non-Fungible Token) картинки. Функционал покупки иммитируется с помощью мокового сервера https://651ff0cc906e276284c3c1bc.mockapi.io. Приложение написано на Swift. Архитектура MVVM. [Дизайн ](https://www.figma.com/file/k1LcgXHGTHIeiCv4XuPbND/FakeNFT-(YP)?type=design&node-id=597-48015&mode=design) в Figma.

Основные функции приложения:
- просмотр коллекций NFT;
- добавление удаление из корзины
- реализация избранных NFT
- просмотр и покупка NFT (иммитируется);
- просмотр рейтинга пользователей.
- просмотр профиля пользователя

Дополнительно было реализовано:
- локализация (Swiftgen)
- тёмная тема
- сообщение о сетевых ошибках
  
## Стек
- Архитектура MVVM.
- Вёрстка кодом с Auto Layout. Дизайн в Figma.
- UITableView, UIScrollView, UITabBarController, UINavigationController.
- Работа с сетью через URLSession.
- Многопоточность; предотвращение race condition (DispatchQueue, блокировка UI).
- Используется Kingfisher. Добавлена через SPM.
- UI-тесты и Unit-тесты.

## Команда разработки и  [Доска проекта](https://github.com/users/artwist-polyakov/projects/1/views/1)
- [Vitaly Alekseev](https://github.com/v-alekseev)
- [Aleksandr Polyakov](https://github.com/artwist-polyakov)
- [Aleksandr](https://github.com/kosmonur)
- [TMWF](https://github.com/TMWF)

## Скриншоты
<img width="200" alt="Cart" src="https://github.com/v-alekseev/iOS-FakeNFT-Application/blob/main/FakeNFT/Assets.xcassets/Screenshots/Cart.imageset/2023-12-19_16-20-35.png"> <img width="200" alt="Payment" src="https://github.com/v-alekseev/iOS-FakeNFT-Application/blob/main/FakeNFT/Assets.xcassets/Screenshots/Payment.imageset/2023-12-19_16-21-30.png">

# Видео с демонстрацией работы разделов приложения
- [Раздел Корзина](https://www.loom.com/share/cea611beadf2495b8d2ee65818b58dd1)
- [Раздел Профиль](https://www.loom.com/share/35b98ee263a24fffaae3fd841d5ded36?sid=2c25fbb6-6bb2-4b7d-aca0-afaa8192fb96)
