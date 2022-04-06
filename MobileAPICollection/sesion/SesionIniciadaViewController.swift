//
//  SesionIniciadaViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 31/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

//*************** creacion de estructura con enum *************
enum ProviderType:String {
    case basic
    case google
}
class SesionIniciadaViewController: UIViewController {
    //******************* @IBOutlet text *********************
    
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtFechaNacimiento: UITextField!
    
    //******************* @IBOutlet *********************
    @IBOutlet weak var btnCerrarSesion: UIButton!
    @IBOutlet weak var lblProveedor: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    //******************* constantes *******************
    private let email: String
    private let provider:ProviderType
    
//******************** constante para base de datos con farebase *******************
    private let db = Firestore.firestore()
    
    
    //****************** inicializacion constantes
    init(email:String, provider: ProviderType) {
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //***************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iniciar sesion"
        lblEmail.text = email
        lblProveedor.text = provider.rawValue
        
//*********************** codigo para que no aparesca el boton de regresar
        navigationItem.setHidesBackButton(true, animated: false)
        
//************ acceso a propiedades de la instancia **********************
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
        
    }

    @IBAction func btnActionCerrarSesion(_ sender: Any) {
        
        //************* borrado de datos al cerrar sesion ******************
                //*********** instanciacion de variable *****************
                let defaults = UserDefaults.standard
                //************ acceso a propiedades de la instancia *****************
                defaults.removeObject(forKey: "email")
                defaults.removeObject(forKey: "provider")
                defaults.synchronize()
        
        switch provider {
        case .basic, .google:
            do {
                try Auth.auth().signOut()
                navigationController?.popViewController(animated: true)
            } catch {
                
            }
        }
    }
    
    @IBAction func btnActionGuardar(_ sender: Any) {
        view.endEditing(true)
        
//******************************** ingresar datos a la base de datos de firebase ***********************
        db.collection("user").document(email).setData([
            "provider":provider.rawValue,
            "usuario":txtUsuario.text ?? "",
            "nombre":txtNombre.text ?? "",
            "fechaNacimiento":txtFechaNacimiento.text ?? "",
            "direccion":txtDireccion.text ?? ""])
        
        let alertaController = UIAlertController(title: "Guardado", message: "Datos guardados" , preferredStyle: .alert)
            alertaController.addAction(UIAlertAction(title: "aceptar", style: .default))
            self.present(alertaController, animated: true, completion: nil)
//******************************************************************************************************
    }
    @IBAction func btnActionRecuperar(_ sender: Any) {
        view.endEditing(true)
        db.collection("user").document(email).getDocument{
            (documentSnapshot, error) in
            
            if let document = documentSnapshot, error == nil {
                if let usuario = document.get("usuario") as? String {
                    self.txtUsuario.text = usuario
                }else {self.txtUsuario.text = "" }
                
                if let nombre = document.get("nombre") as? String {
                    self.txtNombre.text = nombre
                }else {
                    self.txtNombre.text = ""
                }
                
                if let fechaNacimiento = document.get("fechaNacimiento") as? String {
                    self.txtFechaNacimiento.text = fechaNacimiento
                }
                else {
                    self.txtFechaNacimiento.text = ""
                }
                if let direccion = document.get("direccion") as? String {
                    self.txtDireccion.text = direccion
                }
                else{
                    self.txtDireccion.text = ""
                }
            }else {
                self.txtUsuario.text = ""

                self.txtNombre.text = ""

                self.txtFechaNacimiento.text = ""

                self.txtDireccion.text = ""
            }
        }
    }
    @IBAction func btnActionEliminar(_ sender: Any) {
        view.endEditing(true)
        
        db.collection("user").document(email).delete()
    }
    
    
    @IBAction func btnHome(_ sender: Any) {
        navigationController?.pushViewController(ViewController(), animated: true)
        //present(ViewController(), animated: true)
        
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
