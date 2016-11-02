//
//  DetailViewController.swift
//  MineNoter
//
//  Created by Mads Peter Emborg on 29/10/2016.
//  Copyright © 2016 Mads Peter Emborg. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

  //  @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var headingText: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
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


}

