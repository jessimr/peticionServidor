//
//  ViewController.swift
//  PeticionServidor
//
//  Created by JESSICA MENDOZA RUIZ on 09/03/2017.
//  Copyright © 2017 JESSICA MENDOZA RUIZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.returnKeyType = UIReturnKeyType.search
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sincrono (texto: String){
        //Dir servidor
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(texto)"
        //Convertir la dir en URL
        let url = NSURL(string: urls)
        //Peticion al servidor, esperar respuesta y asociarla a la variable data
        let datos:NSData? = NSData(contentsOf: url! as URL)
        
        if (datos != nil){
            //Pasar los datos obtenidos en UTF8 a String
            let texto = NSString(data: datos! as Data, encoding: String.Encoding.utf8.rawValue)
            //Mostrar datos por pantalla
            print(texto!)
            //Mostrar datos en textView
            textView.textColor = UIColor.black
            textView.text = texto as String!
        }else{ //Si no hay datos (fallo en la conexión a Internet)
            //Mostrar mensaje de error
            textView.textColor = UIColor.red
            textView.text = "Error: No hay conexión a Internet"
            
        }
        
    }
    
    
    //Esconder teclado cuando se pulsa fuera (no funciona con el scroll)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Acciones al pulsar buscar (Esconder teclado cuando se da a intro y buscar libro)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        let texto = textField.text
        sincrono(texto: texto!)
        return true
        
    }


}

