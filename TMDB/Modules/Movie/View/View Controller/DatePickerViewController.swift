//
//  DatePickerViewController.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/6/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import UIKit

protocol DatePickerDelegate:class {
    func selectedYear(_ year:Int)
}


class DatePickerViewController: UIViewController,StoryboardInitializable {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate :DatePickerDelegate?
    
    var selectedYear = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func getDatePickerSelectedValue(_ sender: UIDatePicker) {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: datePicker.date)

        self.selectedYear = year
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.selectedYear(selectedYear)
    }
}


