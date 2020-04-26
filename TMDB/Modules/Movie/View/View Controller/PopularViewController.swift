//
//  PopularMoviesViewController.swift
//  TMDB
//
//  Created by Fariba Heidari on 2/4/1399 AP.
//  Copyright © 1399 AP Fariba. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift

class PopularMoviesViewController: UIViewController, StoryboardInitializable {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)}()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var movies = [MovieModel]()
    
    var viewModel: PopularMoviesViewModel!
    
    var loading = false
    let spinToken = "spinner"
    var page = 1
    var selectedYear: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addFilterButton()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utility.showHUDLoading(title: "Info", message: "Loading...")
        self.getContent()
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func addFilterButton() {
        let filterButton : UIBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showDatePicker))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = filterButton
    }
    
    @objc private func showDatePicker(){
        let datePickerViewController = DatePickerViewController.initFromStoryboard()
        datePickerViewController.delegate = self
        self.navigationController?.present(datePickerViewController, animated: true, completion: nil)
    }
}

// MARK: Get Movie List From API

extension PopularMoviesViewController {
    func getContent(){
        _ = self.viewModel.getPopularMovieList(page: self.page).asObservable().subscribe(onNext: {[weak self] (response) in
            
            Utility.hideHUD()
            
            guard let strongSelf = self else{ return }
            
            strongSelf.loading = false
            
            if let list = response as? [MovieModel] {
                
                strongSelf.movies.append(contentsOf: list)
                
                strongSelf.adapter.performUpdates(animated: true)
            }
            
            }, onError: { (error) in  //handel error
                Utility.hideHUD()
        }, onCompleted: nil, onDisposed: {
            Utility.hideHUD()
        })
    }
}

// MARK: ListAdapterDataSource

extension PopularMoviesViewController :ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects = movies.filter{
            guard let releaseDate = $0.release_date , let date = releaseDate.date, self.selectedYear != 0 else {return true}
            return date.year == self.selectedYear
            
        } as [ListDiffable]
        
        if loading {
            objects.append(spinToken as ListDiffable)
        }
        
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let obj = object as? String, obj == spinToken {
            return spinnerSectionController()
        } else {
            let popularMoviewSC = PopularMovieSectionController()
            popularMoviewSC.delegate = self
            
            return popularMoviewSC
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return EmptyView()
    }
    
}

// MARK: UIScrollViewDelegate

extension PopularMoviesViewController :UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !loading && distance < 200 {
            loading = true
            adapter.performUpdates(animated: true, completion: nil)
            self.page = self.page + 1
            self.getContent()
            self.adapter.performUpdates(animated: true, completion: nil)
            
        }
    }
}

// MARK: Impelement PopularMovieSectionSelectItemDelegate to get selected section

extension PopularMoviesViewController:PopularMovieSectionSelectItemDelegate {
    func getSelecMovietSectionController(_ selectedSectionController: ListSectionController) {
        if let selectedSection = selectedSectionController as? PopularMovieSectionController {
            let section = adapter.section(for: selectedSection)
            guard let object = adapter.object(atSection: section) as? MovieModel else { return }
            self.viewModel.selectedMovie.onNext(object)
        }
    }
}

// MARK: Impelement DatePickerDelegate to filter movies

extension PopularMoviesViewController:DatePickerDelegate {
    func selectedYear(_ year: Int) {
        self.selectedYear = year
        self.adapter.performUpdates(animated: true, completion: nil)

    }
}
