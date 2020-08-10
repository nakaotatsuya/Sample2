//
//  ViewController.swift
//  Sample2
//
//  Created by 中尾　達也 on 2020/08/10.
//  Copyright © 2020 Sample Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var outLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    //var i = 2
    var strList = ["banana", "orange", "melon", "apple"]
    
    var pickerSelected = -1
    
    @IBAction func btnAct(_ sender: Any) {
//        strList.append("Apple")
//        i += 1
//        pickerView.reloadAllComponents()
        UserDefaults.standard.set(strList, forKey: "ListPass")
    }
    
    @IBAction func deleteAct(_ sender: Any) {
        if pickerSelected != -1{
            strList.remove(at: pickerSelected)
            UserDefaults.standard.set(strList, forKey: "ListPass")
            pickerSelected = -1
            pickerView.reloadAllComponents()
        }
    }
    
    @IBAction func sortAct(_ sender: Any) {
        strList = strList.sorted()
        UserDefaults.standard.set(strList, forKey: "ListPass")
        pickerView.reloadAllComponents()
    }
    
    @IBAction func outAct(_ sender: Any) {
        outLabel.text = strList.joined(separator: ",")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if (UserDefaults.standard.array(forKey: "ListPass") != nil){
            strList = UserDefaults.standard.array(forKey: "ListPass") as! [String]
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        
        inputField.delegate = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return strList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return strList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerSelected = row
        outLabel.text = strList[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let ans = strList.filter{$0 == textField.text!}
        
        if ans == []{
            strList.append(textField.text!)
            pickerView.reloadAllComponents()
            textField.text! = ""
            statusLabel.text = "the word was added"
        } else {
            statusLabel.text = "already exists"
        }
//        textField.resignFirstResponder()
//        strList.append(textField.text!)
//        pickerView.reloadAllComponents()
//        textField.text! = ""
        return true
    }

}

