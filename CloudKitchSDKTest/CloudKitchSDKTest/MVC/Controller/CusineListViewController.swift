//
//  CusineListViewController.swift
//  CloudKitchTestFrameWork
//
//  Created by Codetreasure on 07/10/20.
//

import UIKit

public class CusineListViewController: UIViewController {

    @IBOutlet private var table : UITableView!
    
    private var cuisineListArr = [Cuisine]()

    private var refreshControl = UIRefreshControl()
    
    private var userID:String!
    private var cusineCategoryID:String!
    private var token:String!
    
    public init(userID:String,cusineCategoryID:String,token:String) {
        super.init(nibName: "CusineListViewController", bundle: Bundle(for: CusineListViewController.self))
        self.userID = userID
        self.cusineCategoryID = cusineCategoryID
        self.token = token
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("User ID Passed this :\(self.userID ?? "User Id not passed")")
        
        //Register Cell
        self.table.register(UINib(nibName: "CusineListTableViewCell", bundle: Bundle(for: CusineListTableViewCell.self)), forCellReuseIdentifier: "CusineListTableViewCell")
        
        //Table View Refresh control
        table.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(self.clientServerCommunication), for: .valueChanged)
        self.clientServerCommunication()
        
        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.layoutActivity()
    }
    
    @objc func clientServerCommunication()
    {
        if self.refreshControl.isRefreshing == false
        {
            self.startLoading()
        }
        
        let post = "userid=\(userID ?? "")&cusineCategoryID=\(cusineCategoryID ?? "")&token=\(token ?? "")"
        let urlstring = "http://52.66.213.167/cloudkitch/api/api/getcuisines"
        
        let postData: Data? = post.data(using: .ascii, allowLossyConversion: true)
        let postLength = "\(UInt(post.count))"
        
        let url = URL(string: urlstring)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async(execute:
                {() -> Void in
                    guard let data = data, error == nil else
                    {
                        CustomError.show(text: error?.localizedDescription ?? "Network Error", color: .red)
                                 
                        return
                    }
                    do
                    {
                        //
                        //  let str = String(decoding: data, as: UTF8.self)
                        //   print(str)
                        
                        if let httpResponse = response as? HTTPURLResponse
                        {
                            if httpResponse.statusCode == 200
                            {
                                let re = try JSONDecoder().decode(CuisineListResponse.self, from: data)
                                
                                if re.status == true
                                {
                                    self.cuisineListArr = re.data ?? [Cuisine]()
                                    
                                    
                                    if self.cuisineListArr.count == 0
                                    {
                                        CustomError.show(text: "No data found", color: .red)
                                    }
                                }
                                
                                
                                self.table.reloadData()
                                
                            }
                            else
                            {
                                //handle other status code
                                CustomError.show(text: "Please try again", color: .red)
                                
                            }
                        }
                        
                        
                    }
                    catch  _ as NSError
                    {
                        CustomError.show(text: "Please try again", color: .red)
                    }
                    
                    self.stopLoading()
                    self.refreshControl.endRefreshing()
            })
        }
        task.resume()
    }

    @IBAction private func closeSelf(_ sender:Any)
    {
        DispatchQueue.main.async(execute: {() -> Void in
            self.dismiss(animated: true, completion: nil)
        })
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

//MARK: - UITableViewDataSource, UITableViewDelegate
extension CusineListViewController: UITableViewDataSource, UITableViewDelegate
{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.cuisineListArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //set Data in cell
        
        let cuisine = self.cuisineListArr[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CusineListTableViewCell", for: indexPath) as! CusineListTableViewCell
        
        cell.conFigureCuisineTableVCell(data: cuisine)
    
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
  
}

extension UIViewController {

    static let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
   
    
    func startLoading() {
        let activityIndicator = UIViewController.activityIndicator


        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        DispatchQueue.main.async {
            self.view.addSubview(activityIndicator)
        }
        activityIndicator.startAnimating()
        
        let loader = UIViewController.activityIndicator
        
        DispatchQueue.main.async {
            self.view.addSubview(loader)
        }
        
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

    func layoutActivity()
    {
        let activityIndicator = UIViewController.activityIndicator
        
        activityIndicator.center = self.view.center
    }
    
    func stopLoading() {
        let activityIndicator = UIViewController.activityIndicator
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
        UIApplication.shared.endIgnoringInteractionEvents()
      }
}

// MARK: - Screen Dimensions Constant
struct ScreenDimension
{
    static let Width = UIScreen.main.bounds.width
    static let Height = UIScreen.main.bounds.height

    static var Insets: UIEdgeInsets
    {
        if #available(iOS 11.0, *)
        {
            let inset = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
            return inset
        }
        else
        {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
    static let cartGuideVHeight = 65 + ScreenDimension.Insets.bottom
}

class CustomError
{
    @objc class func show(text message:String, color backgroundColor:UIColor)
    {
        
        let topSpace = ScreenDimension.Insets.top//ScreenDimension.Insets.top > 20 ? ScreenDimension.Insets.top : 0
        
        
        let popview = UIView(frame: CGRect(x: 0, y: topSpace, width: ScreenDimension.Width, height: 25))
        popview.backgroundColor = backgroundColor
        
        
        let modalWindow:UIWindow = UIWindow(frame: CGRect(x: 0, y: -(25 + topSpace), width: ScreenDimension.Width, height: 25 + topSpace))

        modalWindow.backgroundColor = backgroundColor
        modalWindow.isHidden = false
        
        modalWindow.addSubview(popview)
        
        modalWindow.windowLevel = (UIWindow.Level.statusBar + 1)

        
        modalWindow.makeKeyAndVisible()
        
       // UIApplication.shared.keyWindow?.addSubview(modalWindow)
        
        let lb = UILabel(frame: CGRect(x: 8, y: 0, width: popview.frame.size.width - 16, height: 25))
        
        lb.textAlignment = .center
        lb.numberOfLines = 1
        lb.textColor = .white
        lb.font = UIFont(name: "GothamMedium", size: 13)
        
        lb.text = message
        popview.addSubview(lb)
        
        UIView.animate(withDuration: 0.4, animations: {
          //  popview.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 25)
            modalWindow.frame = CGRect(x: 0, y: 0, width: ScreenDimension.Width, height: 25 + topSpace)
        }) { (_ finished) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7, execute: {
                
                UIView.animate(withDuration: 0.4, animations: {
                   // popview.frame = CGRect(x: 0, y: -30, width: screenWidth, height: 25)
                    modalWindow.frame = CGRect(x: 0, y: -(25 + topSpace), width: ScreenDimension.Width, height: 25 + topSpace)
                }) { (_ finished) in
                   // popview.removeFromSuperview()
                    modalWindow.removeFromSuperview()
                }
                
            })
        }
    }
}
