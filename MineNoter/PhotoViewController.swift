//
//  PhotoViewController.swift
//  MineNoter
//
//  Created by Mads Peter Emborg on 31/10/2016.
//  Copyright © 2016 Mads Peter Emborg. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var myPhotoText: UITextView!
    @IBOutlet weak var myPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPhoto))
        let undoButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(showPhoto))
        self.navigationItem.setRightBarButtonItems([undoButton, cancelButton], animated: true)
            
        showPhoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        switch didPhoto {
        case 1:
            emner[currentIndex].photoText1 = self.myPhotoText.text!
            if (self.myPhoto.image == nil) {
                emner[currentIndex].photo1 = NSData()
            }
        case 2:
            emner[currentIndex].photoText2 = self.myPhotoText.text!
            if (self.myPhoto.image == nil) {
                emner[currentIndex].photo2 = NSData()
            }
        case 3:
            emner[currentIndex].photoText3 = self.myPhotoText.text!
            if (self.myPhoto.image == nil) {
                emner[currentIndex].photo3 = NSData()
            }
        default:
            return
        }
    }
    
    func showPhoto() {
        switch didPhoto {
        case 1:
            if let pic = self.myPhoto {
                pic.image = UIImage(data: emner[currentIndex].photo1 as Data)
            }
            if let label1 = self.myPhotoText {
                label1.text = emner[currentIndex].photoText1
            }
        case 2:
            if let pic = self.myPhoto {
                pic.image = UIImage(data: emner[currentIndex].photo2 as Data)
            }
            if let label1 = self.myPhotoText {
                label1.text = emner[currentIndex].photoText2
            }

        case 3:
            if let pic = self.myPhoto {
                pic.image = UIImage(data: emner[currentIndex].photo3 as Data)
            }
            if let label1 = self.myPhotoText {
                label1.text = emner[currentIndex].photoText3
            }
        default:
            return
        }
    }
    
    func cancelPhoto() {
        self.myPhotoText.text = ""
        self.myPhoto.image = nil
    }
    
    
}
