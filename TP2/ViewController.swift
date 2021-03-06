//
//  ViewController.swift
//  TP2
//
//  Created by Sevigny on 2017-12-16.
//  Copyright © 2017 Sevigny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var categoriesPicker: UIPickerView!
    @IBOutlet weak var difficultiesPicker: UIPickerView!
    @IBOutlet weak var numberOfQuestions: UITextField!
    
    let dataController : DataController = DataController()
    var pickerCategories : [String] = []
    var difficulties : [String] = ["any", "easy", "medium", "hard"]
    var categories : [Category] = []
    var quiz : Quiz = Quiz(questions: [])
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == categoriesPicker) {
            return categories.count
        }
        if (pickerView == difficultiesPicker) {
            return difficulties.count
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == categoriesPicker) {
            return categories[row].name
        }
        if (pickerView == difficultiesPicker) {
            return difficulties[row]
        }
        return "error"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.difficultiesPicker.delegate = self
        self.difficultiesPicker.dataSource = self
        self.difficultiesPicker.reloadAllComponents()
        dataController.getTriviaCatagories({ isSuccess, categories in
            self.categories = categories
            print("categories final : ", self.categories.count)
            
            
            dispatch_async(dispatch_get_main_queue()) {
                //self.categoriesPicker.dataSource = self.categories
                self.categoriesPicker.delegate = self
                self.categoriesPicker.dataSource = self
                self.categoriesPicker.reloadAllComponents()
            }
            return []
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startQuiz(sender: AnyObject) {
        if (numberOfQuestions.text != "") {
            //self.performSegueWithIdentifier("quizLoading", sender: self)
            dataController.createQuiz(categories[categoriesPicker.selectedRowInComponent(0)].id, numberOfQuestions: Int(numberOfQuestions.text!)!, difficulty: difficulties[difficultiesPicker.selectedRowInComponent(0)])  { (isSuccess, quiz) in
                self.quiz = quiz
                print("quiz created : ", quiz)
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("quizStart", sender: self)
                }
                return []
            }
        } else {
            showToast("Enter a number of questions!")
        }
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        toastLabel.textColor = UIColor.whiteColor()
        toastLabel.textAlignment = NSTextAlignment.Center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animateWithDuration(4.0, animations: {
            toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
        })
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "quizStart" {
            let destinationVC = segue.destinationViewController as! QuestionController
            destinationVC.quiz = self.quiz
            destinationVC.quizIndex = 0
        }
    }

}

