``` swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!\
    
    private let pickerView: UIPickerView = UIPickerView()
    
    private let data: [String] = ["hoge", "fuga"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let pickerToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 35))
        
        pickerToolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerSelectedHandler)),
        ], animated: true)
        
        nameField.inputView = pickerView
        nameField.inputAccessoryView = pickerToolbar
    }
    
    @objc func layoutPickerSelectedHandler() {
        nameField.endEditing(true)
        nameField.text = data[pickerView.selectedRow(inComponent: 0)]
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}

```
