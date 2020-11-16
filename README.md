# openHeroes
|||
|-:|:-|
|![openHeroesLogo](readme-img/openHeroes-iOS-icon-225px-trans.png "openHeroes")|This is a Swift (UIKit) App -  using the *[Marvel Characters API][apiMarvel]* - Please, feel free to comment, feedback are welcome - *Scroll down for changelog* - |
|||
|Some interesting point to hightlight:||
|>>|**VIPER architecture** (really not necessary for this small proyect, but thiking on scale the App)|
|>>|**SOLID** principles followeded and **tried to be as CLEAN** as possible  <<|
|>>|Some **Unit Test**|
|<<|I did not have much time to think in the UI, so invite you to take a look on this **[myHeroes][myHeroes]** or this **[marvelous][marvelous]** small projects


## Changelog

### 1.0.2
- [x] Improve error control.
- [x] Add Unit test.

### 1.0.1
- [x] fix: now the interactor owns the [listItem], it was moved form presenter onto interactor.
- [x] move some Color, Font and SFSymbols configuration into UIColor and UIFont extensions.
- [x] LaunchScreen dark mode frindly.

### 1.0.0
- [x] List and Detail modules.
- [x] Local persistance.
- [x] Very basic UI (not prioritary for this project).
- [x] Using Alamofire (instead URLSession) to simplify the network layer.
- [x] App works fine with **Dark and Light modes**.

> *"Data provided by Marvel. © 2014 Marvel"*

[//]: # (links)

   [myHeroes]: <https://github.com/iPonCode/myHeroes>
   [marvelous]: <https://github.com/iPonCode/marvelous>
   [apiMarvel]: <https://developer.marvel.com/docs>
