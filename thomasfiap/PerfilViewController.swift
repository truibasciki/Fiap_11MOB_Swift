//
//  PerfilViewController.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 07/10/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var fotoJogador: UIImageView!
    @IBOutlet weak var txtApelido: UILabel!
    @IBOutlet weak var txtNome: UILabel!
    @IBOutlet weak var txtIdade: UILabel!
    @IBOutlet weak var txtTelefone: UILabel!
    
    @IBOutlet weak var txtLatLong: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        navigationItem.imageNavigation()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addJogador(id: Int32){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://gustavocalixto.pe.hu/index.php/cliente")!)
        request.HTTPMethod = "POST"
        let json = ["id": String(id) ]
        
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            
            
            request.HTTPBody = jsonData
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                                          print("error=\(error)")
                    return
                }
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    let resultado  = json as? [[String: AnyObject]]
                    
                    for lines in resultado!  {
                        if let apelido = lines["apelido"] as? String {
                            self.txtApelido.text = apelido
                        }
                        if let nome = lines["nome"] as? String {
                            self.txtNome.text = nome
                        }
                        if let idade = lines["idade"] as? String {
                            self.txtIdade.text = idade
                        }
                        if let telefone = lines["telefone"] as? String {
                            self.txtTelefone.text = telefone
                        }
                        if let latLong = lines["latLong"] as? String {
                            self.txtApelido.text = latLong
                        }
                        
                    }
                }
                catch {
                    
                }
                
            }
            task.resume()
        }catch{
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
