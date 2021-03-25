//
//  QuizViewController.swift
//  SwiftQuiz
//
//  Created by Intacta Engenharia on 07/03/21.
//  Copyright © 2021 Emerson. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var viTimer: UIView!
    @IBOutlet var btAnswers: [UIButton]!
    @IBOutlet weak var lbQuestion: UILabel!
    
    let quizManager = QuizManager()
    
    override func viewDidLoad() {
         super.viewDidLoad()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viTimer.frame.size.width = view.frame.size.width
        UIView.animate(withDuration: 60.0, delay: 0, options: .curveLinear, animations: {
            self.viTimer.frame.size.width = 0
        }) { (success) in
            self.showResults()
        }
        
        getNewQuiz()
    }
    func getNewQuiz(){
        quizManager.refreshQuiz()
        lbQuestion.text = quizManager.question
        for i in 0..<quizManager.options.count{
            let option = quizManager.options[i]
            let button = btAnswers[i]
            button.setTitle(option, for: .normal)
        }
    }
    
    func showResults(){
        performSegue(withIdentifier: "resultSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController = segue.destination as! ResultViewController
        resultViewController.totalCorrectAnswers = quizManager.totalCorrectAnswers
        resultViewController.totalAnswers = quizManager.totalAnswers
    }

    @IBAction func selectAnswer(_ sender: UIButton) {
        let index = btAnswers.index(of: sender)!
        quizManager.validateAnswers(index: index)
        getNewQuiz()
    }
    
}
