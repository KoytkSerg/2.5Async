//
//  Task5CViewController.swift
//  HW2.5
//
//  Created by Sergii Kotyk on 13/10/21.


//c) одно текстовое поле с вводом числа и кнопкой «Рассчитать». После нажатия на кнопку приложение должно в фоновом режиме найти все простые числа (которые делятся без остатка только на 1 и себя) от единицы до введённого числа. Все найденные числа нужно вывести в консоль вместе с длительностью расчёта этих чисел (длительность — сколько времени ушло на поиск этих чисел);

import UIKit

class Task5CViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    
    @IBAction func findButton(_ sender: Any) {
        
        guard let max = Int(numberTextField.text!) else { return }
        DispatchQueue.global(qos: .background).async{
            
            var testValue = 2

            let startTime = Date()

            var data = (2...max).map{$0}
            while (testValue.powerOf2() <= max) {
                data.removeAll(where: {$0 >= testValue.powerOf2() && $0.isMultiple(of: testValue)})
                testValue = data.first(where: {$0 > testValue})!
            }
            let overallTime = Date()

            print()
            print("Всего \(data.count) простых чисел: ", data)
            print()
            print("Всего: \(String(format: "%.2f",(overallTime.timeIntervalSince(startTime)))) с. ")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.numberTextField.delegate = self
        
    }
    

}

extension Task5CViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == numberTextField {
            let allowedCharacters = CharacterSet(charactersIn:"123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

extension Int {
    func powerOf2() -> Int {
        return self * self
    }
}
