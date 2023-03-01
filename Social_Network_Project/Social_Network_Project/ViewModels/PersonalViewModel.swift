//
//  PersonalViewModel.swift
//  Social_Network_Project
//
//  Created by Developer on 28.02.2023.
//

import Foundation
import UIKit


class PersonalViewModel: NSObject {
    
    
    var feeds: [Feed] = [Feed(feedImage: UIImage(named: "dolphins"), feedName: "Мир дельфинов", post: Post(date: Date(timeIntervalSince1970: 1674021686), description: "Дельфинами называют млекопитающих из семейства зубатых китов отряда китообразных. На планете существует около сорока видов этих животных, и увидеть их можно в любой точке Мирового океана. Большинство дельфинов предпочитают жить в тропических и субтропических широтах, но есть и такие, которым нравятся более холодные воды, поэтому увидеть их можно недалеко от Арктики, а некоторые виды встречаются и там, и там.", image: UIImage(named: "dolphins2"), likes: 180, comments: [["Как тебе фильм?", "Отличный"],["Давно ждал этот фильм", "Я тоже"],["Фильм долгий", "Но стоящий"]])),
                         Feed(feedImage: UIImage(named: "igromania"), feedName: "Igromania", post: Post(date: Date(timeIntervalSince1970: 1677408522), description: "Их банде предстоит участвовать в кражах, грабежах и перестрелках в самом сердце Америки, на неприветливой земле, где каждый день – это борьба за выживание. За ними по пятам идут федеральные агенты и лучшие в стране охотники за головами, а саму банду разрывают внутренние противоречия. Артуру предстоит выбрать, что для него важнее: его собственные идеалы или верность людям, которые его взрастили.", image: UIImage(named: "rdr"), likes: 978, comments: [["Как тебе фильм?", "Отличный"],["Давно ждал этот фильм", "Я тоже"],["Фильм долгий", "Но стоящий"]])),
                         Feed(feedImage: UIImage(named: "gym"), feedName: "Gym. Workout", post: Post(date: Date(timeIntervalSince1970: 1677408522), description: "При увеличении глубины приседаний без изменения нагрузки повышаются мускульные усилия мышц-разгибателей коленей, активность двуглавых мышц бедра, мышц позвоночника, передней части прямых мышц бедра, уменьшаются усилия разгибателей лодыжки. При уменьшении глубины приседания с увеличением нагрузки повышается активность икроножных мышц и мускульных усилий мышц-разгибателей лодыжек.", image: UIImage(named: "prised"), likes: 786, comments: [["Как тебе фильм?", "Отличный"],["Давно ждал этот фильм", "Я тоже"],["Фильм долгий", "Но стоящий"]])),
                         Feed(feedImage: UIImage(named: "it"), feedName: "Все про IT", post: Post(date: Date(timeIntervalSince1970: 1677494922), description: "Кремниевая долина обладает одной важной (помимо прочих!) особенностей – теснейшая связь индустрии с образованием. Это – самовоспроизводящаяся система, экосистема! Вот почему со всего света сюда едут учиться не только «ботаники», но и будущие бизнесмены – те, кто желает делать деньги на «ботаниках»! А все «сказки» о гнусном мире «чистогана» разбиваются о простой факт, что получить образование в Калифорнии (в том числе и в Кремниевой долине) можно дешевле, чем в родной стране!", image: UIImage(named: "valley"), likes: 756, comments: [["Как тебе фильм?", "Отличный"],["Давно ждал этот фильм", "Я тоже"],["Фильм долгий", "Но стоящий"]]))]
}
