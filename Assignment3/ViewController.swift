//
//  ViewController.swift
//  Assignment3
//
//  Created by user235429 on 11/15/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ImageAdditionDelegate {
 

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var imageList = (UIApplication.shared.delegate as! AppDelegate).allImage

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageList[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedImage = imageList[row]

        let imageUrl = selectedImage.url

        downloadImage(from: imageUrl) { imageData in
            if let imageData = imageData {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                    print("Image set in imageView.")
                }
            }
        }
    }


    func downloadImage(from urlString: String, completion: @escaping (Data?) -> Void) {
        guard let imageUrl = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: imageUrl) { data, _, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            print("Image downloaded successfully.")
            completion(data)
        }

        task.resume()
    }
    
    func imageAddCorrectly(newImage: ImageModel) {
        imageList.append(newImage)
        pickerView.reloadAllComponents()
    }
    
    func viewDidCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addImageSegue" {
            if let secondViewController = segue.destination as? SecondViewController {
                secondViewController.delegate = self
            }
        }
    }
}

