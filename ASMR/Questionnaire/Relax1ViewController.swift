//
//  SignUpViewController.swift
//  ASMR
//
//  Created by Ying Nam lee on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import UIKit


class Relax1ViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var single2StackView: UIStackView!
    @IBOutlet weak var single2Button1: UIButton!
    @IBOutlet weak var single2Button2: UIButton!
    @IBOutlet weak var single2Button3: UIButton!
    @IBOutlet weak var single2Button4: UIButton!
    
    @IBOutlet weak var single3StackView: UIStackView!
    @IBOutlet weak var single3Button1: UIButton!
    @IBOutlet weak var single3Button2: UIButton!
    @IBOutlet weak var single3Button3: UIButton!
    @IBOutlet weak var single3Button4: UIButton!
    
    @IBOutlet weak var single4StackView: UIStackView!
    @IBOutlet weak var single4Button1: UIButton!
    @IBOutlet weak var single4Button2: UIButton!
    @IBOutlet weak var single4Button3: UIButton!
    @IBOutlet weak var single4Button4: UIButton!
    
    @IBOutlet weak var single5StackView: UIStackView!
    @IBOutlet weak var single5Button1: UIButton!
    @IBOutlet weak var single5Button2: UIButton!
    @IBOutlet weak var single5Button3: UIButton!
    @IBOutlet weak var single5Button4: UIButton!
    
    @IBOutlet weak var single6StackView: UIStackView!
    @IBOutlet weak var single6Button1: UIButton!
    @IBOutlet weak var single6Button2: UIButton!
    @IBOutlet weak var single6Button3: UIButton!
    @IBOutlet weak var single6Button4: UIButton!
    
    @IBOutlet weak var single7StackView: UIStackView!
    @IBOutlet weak var single7Button1: UIButton!
    @IBOutlet weak var single7Button2: UIButton!
    @IBOutlet weak var single7Button3: UIButton!
    @IBOutlet weak var single7Button4: UIButton!
    
    @IBOutlet weak var single8StackView: UIStackView!
    @IBOutlet weak var single8Button1: UIButton!
    @IBOutlet weak var single8Button2: UIButton!
    @IBOutlet weak var single8Button3: UIButton!
    @IBOutlet weak var single8Button4: UIButton!
    
    @IBOutlet weak var single9StackView: UIStackView!
    @IBOutlet weak var single9Button1: UIButton!
    @IBOutlet weak var single9Button2: UIButton!
    @IBOutlet weak var single9Button3: UIButton!
    @IBOutlet weak var single9Button4: UIButton!
    
    @IBOutlet weak var single10StackView: UIStackView!
    @IBOutlet weak var single10Button1: UIButton!
    @IBOutlet weak var single10Button2: UIButton!
    @IBOutlet weak var single10Button3: UIButton!
    @IBOutlet weak var single10Button4: UIButton!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    var questions: [Question] = [
        Question(text: "Which of these would you do to relax?",
                 type: .single,
                 answers: [
                    Answer(text: "Watch a film", type: .light),
                    Answer(text: "Bake a cake", type: .eating),
                    Answer(text: "Go for a walk", type: .crinkling),
                    Answer(text: "Draw", type: .concentration)
            ]),
        Question(text: "When you dream, do you dream of things like…",
                 type: .single,
                 answers: [
                    Answer(text: "UFO and Aliens", type: .tapping),
                    Answer(text: "Your teeth falling out", type: .pageTurning),
                    Answer(text: "Flying", type: .physicalTouch),
                    Answer(text: "Driving Cars", type: .eating)
            ]),
//        Question(text: "It’s the middle of a storm and a lady mutters something but the wind is too loud to hear her. Do you….",
//                 type: .single,
//                 answers: [
//                    Answer(text: "I dislike them", type: .crinkling),
//                    Answer(text: "I get a little nervous", type: .physicalTouch),
//                    Answer(text: "I barely notice them", type: .whispering),
//                    Answer(text: "I love them", type: .pageTurning)
//            ]),
        Question(text: "It’s the middle of a storm and a lady mutters something but the wind is too loud to hear her. Do you….",
             type: .single,
             answers: [
                Answer(text: "Offer her your umbrella to keep dry", type: .light),
                Answer(text: "Pretend you have heard her", type: .physicalAttention),
                Answer(text: "Run a mile, this is too spooky for you", type: .concentration),
                Answer(text: "You want to hear what she has to say", type: .roleplay)
        ]),
        Question(text: "Pick a color",
             type: .single,
             answers: [
                Answer(text: "Orange", type: .physicalTouch),
                Answer(text: "Blue", type: .massage),
                Answer(text: "Red", type: .eating),
                Answer(text: "Silver", type: .concentration)
        ]),
        Question(text: "If you were in space what would you most like to do?",
             type: .single,
             answers: [
                Answer(text: "Float outside the space ship", type: .massage),
                Answer(text: "Drink from the shiny tiny packets", type: .whispering),
                Answer(text: "Try and contact aliens", type: .physicalTouch),
                Answer(text: "Walk on the moon", type: .pageTurning)
        ]),
        Question(text: "Which one of these can you do - if you can do all of them, which is your favourite",
             type: .single,
             answers: [
                Answer(text: "Whistle", type: .roleplay),
                Answer(text: "Fart with your armpit", type: .tapping),
                Answer(text: "Read others' heart", type: .physicalAttention),
                Answer(text: "Roll you tongue", type: .crinkling)
        ]),
        Question(text: "What is your favourite season",
             type: .single,
             answers: [
                Answer(text: "Spring", type: .tapping),
                Answer(text: "Summer", type: .whispering),
                Answer(text: "Winter", type: .massage),
                Answer(text: "Autumn", type: .physicalAttention)
        ]),
        Question(text: "Which book would you rather read?",
             type: .single,
             answers: [
                Answer(text: "Harry Potter", type: .pageTurning),
                Answer(text: "Ronald Dahl", type: .roleplay),
                Answer(text: "Tracey Beaker", type: .whispering),
                Answer(text: "You'd rather play games", type: .crinkling)
        ]),
        Question(text: "Which would you rather...",
             type: .single,
             answers: [
                Answer(text: "Jump in a piles of leaves", type: .whispering),
                Answer(text: "See feathers blow in the wind", type: .crinkling),
                Answer(text: "Drip honey on toast", type: .tapping),
                Answer(text: "Cover a notebook in glitter", type: .roleplay)
        ]),
    ]

   var questionIndex = 0
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        singleButton1.layer.cornerRadius = 8.0
        singleButton2.layer.cornerRadius = 8.0
        singleButton3.layer.cornerRadius = 8.0
        singleButton4.layer.cornerRadius = 8.0
        // Do any additional setup after loading the view.
    }
    
  func updateUI() {
  singleStackView.isHidden = true
  single2StackView.isHidden = true
  single3StackView.isHidden = true
    single4StackView.isHidden = true
    single5StackView.isHidden = true
    single6StackView.isHidden = true
    single7StackView.isHidden = true
    single8StackView.isHidden = true
    single9StackView.isHidden = true
    single10StackView.isHidden = true

  navigationItem.title = "Question #\(questionIndex+1)"
    let currentQuestion = questions[questionIndex]
    let currentAnswers = currentQuestion.answers
    let totalProgress = Float(questionIndex) / Float(questions.count)
    
    questionLabel.text = currentQuestion.text
    questionProgressView.setProgress(totalProgress, animated: true)
    
    switch currentQuestion.type {
    case .single:
        updateSingleStack(using: currentAnswers)
        updateSingle2Stack(using: currentAnswers)
        updateSingle3Stack(using: currentAnswers)
        updateSingle4Stack(using: currentAnswers)
        updateSingle5Stack(using: currentAnswers)
        updateSingle6Stack(using: currentAnswers)
        updateSingle7Stack(using: currentAnswers)
        updateSingle8Stack(using: currentAnswers)
        updateSingle9Stack(using: currentAnswers)
        updateSingle10Stack(using: currentAnswers)
    }
}
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    func updateSingle2Stack(using answers: [Answer]) {
        single2StackView.isHidden = false
        single2Button1.setTitle(answers[0].text, for: .normal)
        single2Button2.setTitle(answers[1].text, for: .normal)
        single2Button3.setTitle(answers[2].text, for: .normal)
        single2Button4.setTitle(answers[3].text, for: .normal)
    }
    func updateSingle3Stack(using answers: [Answer]) {
        single3StackView.isHidden = false
        single3Button1.setTitle(answers[0].text, for: .normal)
        single3Button2.setTitle(answers[1].text, for: .normal)
        single3Button3.setTitle(answers[2].text, for: .normal)
        single3Button4.setTitle(answers[3].text, for: .normal)
    }
    func updateSingle4Stack(using answers: [Answer]) {
        single4StackView.isHidden = false
        single4Button1.setTitle(answers[0].text, for: .normal)
        single4Button2.setTitle(answers[1].text, for: .normal)
        single4Button3.setTitle(answers[2].text, for: .normal)
        single4Button4.setTitle(answers[3].text, for: .normal)
    }
    func updateSingle5Stack(using answers: [Answer]) {
        single5StackView.isHidden = false
        single5Button1.setTitle(answers[0].text, for: .normal)
        single5Button2.setTitle(answers[1].text, for: .normal)
        single5Button3.setTitle(answers[2].text, for: .normal)
        single5Button4.setTitle(answers[3].text, for: .normal)
    }
    func updateSingle6Stack(using answers: [Answer]) {
        single6StackView.isHidden = false
        single6Button1.setTitle(answers[0].text, for: .normal)
        single6Button2.setTitle(answers[1].text, for: .normal)
        single6Button3.setTitle(answers[2].text, for: .normal)
        single6Button4.setTitle(answers[3].text, for: .normal)
    }
    func updateSingle7Stack(using answers: [Answer]) {
        single7StackView.isHidden = false
        single7Button1.setTitle(answers[0].text, for: .normal)
        single7Button2.setTitle(answers[1].text, for: .normal)
        single7Button3.setTitle(answers[2].text, for: .normal)
        single7Button4.setTitle(answers[3].text, for: .normal)
    }
    func updateSingle8Stack(using answers: [Answer]) {
        single8StackView.isHidden = false
        single8Button1.setTitle(answers[0].text, for: .normal)
        single8Button2.setTitle(answers[1].text, for: .normal)
        single8Button3.setTitle(answers[2].text, for: .normal)
        single8Button4.setTitle(answers[3].text, for: .normal)
    }
    func updateSingle9Stack(using answers: [Answer]) {
        single9StackView.isHidden = false
        single9Button1.setTitle(answers[0].text, for: .normal)
        single9Button2.setTitle(answers[1].text, for: .normal)
        single9Button3.setTitle(answers[2].text, for: .normal)
        single9Button4.setTitle(answers[3].text, for: .normal)
    }
    func updateSingle10Stack(using answers: [Answer]) {
        single10StackView.isHidden = false
        single10Button1.setTitle(answers[0].text, for: .normal)
        single10Button2.setTitle(answers[1].text, for: .normal)
        single10Button3.setTitle(answers[2].text, for: .normal)
        single10Button4.setTitle(answers[3].text, for: .normal)
    }
    
    
    
    

    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }

    @IBAction func single2AnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case single2Button1:
            answersChosen.append(currentAnswers[0])
        case single2Button2:
            answersChosen.append(currentAnswers[1])
        case single2Button3:
            answersChosen.append(currentAnswers[2])
        case single2Button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func single3AnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case single3Button1:
            answersChosen.append(currentAnswers[0])
        case single3Button2:
            answersChosen.append(currentAnswers[1])
        case single3Button3:
            answersChosen.append(currentAnswers[2])
        case single3Button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func single4AnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case single4Button1:
            answersChosen.append(currentAnswers[0])
        case single4Button2:
            answersChosen.append(currentAnswers[1])
        case single4Button3:
            answersChosen.append(currentAnswers[2])
        case single4Button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    @IBAction func single5AnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case single5Button1:
            answersChosen.append(currentAnswers[0])
        case single5Button2:
            answersChosen.append(currentAnswers[1])
        case single5Button3:
            answersChosen.append(currentAnswers[2])
        case single5Button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    @IBAction func single6AnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case single6Button1:
            answersChosen.append(currentAnswers[0])
        case single6Button2:
            answersChosen.append(currentAnswers[1])
        case single6Button3:
            answersChosen.append(currentAnswers[2])
        case single6Button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    @IBAction func single7AnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case single7Button1:
            answersChosen.append(currentAnswers[0])
        case single7Button2:
            answersChosen.append(currentAnswers[1])
        case single7Button3:
            answersChosen.append(currentAnswers[2])
        case single7Button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    @IBAction func single8nswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case single8Button1:
            answersChosen.append(currentAnswers[0])
        case single8Button2:
            answersChosen.append(currentAnswers[1])
        case single8Button3:
            answersChosen.append(currentAnswers[2])
        case single8Button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    @IBAction func single9AnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case single9Button1:
            answersChosen.append(currentAnswers[0])
        case single9Button2:
            answersChosen.append(currentAnswers[1])
        case single9Button3:
            answersChosen.append(currentAnswers[2])
        case single9Button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    @IBAction func single10AnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case single10Button1:
            answersChosen.append(currentAnswers[0])
        case single10Button2:
            answersChosen.append(currentAnswers[1])
        case single10Button3:
            answersChosen.append(currentAnswers[2])
        case single10Button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! RelaxResultViewController
            resultsViewController.responses = answersChosen
        }
    }

    
}
