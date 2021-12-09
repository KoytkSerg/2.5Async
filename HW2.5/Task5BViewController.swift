//
//  ViewController.swift
//  HW2.5
//
//  Created by Sergii Kotyk on 11/10/21.


//b) загрузку изображения, применение к нему эффекта размытия в фоновом потоке и показ на экране;

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var someImage: UIImageView!
    @IBAction func downloadButton(_ sender: Any) {
        
        DispatchQueue.global(qos: .background).async { // загрузка на фоне
            self.downloadImage(urlString: self.urlString)
            
            DispatchQueue.main.async { // установка картинки
                self.someImage.image = self.image
            }
        }
    }
    
    func downloadImage(urlString: String){ // загрузка картинки
        let url = URL(string: urlString)!
        let data = (try? Data(contentsOf: url))!
        self.image = UIImage(data: data)!
    }
    
    let urlString = "https://blackstarwear.ru/image/cache/catalog/p/8272/9t0a9325-h_1_630x840.jpg"
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.someImage.addBlurEffect() 
        
    }
}


extension UIImageView { // разсширение для блюра ImageView
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}


