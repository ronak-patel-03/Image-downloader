//
//  SecondViewController.swift
//  Assignment3
//
//  Created by user235429 on 11/15/23.
//
import UIKit

protocol ImageAdditionDelegate: AnyObject {
    func imageAddCorrectly(newImage : ImageModel)
    func viewDidCancel()
}

class SecondViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    weak var delegate: ImageAdditionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, let url = urlTextField.text else {
            print("Title or URL is empty.")
            return
        }

        let newImage = ImageModel(title: title, url: url)
        delegate!.imageAddCorrectly(newImage: newImage)

        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        delegate!.viewDidCancel()
        dismiss(animated: true, completion: nil)
    }
    
   
}
