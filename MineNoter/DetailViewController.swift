//
//  DetailViewController.swift
//  MineNoter
//
//  Created by Mads Peter Emborg on 29/10/2016.
//  Copyright © 2016 Mads Peter Emborg. All rights reserved.
//

import UIKit

var didPhoto: Int = 0

class DetailViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let picker = UIImagePickerController()
  //  @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var headingText: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
    @IBAction func photoButton1(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            present(picker, animated: true, completion: nil)
            didPhoto = 1
        }
    }
    @IBAction func photoButton2(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            present(picker, animated: true, completion: nil)
            didPhoto = 2
        }

    }
    @IBAction func photoButton3(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            present(picker, animated: true, completion: nil)
            didPhoto = 3
        }

    }
    
    @IBOutlet weak var myImage1: UIImageView!
    @IBOutlet weak var myImage2: UIImageView!
    @IBOutlet weak var myImage3: UIImageView!
    
    @IBOutlet weak var photoText1: UILabel!
    @IBOutlet weak var photoText2: UILabel!    
    @IBOutlet weak var photoText3: UILabel!
    
    
    
    func configureView() {
        // Update the user interface for the detail item.
//        if let detail = self.detailItem {
//            if let label = self.detailDescriptionLabel {
//                label.text = detail.description
//            }
//        }
        if let label = self.timeStampLabel {
            label.text = emner[currentIndex].timeStamp.description
        }
        if let label = self.headingText {
            label.text = emner[currentIndex].heading
        }
        if let label = self.noteText {
            label.text = emner[currentIndex].noteText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    override func viewWillDisappear( _ animated: Bool) {
        super.viewWillDisappear(animated)
        
        emner[currentIndex].heading = self.headingText.text!
        emner[currentIndex].noteText = self.noteText.text!
        returnFromDetail = 1;
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            switch didPhoto {
            case 1:
                let picture: Data = UIImageJPEGRepresentation(pickedImage, 0.8)!
                emner[currentIndex].photo1 = picture as NSData
            case 2:
                let picture: Data = UIImageJPEGRepresentation(pickedImage, 0.8)!
                emner[currentIndex].photo2 = picture as NSData
            case 3:
                let picture: Data = UIImageJPEGRepresentation(pickedImage, 0.8)!
                emner[currentIndex].photo3 = picture as NSData
            default:
                return
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let pic1 = self.myImage1 {
            pic1.image = UIImage(data: emner[currentIndex].photo1 as Data)
        }
        if let pic2 = self.myImage2 {
            pic2.image = UIImage(data: emner[currentIndex].photo2 as Data)
        }
        if let pic3 = self.myImage3 {
            pic3.image = UIImage(data: emner[currentIndex].photo3 as Data)
        }
        
        if let label1 = self.photoText1 {
            label1.text = emner[currentIndex].photoText1
        }
        if let label1 = self.photoText2 {
            label1.text = emner[currentIndex].photoText2
        }
        if let label1 = self.photoText3 {
            label1.text = emner[currentIndex].photoText3
        }

    }

}

