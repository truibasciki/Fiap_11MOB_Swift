//
//  CadastroViewController.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 17/08/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var segmentedJogQua: UISegmentedControl!
    
    @IBOutlet weak var NomePlayer: UILabel!
    @IBOutlet weak var labelTelefone: UILabel!
    
    @IBOutlet weak var labelLatitude: UILabel!
    @IBOutlet weak var labelLongitude: UILabel!
    
    
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground();
        
        labelLatitude.hidden = true
        labelLongitude.hidden = true
        txtLatitude.hidden = true
        txtLongitude.hidden = true
        
navigationItem.imageNavigation();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    
    @IBAction func trocaPerfil(sender: AnyObject) {
        
        if(segmentedJogQua.selectedSegmentIndex == 0) {
            
            NomePlayer.text = "Nome de Boleiro"
            labelLatitude.hidden = true
            labelLongitude.hidden = true
            txtLatitude.hidden = true
            txtLongitude.hidden = true
            
        } else {
            
            NomePlayer.text = "Nome da Quadra"
            labelLatitude.hidden = false
            labelLongitude.hidden = false
            txtLatitude.hidden = false
            txtLongitude.hidden = false
        }
        
    }

    @IBAction func logarFb(sender: AnyObject) {
    }
    @IBAction func cadastrar(sender: AnyObject) {
        
        if(segmentedJogQua.selectedSegmentIndex == 0) {
            
            
        } else {
            
            
            
        }
        
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
