//
//  ListaViewController.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 29/08/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit

class ListaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segmentedTipo: UISegmentedControl!
    @IBOutlet weak var tableLista: UITableView!
    
    let listaJogador:[String] = ["José", "Fracasso"]
    let listaQuadra:[String] = ["Quadra Boleiros", "Quadra Fracasso"]
    
    
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var returnValue = 0
        if(segmentedTipo.selectedSegmentIndex == 0){
            returnValue = listaJogador.count
        }else{
            returnValue = listaQuadra.count
        }
        
        
        return returnValue
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let myCell = tableView.dequeueReusableCellWithIdentifier("cellList", forIndexPath: indexPath)
        if(segmentedTipo.selectedSegmentIndex == 0){
            myCell.textLabel?.text = listaJogador[indexPath.row]
        }else{
            myCell.textLabel?.text = listaQuadra[indexPath.row]
        }
        
        
        return myCell
    }
    
    @IBAction func mudarLista(sender: AnyObject) {
        tableLista.reloadData()
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
