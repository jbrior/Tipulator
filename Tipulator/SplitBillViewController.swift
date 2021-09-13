//
//  SplitBillViewController.swift
//  Tipulator
//
//  Created by Jesse Brior on 6/12/21.
//

import UIKit

class SplitBillViewController: UIViewController {
    @IBOutlet weak var stepperLbl: UILabel!
    @IBOutlet weak var numberOfPeopleSlider: UISlider!
    @IBOutlet weak var splitTotal: UILabel!
    @IBOutlet weak var billTotalLabel: UILabel!
    
    var totalWithTip = Double()
    var numOfPeople : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        billTotalLabel.text = "$\(totalWithTip)"
        
        stepperLbl.layer.masksToBounds = true
        stepperLbl.layer.cornerRadius = 50
        stepperLbl.layer.borderWidth = 4
        stepperLbl.layer.borderColor = #colorLiteral(red: 0.7058823529, green: 0.3882352941, blue: 0, alpha: 1).cgColor
        
        splitTotal.text = "Total per person:\n$\(totalWithTip)"
    }
    
    @IBAction func sliderActive(_ sender: UISlider) {
        numOfPeople = Int(round(sender.value))
        stepperLbl.text = "\(numOfPeople)"
        
        splitTotal.text = "Total per person:\n$\(roundPrice(x: totalWithTip / Double(numOfPeople)))"
    }
    
    func calculateNewTotal(x: Int) -> String {
        
        return ""
    }
    
    func roundPrice(x: Double) -> Double {
        return round(100.0 * x) / 100.0
    }
}
