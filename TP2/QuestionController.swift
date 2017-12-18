//
//  QuestionController.swift
//  TP2
//
//  Created by Sevigny on 2017-12-17.
//  Copyright © 2017 Sevigny. All rights reserved.
//

import UIKit

class QuestionController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var questionsPicker: UIPickerView!
    @IBOutlet weak var questionLabel: UILabel!
    var quiz : Quiz = Quiz(questions: [])
    var quizIndex : Int = 0
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quiz.questions[quizIndex].allAnswers.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return quiz.questions[quizIndex].allAnswers[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("questionController quiz : ", quiz.questions[quizIndex].question)
        print("quizIndex : ", quizIndex)
        questionLabel.text = quiz.questions[quizIndex].question
        questionsPicker.delegate = self
        questionsPicker.dataSource = self
        questionsPicker.reloadAllComponents()
        // Do any additional setup after loading the view.
    }
    
    func reloadQuestion() {
        questionLabel.text = quiz.questions[quizIndex].question
        questionsPicker.delegate = self
        questionsPicker.dataSource = self
        questionsPicker.reloadAllComponents()
    }
    
    @IBAction func sendAnswer(sender: AnyObject) {
        if (quiz.questions[quizIndex].allAnswers[questionsPicker.selectedRowInComponent(0)] == quiz.questions[quizIndex].correctAnswer)  {
            quiz.numberCorrectAnswers += 1
        }
        print("quizIndex : ", quizIndex)
        print("quiz.questions.count : ", quiz.questions.count)
        if (quizIndex < quiz.questions.count - 1) {
            quizIndex += 1
            self.reloadQuestion()
            /*let questionController = storyboard?.instantiateViewControllerWithIdentifier("QuestionController") as! QuestionController
            questionController.quiz = self.quiz
            questionController.quizIndex = self.quizIndex
            self.navigationController?.pushViewController(questionController, animated: true)*/
            //self.performSegueWithIdentifier("nextQuestion", sender: self)
        } else {
            self.performSegueWithIdentifier("quizOver", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        /*if segue.identifier == "nextQuestion" {
            let destinationVC = segue.destinationViewController as! QuestionController
            destinationVC.quiz = self.quiz
            destinationVC.quizIndex = self.quizIndex + 1
        }*/
        if segue.identifier == "quizOver" {
            let destinationVC = segue.destinationViewController as! ResultsController
            destinationVC.quiz = self.quiz
        }
    }

}
