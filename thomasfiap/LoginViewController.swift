//
//  LoginViewController.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 17/08/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground();
        navigationItem.imageNavigation();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtSenha: UITextField!

    @IBAction func logar(sender: AnyObject) {
        
        self.performSegueWithIdentifier("LoginMapaSegue", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
