//
//  ResultsController.swift
//  TP2
//
//  Created by Sevigny on 2017-12-17.
//  Copyright © 2017 Sevigny. All rights reserved.
//

import UIKit

class ResultsController: UIViewController {
    
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var quiz : Quiz = Quiz(questions: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        correctLabel.text = String(quiz.numberCorrectAnswers)
        totalLabel.text = String(quiz.questions.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
