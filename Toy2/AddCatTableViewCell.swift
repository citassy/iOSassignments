//
//  AddCatTableViewCell.swift
//  Toy2
//
//  Created by Mai Phuong Vu on 12/8/18.
//  Copyright © 2018 Citassy. All rights reserved.
//

import UIKit

var age : Int = -1
var name : String = ""
var type : String = ""
class AddCatTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {

    var addCatViewController : AddCatViewController?
    
    @IBOutlet weak var TextView: UITextView!
    
    
    @IBOutlet weak var PickerView: UIPickerView!
    
    func canSubmit() -> Bool{
        return age != -1 && name != "" && type != ""
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        PickerView.delegate = self
        PickerView.dataSource = self
        TextView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Picker View Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        age = row
        //reload the second section in table view
        addCatViewController?.TableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        if (canSubmit()){
            addCatViewController?.DoneButton.isEnabled = true
        }
        else{
            addCatViewController?.DoneButton.isEnabled = false
        }
        //addCatViewController?.TableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
    }
    
    //MARK: - Text View Methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.textColor == UIColor.gray){
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if(textView.tag == 0){
            name = textView.text
        }
        else{
            type = textView.text
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text == ""){
            if(TextView.tag == 0){
                textView.text = "Name"
            }
            else{
                textView.text = "Type"
            }
            textView.textColor = UIColor.gray
        }
    }
}
