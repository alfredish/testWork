//
//  sECONDViewController.swift
//  testWork
//
//  Created by кирилл корнющенков on 02/10/2019.
//  Copyright © 2019 кирилл корнющенков. All rights reserved.
//

import UIKit

class sECONDViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    var titleText:String? = ""
    var contentText:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = titleText
        contentTextView.text = contentText
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
