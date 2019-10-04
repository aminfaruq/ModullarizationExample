//
//  DetailVC.swift
//  HomeModule
//
//  Created by Amin faruq on 01/10/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import UIKit
import SDWebImage
import GITSFramework
import Alamofire
import SwiftyJSON

class DetailVC: UIViewController {
    
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var collectionActors: UICollectionView!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var lbSubView: UILabel!
    var input : HomeRequest?
    var imgMovie : String?
    var labelTitle : String?
    var labelOverview : String?
    var labelDate : String?
    var creditModel : [CreditsModel] = []
    var similarModel : [MovieModel] = []
    var movie_id : Int?
    let URL_IMAGE = "https://image.tmdb.org/t/p/original"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allFunc()
    }
    
    func allFunc(){
        self.getApi()
        self.dataFromTableView()
        self.registerCell()
    }
    
    func getApi(){
        self.input?.getCredit(movie_id: "\(movie_id ?? 0)")
        self.input?.getSimilar(movie_id: "\(movie_id ?? 0)")
    }
    
    func dataFromTableView(){
        lbTitle.text = labelTitle
        lbOverview.text = labelOverview
        lbSubView.text = labelDate
        imgDetail.sd_setImage(with: URL(string: imgMovie ?? ""), completed: nil)
    }
    
    func registerCell() {
        self.collectionActors.register(UINib.init(nibName: "ActorsCell", bundle: self.nibBundle), forCellWithReuseIdentifier: "ActorsCell")
        self.tbView.register(UINib.init(nibName: "TableCell", bundle: self.nibBundle), forCellReuseIdentifier: "TableCell")
        self.collectionActors.delegate = self
        self.collectionActors.dataSource = self
        self.tbView.delegate = self
        self.tbView.dataSource = self
    }
    
    @IBAction func buttonPressed(_ sender: RoundedButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - Setup collection
extension DetailVC : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creditModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collection = collectionView.dequeueReusableCell(withReuseIdentifier:"ActorsCell" , for: indexPath) as! ActorsCell
        collection.ImgActors.sd_setImage(with: URL(string: URL_IMAGE + creditModel[indexPath.item].profile_path!))
        collection.lbName.text = self.creditModel[indexPath.item].name
        return collection
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 100, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - Set up tableView
extension DetailVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.imgMovie.sd_setImage(with: URL(string: URL_IMAGE + similarModel[indexPath.item].posterPath!), placeholderImage: UIImage(named: "placeholder"))
        cell.lbTitle.text = self.similarModel[indexPath.item].title
        cell.lbOverview.text = self.similarModel[indexPath.item].overview
        cell.lbSubview.text = self.similarModel[indexPath.item].releaseDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Get API Service
extension DetailVC : HomeResponse {
    override func awakeFromNib() {
        self.config(vc: self)
    }
    
    func config(vc : DetailVC){
        var request = HomePresenter()
        request.output = vc
        vc.input = request
    }
    
    func displayGetCredit(result: [CreditsModel]) {
        self.creditModel = result
        self.collectionActors.reloadData()
    }
    
    func displayGetSimilar(result: [MovieModel]) {
        self.similarModel = result
        self.tbView.reloadData()
        self.tableviewHeight.constant = self.tbView.contentSize.height*3.1
    }
    
    func displayError(message: String, object: Any) {
        print(message)
    }
    
    func resultRequest(request: DataRequest) {}
  
}
