//
//  TaskAViewController.swift
//  HW2.5
//
//  Created by Sergii Kotyk on 28/10/21.


//a) загрузку изображения в фоновом потоке и показ его на экране;

import UIKit

class TaskAViewController: UIViewController {

    @IBOutlet weak var someImage: UIImageView!
    
    let urlString = "https://blackstarwear.ru/image/cache/catalog/p/8272/9t0a9325-h_1_630x840.jpg"
    var image = UIImage()
    
    func downloadImage(urlString: String){ // загрузка картинки
        let url = URL(string: urlString)!
        let data = (try? Data(contentsOf: url))!
        self.image = UIImage(data: data)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async { // загрузка на фоне
            self.downloadImage(urlString: self.urlString)
            
            DispatchQueue.main.async { // установка картинки
                self.someImage.image = self.image
            }
        }

      
    }
    


}
