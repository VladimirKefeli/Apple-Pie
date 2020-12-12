//
//  ViewController.swift
//  Apple Pie
//
//  Created by Владимир Кефели on 08.12.2020.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    var currentGame: Game!
    let incorrectMovesAllowed = 7
    var listOfWords = [
       "Аист","Акула","Альбатрос",
       "Анаконда","Антилопа",
       "Анчоус","Бабочка",
       "Бабуин","Баклан","Бананоед",
       "Барабуля","Баран","Барсук",
       "Бегемот","Белка",
       "Бизон","Бобр","Броненосец",
       "Буревестник","Бурундук",
       "Варан","Волк","Воробей","Ворона",
       "Выдра","Гадюка","Газель",
       "Гамадрил","Гепард","Гиббон",
       "Глухарь","Голубь","Горилла",
       "Горлица","Двинозавр","Двухвостка","Дельфин",
       "Дрозд","Дятел","Ёж","Енот","Енотовидная собака",
       "Ёрш","Ехидна","Жаба","Жаворонок","Жако","Жираф",
       "Журавль","Заяц","Зебра","Змея",
       "Зубр","Иволга","Игуана","Кабан","Какаду","Кальмар",
       "Камбала","Камышовый кот",
       "Карась","Катран","Кенгуру",
       "Клещ","Кобра","Козёл",
       "Корнеед","Коршун","Корюшка",
       "Косатка","Косуля","Кошка","Краб",
       "Крокодил","Кролик","Крот","Крыса","Кукушка",
       "Куница","Курица","Куропатка",
       "Лама","Лань","Ласка","Ласточка","Лебедь",
       "Лев","Лемминг","Лемонема","Лемур",
       "Ленивец","Ленточник","Леопард",
       "Лесной кот","Летучая мышь","Лиса","Лось",
       "Лошадь","Лягушка","Малиновка","Мамонт","Мангуст",
       "Мартышка","Медведь белый","Медведь бурый","Моль","Морская свинка",
       "Морской котик","Морской лев","Муравей",
       "Муфлон","Муха","Мухоед","Мышь","Навага",
       "Норка","Носорог","Обезьяна","Овод","Овца","Окунь",
       "Олень","Омар","Омуль","Опоссум",
       "Орангутан","Оса","Осёл","Осётр",
       "Палтус","Панда","Паук","Пеликан","Перепел","Пересмешник",
       "Пингвин","Попугай","Пчела","Рак",
       "Рысь","Сайгак","Саламандра","Саранча",
       "Сардина","Сардинелла","Сверчок",
       "Синица","Скат","Скворец","Сколопендра",
       "Скорпион","Скумбрия","Слизень","Слон","Снегирь","Собака",
       "Сова","Сойка","Сокол","Соловей",
       "Сорока","Страус","Стрекоза",
       "Стриж","Судак","Сурок","Суслик","Сыч",
       "Таракан","Тетерев","Тигр","Тля","Тритон",
       "Трясогузка","Тунец","Тюлень","Тюлька",
       "Удав","Уж","Улитка","Устрица","Утконос",
       "Филин","Химера","Хомяк","Хорёк","Цапля",
       "Чайка","Черепаха","Шмель","Щука",
       "Ягуар","Ястреб","Ящер",
       "Ящерица","Дельфин","Кролик","Кулик"
    ].shuffled()
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    // MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }



    func newRound() {
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateUI()
            return
        }
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    
    func updateCorrectWordLabel() {
        var displayWord = [String]()
        for letter in currentGame.guessedWord {
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator:" ")
    }
    
    func updateState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if currentGame.guessedWord == currentGame.word {
            totalWins += 1
        } else {
            updateUI()
        }
        updateUI()
    }
    
    func updateUI() {
        let movesRemaining = currentGame.incorrectMovesRemaining
        let imageNumber = (movesRemaining + 64) % 8
        let image = "Tree\(imageNumber)"
        treeImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
        // MARK: - IB Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
    
}

