//
//  DiscoverVC.swift
//  HomeModule
//
//  Created by Amin faruq on 03/10/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import UIKit
import GITSFramework
import Alamofire

class DiscoverVC: UIViewController {
    @IBOutlet weak var tbViewDiscover: UITableView!
    var discoverModel : [DiscoverModel] = []
    var input : HomeRequest?
    let URL_IMAGE = "https://image.tmdb.org/t/p/original"
    var id_genre : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.input?.getDiscover(withGenres: "\(id_genre ?? 0)")
        self.navigationController?.navigationBar.isHidden = false

    }
    
    func registerCell(){
         self.tbViewDiscover.register(UINib.init(nibName: "TableCell", bundle: self.nibBundle), forCellReuseIdentifier: "TableCell")
         self.tbViewDiscover.delegate = self
         self.tbViewDiscover.dataSource = self
    }
}

//MARK: SetupTableview
extension DiscoverVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoverModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tbViewDiscover.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.imgMovie.sd_setImage(with: URL(string: URL_IMAGE + discoverModel[indexPath.item].posterPath!), placeholderImage: UIImage(named: "placeholder"))
        cell.lbTitle.text = self.discoverModel[indexPath.item].title
        cell.lbOverview.text = self.discoverModel[indexPath.item].overview
        cell.lbSubview.text = self.discoverModel[indexPath.item].releaseDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbViewDiscover.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Setup Network service
extension DiscoverVC : HomeResponse{
    
    override func awakeFromNib() {
        self.config(vc: self)
    }
    
    func config(vc : DiscoverVC){
        var request = HomePresenter()
        request.output = vc
        vc.input = request
    }
    
    func displayGetDiscover(result: [DiscoverModel]) {
        self.discoverModel = result
        self.tbViewDiscover.reloadData()
    }
    
    func displayError(message: String, object: Any) {
        print(message)
    }
    
    func resultRequest(request: DataRequest) {}
    
}
