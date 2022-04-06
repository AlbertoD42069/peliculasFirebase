//
//  IniciarSesionViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 05/04/22.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var stkvContenedor: UIStackView!
    @IBOutlet weak var btnRegistrar: UIButton!
    @IBOutlet weak var btnAcceder: UIButton!
    @IBOutlet weak var txtContraseña: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAccionAcceder(_ sender: Any) {
        if let email = txtEmail.text, let Contraseña = txtContraseña.text {
            Auth.auth().signIn(withEmail: email, password: Contraseña) { result, error in
                if let result = result, error == nil {
                    self.navigationController?.pushViewController(SesionIniciadaViewController(email: result.user.email!, provider: .basic), animated: true)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Se a producido un error registrando el usario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                }
            }
        }
    }
    
    @IBAction func btnAccionRegistrar(_ sender: Any) {
        
        let userData = UserData.shared
        
        if  let email = txtEmail.text, let Contraseña = txtContraseña.text {
            Auth.auth().createUser(withEmail: email, password: Contraseña) { result, error in
                
                if let result = result, error == nil {
                    userData.userId = result.user.uid
                    self.navigationController?.pushViewController(SesionIniciadaViewController(email: result.user.email!, provider: .basic), animated: true)
                }else{
                    
                    let alertController = UIAlertController(title: "Error", message: "Se a producido un error registrando el usario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
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
