//
//  HomeVC.swift
//  HomeModule
//
//  Created by Amin faruq on 25/09/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import UIKit
import GITSFramework
import Alamofire
import SDWebImage
import iCarousel
import MXParallaxHeader

class HomeVC: BaseViewController {

    @IBOutlet weak var carousel: iCarousel!
    @IBOutlet weak var collectionCategories: UICollectionView!
    @IBOutlet weak var tbViewMovie: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    var isLoad: Bool = false
    var timer: Timer?
    var input : HomeRequest?
    let URL_IMAGE = "https://image.tmdb.org/t/p/original"
    var movieModel : [MovieModel] = []
    var genreModel : [GenreModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allFunc()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func allFunc(){
        self.inputService()
        self.registerCell()
        self.setupCarousel()
    }
    
    func inputService(){
        self.input?.doGetMovieList()
        self.input?.getBanner()
        self.input?.getGenre()
    }
    
    //MARK: register collection & tableview cell
    func registerCell() {
        self.tbViewMovie.register(UINib.init(nibName: "TableCell", bundle: self.nibBundle), forCellReuseIdentifier: "TableCell")
        self.collectionCategories.register(UINib.init(nibName: "CategoriesCell", bundle: self.nibBundle), forCellWithReuseIdentifier: "CategoriesCell")
        self.tbViewMovie.delegate = self
        self.tbViewMovie.dataSource = self
        self.collectionCategories.delegate = self
        self.collectionCategories.dataSource = self
    }
}

// MARK: - Setup collectionView
extension HomeVC :  UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreModel.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
            return CGSize(width: view.frame.width/2.5, height: view.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let collection = collectionView.dequeueReusableCell(withReuseIdentifier:"CategoriesCell" , for: indexPath) as! CategoriesCell
            collection.lbCategories.text = self.genreModel[indexPath.item].name
            collection.layer.cornerRadius = 10
            collection.layer.masksToBounds = true
            return collection
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HomeWireframe.performToDiscoverMovie(genreId: genreModel[indexPath.item].id ?? 0, caller: self)
    }
    
    @objc func nextBanner() {
        carousel.scroll(byOffset: 1, duration: 1.0)
    }
    
}

//MARK: - Setup table view
extension HomeVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbViewMovie.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.imgMovie.sd_setImage(with: URL(string: URL_IMAGE + movieModel[indexPath.item].posterPath!))
        cell.lbTitle.text = self.movieModel[indexPath.item].title
        cell.lbOverview.text = self.movieModel[indexPath.item].overview
        cell.lbSubview.text = self.movieModel[indexPath.item].releaseDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HomeWireframe.performToDetailMovie(imageUrl:"\(URL_IMAGE + self.movieModel[indexPath.item].posterPath!)", title: self.movieModel[indexPath.item].title ?? "", overviewLabel: self.movieModel[indexPath.item].overview ?? "", movieId: self.movieModel[indexPath.item].id ?? 0,date: 
            self.movieModel[indexPath.item].releaseDate ?? "",caller: self)
            tbViewMovie.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: Network service
extension HomeVC : HomeResponse{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.config(vc: self)
    }
    
    func config(vc : HomeVC){
        var request = HomePresenter()
        request.output = vc
        vc.input = request
    }
    
    func displayGetNotificationList(result: [MovieModel]) {
        self.movieModel = result
        print(movieModel = result)
        self.tbViewMovie.reloadData()
        print("tableViewHeight: \(self.tbViewMovie.contentSize.height)")
        self.tableViewHeight.constant = self.tbViewMovie.contentSize.height*3.1
    }
    
    func displayGetGenre(result: [GenreModel]) {
        self.genreModel = result
        self.collectionCategories.reloadData()
    }
    
    func displayGetBanner(result: [MovieModel]) {
        self.movieModel = []
        for dt in result{
            movieModel.append(MovieModel(posterPath: dt.posterPath, id: dt.id, title: dt.title, overview: dt.overview, releaseDate: dt.releaseDate))
        }
        if !isLoad {
            isLoad = true
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(nextBanner), userInfo: nil, repeats: true)
        }
        self.stopLoading(isError: false, message: "")
        //self.pageControl.numberOfPages = self.movieModel.count
        self.pageControl.isHidden = true
        self.pageControl.currentPage = 0
        carousel.reloadData()
    }
    
    func displayError(message: String, object: Any) {
        print(message)
    }
    
    func resultRequest(request: DataRequest) {}
}

//MARK: iCarousel setup
extension HomeVC : iCarouselDelegate, iCarouselDataSource{

    func setupCarousel() {
        carousel.type = .coverFlow
        carousel.isPagingEnabled = true
        carousel.delegate = self
        carousel.dataSource = self
        carousel.reloadData()
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.movieModel.count
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view : BannerHome = BannerHome.instantiateFromNib()
        view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        if let bannerUrl = movieModel[index].posterPath {
            view.imgBanner.sd_setImage(with: URL(string: URL_IMAGE + bannerUrl), completed: nil)
            view.lbTitle.text = self.movieModel[index].title
            view.lbGenre.text = self.movieModel[index].releaseDate
        }
        return view
    }

    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        self.pageControl.currentPage = carousel.currentItemIndex
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch (option)
        {
        case .wrap:
            return 1
        case .spacing:
            return value * 1
        default:
            return value
        }
    }

}
