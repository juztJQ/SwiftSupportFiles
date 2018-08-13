//
//  KotexViewController.swift
//  Kotex Puma
//
//  Created by Juan Quiroga on 25/08/17.
//  Copyright © 2017 Juan Quiroga. All rights reserved.
//

import Foundation
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import SideMenuController
import SwiftOverlays
import SwiftyJSON
import Alamofire
import AVFoundation


class KotexViewController : UIViewController{
  
    static var periodDate = ""
    static var periodBleedDay = 5
    static var periodDuration = 29
    static var sessionToken = ""
    static var Leveluser = 1
    static var phasetoSee = ""
    static var currentVideo = ""
    static var user : User!
    static var fromProfiler = true
    static var dashboardItems  :  [DashboadardItem] = []
    static var excercisesData : [AllExercise] = []
    static var currentRoutine : Routine!
    static var currentRoutineUp : Routine!
    static var currentRoutineDown : Routine!
    static var currentRoutineStrching : Routine!
    static var currentRoutineWarmUp : Routine!
    static var currentExcercise : Excercise!
    static var productList :  [ProductCategory] = []
    static var productCategory : String!
    static var isStartPeriod = false
    static var isEndPeriod = false
    static var isToday = true
    static var isRotated = false
    static var isRegister = false
    static var isGeneralSound = false
    static var levelRoutine = 0
    static let monthsList = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    static let monthsListShort = ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
    var playerAudio : AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
         SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "menu")
    }
    
     func getDashBoardInfo (){
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        let push_token = InstanceID.instanceID().token() ?? ""
        //dateLabel.text = formatter.string(from: sender.date) KotexViewController.user.id
        _ = SwiftOverlays.showBlockingWaitOverlay()
        ConnectionService.sharedInstance.getDashboardInfo(idUser: KotexViewController.user.id, date: formatter.string(from: date), session_token: KotexViewController.sessionToken, push_token: push_token, onSuccess: { (json) in
            print("Response: \(String(describing: json.rawString()))")
            print(json["statusCode"])
            if(json["statusCode"] == "200" && json["Data"].rawString() != "null"){
                
                //var data = Array<Any>()
                //var data  :  [DashboadardItem] = []
                KotexViewController.dashboardItems = []
                let data = json["Data"].array
                KotexViewController.periodBleedDay = KotexViewController.user.duracionPromedioPeriodo
                KotexViewController.periodDuration = KotexViewController.user.duracionPromedioCiclo
                //print(json["Data"].rawString())
                self.getExcercisesInfo()
                self.getProductsInfo()
                //print(json["Data"].rawString())
                if ( data != nil ){
                    for orderItem in data! {
                        // print (orderItem)
                        // KotexViewController.dashboardItems.append(DashboadardItem(json: orderItem))
                        //KotexViewController.dashboardItems?.append(DashboadardItem(json: orderItem))
                        KotexViewController.dashboardItems.append(DashboadardItem(json: orderItem))
                        //print("---------------------------------")
                        // print(KotexViewController.dashboardItems)
                    }
                    // self.drawData()
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if(KotexViewController.fromProfiler){
                        let viewController = storyboard.instantiateViewController(withIdentifier :"sideMenuDashBoard") as! CustomSideMenuController
                        self.present(viewController, animated: true)
                    }else{
                        let viewController = storyboard.instantiateViewController(withIdentifier :"startProfiler")
                        self.present(viewController, animated: true)
                    }
                }
                else{
                    self.displayAlertMessage(messageToDisplay : "Error de Información \n \(String(describing: json["ErrorMessages"].rawString()))")
                    SwiftOverlays.removeAllBlockingOverlays()
                }
                /*for item in data!{
                 
                 let itemDashboard = DashboadardItem(json: item)
                 print (itemDashboard)
                 KotexViewController.dashboardItems.append(itemDashboard)
                 }*/
                
                
            }
            else{
              self.displayAlertMessage(messageToDisplay : "Error de Información")
               SwiftOverlays.removeAllBlockingOverlays()
            }
            
            
        }) { (error) in
            print("Response Error: \(error)")
            SwiftOverlays.removeAllBlockingOverlays()
        }
        
        
    }
    
    func getExcercisesInfo (){
         _ = SwiftOverlays.showBlockingWaitOverlay()
        
        ConnectionService.sharedInstance.getExcercices(session_token: KotexViewController.sessionToken, onSuccess: { (json) in
            
            if(json["statusCode"] == "200" && json["Data"].rawString() != "null"){
                
                //var data = Array<Any>()
                //var data  :  [DashboadardItem] = []
                
                let data = json["Data"].array
                
                //print(json["Data"].rawString())
              //  print(json["Data"].rawString())
                if ( data != nil ){
                    for orderItem in data! {
                      
                        KotexViewController.excercisesData.append(AllExercise(json: orderItem))
                        //print("---------------------------------")
                        // print(KotexViewController.dashboardItems)
                    }
                    // self.drawData()
                  
                }
                else{
                    self.displayAlertMessage(messageToDisplay : "Error de Información \n \(String(describing: json["ErrorMessages"].rawString()))")
                }
            }
            else{
                self.displayAlertMessage(messageToDisplay : "Error de Información")
            }
            
            SwiftOverlays.removeAllBlockingOverlays()
        }) { (error) in
            print("Response Error: \(error)")
            SwiftOverlays.removeAllBlockingOverlays()
        }
    }
    
    func getProductsInfo(){
        _ = SwiftOverlays.showBlockingWaitOverlay()
        ConnectionService.sharedInstance.getProducts(session_token: KotexViewController.sessionToken, onSuccess: { (json) in
           // print("-----------products data -----------")
            //print(json["Data"].rawValue)
            SwiftOverlays.removeAllBlockingOverlays()
            if(json["statusCode"] == "200" && json["Data"].rawString() != "null"){
                
                //var data = Array<Any>()
                //var data  :  [DashboadardItem] = []
                
                let data = json["Data"].array
                
                //print(json["Data"].rawString())
                //  print(json["Data"].rawString())
                if ( data != nil ){
                    for orderItem in data! {
                        
                        KotexViewController.productList.append(ProductCategory(json: orderItem))
                        //print("---------------------------------")
                        // print(KotexViewController.dashboardItems)
                    }
                    // self.drawData()
                    print(KotexViewController.productList.count)
                    
                }
                else{
                    self.displayAlertMessage(messageToDisplay : "Error de Información \n \(String(describing: json["ErrorMessages"].rawString()))")
                }
                
            }
            else{
                self.displayAlertMessage(messageToDisplay : "Error de Información")
            }
            SwiftOverlays.removeAllBlockingOverlays()
                
            
        }) { (error) in
            print(error)
            SwiftOverlays.removeAllBlockingOverlays()
        }
        
        
    }

    
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func isValidPassword(password: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "^(?=.*[A-Z])(?=.*[0-9]).{6,}$"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = password as NSString
            let results = regex.matches(in: password, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func displayAlertMessage(messageToDisplay: String , title : String = "Ups!")
    {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    public static func checkForUserLogged(){
        let user = KotexViewController.getUserFromPreferences()
        let kc  = KotexViewController()
        if(user != nil){
            _ = SwiftOverlays.showBlockingWaitOverlay()
            KotexViewController.user = user
            if(KotexViewController.user.NivelIntensidad <= 0 || KotexViewController.user.duracionPromedioCiclo <= 0 || KotexViewController.user.duracionPromedioPeriodo <= 0  ){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier :"startProfiler") as! StartProfilerViewController
                kc.present(viewController, animated: true)
            }else{
                kc.getDashBoardInfo()
                
            }
        }
    }
    
    
    
   public func makeAutoLogin( email : String, password : String, is_update_token : Bool = false) {
        print("Make Login")
       /* self.registerAnaliticsEvent(idEvent: "Email", itemName: "Email Login", description: "User loged in by Email option", itemCategory: "Email Login")*/
        let push_token = InstanceID.instanceID().token() ?? ""
        print(push_token)
        print("Usuario: \(email)")
        print("Usuario: \(password)")
        _ = SwiftOverlays.showBlockingWaitOverlay()
        //if push_token != nil {
        ConnectionService.sharedInstance.getLoginUser(username: email, password: password , push_token: push_token, session_token: KotexViewController.sessionToken ,onSuccess: { json in
            // print("Response: \(json.rawString())")
            print("Data from login")
            print(json.rawString())
            KotexViewController.sessionToken = json["access_token"].string!
            if json["statusCode"] == "200" && json["Message"] == "success" {
                print ("--------- user data from server  -----------")
                print("Response: \(json["Data"].rawString())")
                KotexViewController.user = User(json: json["Data"])
                SwiftOverlays.removeAllBlockingOverlays()
                /*  self.fechaUltimoPeriodo =   date
                 self.duracionPromedioCiclo = json["DuracionPromedioCiclo"].int
                 self.duracionPromedioPeriodo = json["DuracionPromedioPeriodo"].int
                 */
                self.getExcercisesInfo ()
                if(!KotexViewController.user.isCompleteProfiler()){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier :"startProfiler") as! StartProfilerViewController
                    self.present(viewController, animated: true)
                }else{
                    
                    self.getDashBoardInfo()
                    
                }
                
                
                
            } else {
                SwiftOverlays.removeAllBlockingOverlays()
                //self.displayAlertMessage(messageToDisplay: "error: \(json["Message"])")
                
            }
        }, onError: { error in
            print("Response: \(error)")
            if !is_update_token {
                SwiftOverlays.removeAllBlockingOverlays()
     
            }
        })
        /*} else {
         FIRMessaging.messaging().connect { (error) in
         if (error != nil) {
         print("Unable to connect with FCM. \(error)")
         self.showTutorialScreen()
         } else {
         print("Connected to FCM. --> <--")
         self.makeLogin(email: email, password: password, dictionaryNotification: dictionaryNotification)
         }
         }
         } */
        
    }
    
    
    
    
    func registerAnaliticsEvent( idEvent : String , itemName : String , description : String , itemCategory : String ){
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: idEvent as NSObject,
            AnalyticsParameterItemName: itemName as NSObject,
            AnalyticsParameterItemCategory : itemCategory as NSObject,
            AnalyticsParameterContentType: description as NSObject
            ])
    }
    
  
    
  
    func getImageFromServer(urlString: String) -> UIImage {
        print("image to load \(urlString)")
        let remoteImageURL = URL(string: urlString)!
        var image : UIImage?
                  // Use Alamofire to download the image
                  Alamofire.request(remoteImageURL).responseData { (response) in
                         if response.error == nil {
                                 print(response.result)
                 
                                 // Show the downloaded image:
                                 if let data = response.data {
                                          //self.downloadImage.image = UIImage(data: data)
                                          image = UIImage(data: data)
                                    
                                    }
                            
                        
                    }
        }
        return image!
    }
    
    static func setImagefromServer(uiImageView: UIImageView , urlString: String){
        let remoteImageURL = URL(string: urlString)!
        var image : UIImage?
        // Use Alamofire to download the image
        Alamofire.request(remoteImageURL).responseData { (response) in
            if response.error == nil {
                print(response.result)
                
                // Show the downloaded image:
                if let data = response.data {
                    //self.downloadImage.image = UIImage(data: data)
                    image = UIImage(data: data)
                    uiImageView.image = image
                    
                }
                
                
            }
        }
    }
    func configureNavigationBarDarkRegister() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = ([
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "TrumpGothicEast", size: 17)!
            ])
        
        self.navigationItem.hidesBackButton = true
        
        let btnRight = UIButton(type: .custom)
        btnRight.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)//(0.0, 40.0, 30.0, 30.0)
        btnRight.setBackgroundImage(UIImage(named: "backBlack")!, for: .normal)
        btnRight.addTarget(self, action: #selector(KotexViewController.backSRegister(sender:)), for: .touchUpInside)
        
        let newBackButton = UIBarButtonItem(customView: btnRight)
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    func configureNavigationBarDark() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.titleTextAttributes = ([
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: "TrumpGothicEast", size: 17)!
            ])
        
        self.navigationItem.hidesBackButton = true
        
        let btnRight = UIButton(type: .custom)
        btnRight.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)//(0.0, 40.0, 30.0, 30.0)
        btnRight.setBackgroundImage(UIImage(named: "backBlack")!, for: .normal)
        btnRight.addTarget(self, action: #selector(KotexViewController.backSchedule(sender:)), for: .touchUpInside)
        
        let newBackButton = UIBarButtonItem(customView: btnRight)
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    func configureNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.titleTextAttributes = ([
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "TrumpGothicEast", size: 16)!
            ])
        
        self.navigationItem.hidesBackButton = true
        
        let btnRight = UIButton(type: .custom)
        btnRight.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)//(0.0, 40.0, 30.0, 30.0)
        btnRight.setBackgroundImage(UIImage(named: "back")!, for: .normal)
        btnRight.addTarget(self, action: #selector(KotexViewController.backSchedule(sender:)), for: .touchUpInside)
        
        let newBackButton = UIBarButtonItem(customView: btnRight)
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    
    func updateToken( email : String, password : String, is_update_token : Bool = false , accestoken : String = "") {
        //  print("Make Login")
        registerAnaliticsEvent(idEvent: "Email", itemName: "Email Login", description: "User loged in by Email option", itemCategory: "Email Login")
        let push_token = InstanceID.instanceID().token() ?? ""
        //print(push_token)
        //print("Usuario: \(email)")
        //print("Usuario: \(password)")
        _ = SwiftOverlays.showBlockingWaitOverlay()
        //if push_token != nil {
        ConnectionService.sharedInstance.getLoginUser(username: email, password: password , push_token: push_token, session_token: KotexViewController.sessionToken ,onSuccess: { json in
            // print("Response: \(json.rawString())")
            print("Data from login")
           
            
            
            if json["statusCode"] == "200" {
                print(json.rawString())
                let tokn = json["access_token"].string!
                print(tokn)
                if(tokn != nil){
                    KotexViewController.sessionToken = tokn
                    
                }
                self.getExcercisesInfo ()
                if(KotexViewController.user.NivelIntensidad <= 0 || KotexViewController.user.duracionPromedioCiclo <= 0 || KotexViewController.user.duracionPromedioPeriodo <= 0  ){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier :"startProfiler") as! StartProfilerViewController
                    self.present(viewController, animated: true)
                }else{
                      self.getDashBoardInfo()
                    
                }
                
                
                
            } else {
                SwiftOverlays.removeAllBlockingOverlays()
               
            }
        }, onError: { error in
            print("Response: \(error)")
            if !is_update_token {
                SwiftOverlays.removeAllBlockingOverlays()
              
            }
        })
       
        
    }
    
    func updateTokenSocialNetwork( provider : String, accestoken : String, is_update_token : Bool = false ) {
        //  print("Make Login")
      //  registerAnaliticsEvent(idEvent: "Email", itemName: "Email Login", description: "User loged in by Email option", itemCategory: "Email Login")
        let push_token = InstanceID.instanceID().token() ?? ""
        //print(push_token)
        //print("Usuario: \(email)")
        //print("Usuario: \(password)")
        _ = SwiftOverlays.showBlockingWaitOverlay()
        //if push_token != nil {
        
        ConnectionService.sharedInstance.getTokenSocialNetwork(provider: provider, access_token: accestoken, onSuccess: { (json) in
           // print(accestoken)
           // print("---------Data from login token social")
           // print(json.rawString())
            
            
            if json["statusCode"] == "200" {
                
                let tokn = json["access_token"].string!
                print(tokn)
                if(tokn != nil){
                    KotexViewController.sessionToken = tokn
                }
                ConnectionService.sharedInstance.getUserData(session_token: tokn, onSuccess: { (jsonD) in
                    KotexViewController.user = User(json: jsonD["Data"])
                    KotexViewController.storeUserInPreferences()
                    self.getExcercisesInfo ()
                    if(KotexViewController.user.NivelIntensidad <= 0 || KotexViewController.user.duracionPromedioCiclo <= 0 || KotexViewController.user.duracionPromedioPeriodo <= 0  ){
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier :"startProfiler") as! StartProfilerViewController
                        self.present(viewController, animated: true)
                    }else{
                        self.getDashBoardInfo()
                        SwiftOverlays.removeAllBlockingOverlays()
                        
                    }
                }, onError: { (error) in
                    SwiftOverlays.removeAllBlockingOverlays()
                })
                
                
                
                
                
            } else {
                SwiftOverlays.removeAllBlockingOverlays()
                
            }
        }) { (error) in
            print("Response: \(error)")
            if !is_update_token {
                SwiftOverlays.removeAllBlockingOverlays()
                
            }

        }
        
        func getUserData(){
            
        }
        
    }
    
    func shareContent(text : String){
       
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func playSound (sound : String , numberOfLoops : Int){
        print(sound)
        let path = Bundle.main.path(forResource: sound, ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            self.playerAudio = sound
            sound.numberOfLoops = numberOfLoops
            sound.prepareToPlay()
            sound.play()
        } catch {
            print("error loading file")
            // couldn't load file :(
        }
    }
    
    
    func backSchedule(sender: UIBarButtonItem) {
        //print("\(prevIndex)")
        print("show back shcedule")
        sideMenuController?.performSegue(withIdentifier: "showCenterController1", sender: nil)
        
        
    }
    func backSRegister(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    // MARK SideMenuController
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            dismiss(animated: true, completion: {
                if self.presentedViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    public static func storeUserInPreferences(){
        storeUserInPreferences(user: KotexViewController.user)
    }
    
    public static func storeUserInPreferences(user:User){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(encodedData, forKey: "userObject")
    }
    
    public static func getUserFromPreferences()->User?{
        let data = UserDefaults.standard.data(forKey: "userObject")
        if(data != nil){
            let user = NSKeyedUnarchiver.unarchiveObject(with: data!) as? User
            return user
        }
        else{
            return nil
        }
    }
    
    public static func removeUserFromPreferences(){
        UserDefaults.standard.removeObject(forKey: "userObject")
    }

    
    
}
