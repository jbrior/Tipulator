//
//  ViewController.swift
//  Tipulator
//
//  Created by Jesse Brior on 5/28/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var splitTipBtn: UIButton!
    
    var percentAmount : Int = 0
    var totalWithTip : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        billAmount.layer.borderWidth = 3
        billAmount.layer.borderColor = #colorLiteral(red: 0.7058823529, green: 0.3882352941, blue: 0, alpha: 1).cgColor
        billAmount.layer.cornerRadius = 10
        
        resultLabel.text = "Tip: $0.00\nTotal: $0.00"
        
        resetBtn.layer.cornerRadius = 15
        
        tipLabel.text = "\(percentAmount)%"
        tipLabel.layer.masksToBounds = true
        tipLabel.layer.cornerRadius = 50
        tipLabel.layer.borderWidth = 4
        tipLabel.layer.borderColor = #colorLiteral(red: 0.7058823529, green: 0.3882352941, blue: 0, alpha: 1).cgColor
        
        splitTipBtn.isEnabled = false
        splitTipBtn.layer.masksToBounds = true
        splitTipBtn.layer.cornerRadius = 10
    }
    
    @IBAction func getSelectedTip(_ sender: UISlider) {
        percentAmount = Int(round(sender.value))
        tipLabel.text = "\(Int(round(sender.value)))%"
        
        view.resignFirstResponder()
        billAmount.endEditing(true)
        
        if !(billAmount.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            updateLabel(price: Double(billAmount.text!.trimmingCharacters(in: .whitespaces))!, percent: percentAmount)
            resetBtn.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.resignFirstResponder()
        billAmount.endEditing(true)
    }
    
    @IBAction func ifTypingStarts(_ sender: Any) {
        if billAmount.text != "" {
            updateLabel(price: Double(billAmount.text!.trimmingCharacters(in: .whitespaces))!, percent: percentAmount)
            resetBtn.isHidden = false
            splitTipBtn.isEnabled = true
        } else {
            resultLabel.text = "Tip: $0.00\nTotal: $0.00"
            resetBtn.isHidden = true
            splitTipBtn.isEnabled = false
        }
    }
    
    func updateLabel(price: Double, percent: Int) {
        let p = Double(percent) / 100.0
        let tipAmount = roundPrice(x: price * p)
        let newTotal = roundPrice(x: price + tipAmount)
        totalWithTip = newTotal
        
        resultLabel.text = String("Tip: $\(tipAmount)\nTotal: $\(newTotal)")
    }
    
    @IBAction func resetCalc(_ sender: Any) {
        billAmount.text = ""
        resultLabel.text = "Tip: $0.00\nTotal: $0.00"
        resetBtn.isHidden = true
        splitTipBtn.isEnabled = false
    }
    
    func roundPrice(x: Double) -> Double {
        return round(100.0 * x) / 100.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSplitSegue" {
            let vc = segue.destination as? SplitBillViewController
            vc?.totalWithTip = totalWithTip
        }
    }
}
