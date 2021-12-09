//
//  Task5DViewController.swift
//  HW2.5
//
//  Created by Sergii Kotyk on 13/10/21.
//     d) создайте класс, который последовательно выполняет полученные задачи в фоновом режиме: в него можно добавить задачу (на ваш выбор — либо класс с функцией run(), либо блок () → Void). При добавлении задачи класс проверяет, выполняется ли сейчас другая задача. Если да, он добавляет эту задачу в очередь, если нет — сразу начинает выполнять задачу в фоновом потоке. После выполнения задачи класс проверяет, есть ли другие задачи в очереди. Если есть, то берёт ту, которая была добавлена раньше других, приступает к ней и удаляет её из очереди.

import UIKit

class LongTask{ // Просто класс с рандомной функцией которая долго выполняеться ()
    
    func longTimeFunc(name: String){
        
        print("Start \(name)")
        
        let max = 999999 // << увеличте число если хотите что бы функция выполнялась дольше
        
        var testValue = 2
        let startTime = Date()

        var data = (2...max).map{$0}
        while (testValue.powerOf2() <= max) {
            data.removeAll(where: {$0 >= testValue.powerOf2() && $0.isMultiple(of: testValue)})
            testValue = data.first(where: {$0 > testValue})!
        }
        let overallTime = Date()

        print("\(name) finished after: \(String(format: "%.2f",(overallTime.timeIntervalSince(startTime)))) с. ")
        print()
    }
}

protocol ClassWithRun{ // протокол для удобства
    func run()
}

// 3 класса с функциями ран длительного выполнения
class Task1: ClassWithRun {
    let task = LongTask()
    
    func run(){
        task.longTimeFunc(name: "Run1")
    }
}

class Task2: ClassWithRun {

    let task = LongTask()
    
    func run(){
        task.longTimeFunc(name: "Run2")
    }
}

class Task3: ClassWithRun {
    
    let task = LongTask()
    
    func run(){
        task.longTimeFunc(name: "Run3")
    }
}



class Task5DViewController: UIViewController {
    
    let queue = OperationQueue()

    func addOperationFromClass(classWithRun: ClassWithRun){ // основная функция
//        DispatchQueue.global(qos: .background).async { // фоновый режим
            let blockOperation = BlockOperation{ // создание операции
                classWithRun.run()
            }
            self.queue.addOperation(blockOperation) // внесение в очередь
//        }
    }
    
    // тестовые кнопки
    @IBAction func task1Button(_ sender: Any) {
            self.addOperationFromClass(classWithRun: Task1())
    }
    
    @IBAction func task2Button(_ sender: Any) {
            self.addOperationFromClass(classWithRun: Task2())
    }
    
    @IBAction func task3Button(_ sender: Any) {
            self.addOperationFromClass(classWithRun: Task3())
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.queue.maxConcurrentOperationCount = 1 // настройка очереди. Назначение выполнение одной операции единоразово
        self.queue.qualityOfService = .background

    }
    

}
