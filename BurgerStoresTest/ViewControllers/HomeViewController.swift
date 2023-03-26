//
//  HomeViewController.swift
//  BurgerStoresTest
//
//  Created by Jose David Bustos H on 26-03-23.
//

import UIKit
struct itemTableViewModel {
    let name: String
    let desc: String
    let images: String
    let price: String
    let latitude: String
    let longitude: String
    init(name: String, desc: String,
         images: String, price: String,
         latitude: String ,longitude: String) {
        self.name = name
        self.desc = desc
        self.images = images
        self.price = price
        self.latitude = latitude
        self.longitude = longitude
    }
}
class HomeViewController: UIViewController {

    var listMenus = [Product]()
    var searching = false
    var searchedMenu =  [Product]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - IBOutlets
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 200, height: 300)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           return collectionView
       }()
    
    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: - call MenuListViewModel
    public var menuListVM: MenuListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtonCarro()
        setUpButtonMenu()
        setUpCollectionView()
        setupVM()
        configureSearchController()
    }
    func configureSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically  = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Buscar por nombre"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.backgroundColor = .white
    }
    private func setUpCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 10.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setUpButtonCarro() {
        let buttonIcon = UIImage(named: "ico-cart")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: buttonIcon,
            style: .plain,
            target: self,
            action: #selector(irCarroMarket(sender:))
        )
    }
    private func setUpButtonMenu() {
        let buttonIcon = UIImage(named: "menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: buttonIcon,
            style: .plain,
            target: self,
            action: #selector(OpenMenu(sender:))
        )
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
extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching{
            return searchedMenu.count
        }else{
            return self.menuListVM == nil ? 0 : self.menuListVM.numberOfSections
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        
        if searching {
            let articleVM = searchedMenu[indexPath.row]
            let paths = String(searchedMenu[indexPath.row].image)
            if let imageURL = URL(string:paths) {
                DispatchQueue.global().async { [self] in
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.imgMenu.image =  image
                            stoploading()
                        }
                    }
                }
            }
            cell.lblName.text = searchedMenu[indexPath.row].name
            cell.lblPrice.text = "$" + String(searchedMenu[indexPath.row].price)
            cell.btnDetails.tag = indexPath.row
           cell.btnDetails.addTarget(self, action: #selector(goToDetailsView(sender:)), for: .touchUpInside)
             
        }else{
            let articleVM = self.menuListVM.articleAtIndex(indexPath.row)
            let paths = String(articleVM.productosMenu[indexPath.row].image)
            cell.configure(HomeTableViewModel(name: articleVM.productosMenu[indexPath.row].name, title: articleVM.productosMenu[indexPath.row].desc, images: paths, precio: String(articleVM.productosMenu[indexPath.row].price)))
           cell.btnDetails.tag = indexPath.row
           cell.btnDetails.addTarget(self, action: #selector(goToDetailsView(sender:)), for: .touchUpInside)
        }
        return cell
    }
    @objc func goToDetailsView(sender:UIButton){
        print(sender)
        let indexpaths = IndexPath(row: sender.tag, section: 0)
        
        if searching {
            self.selectVC(item: itemTableViewModel(name: searchedMenu[sender.tag].name, desc: searchedMenu[sender.tag].desc, images: String(searchedMenu[sender.tag].image), price: String(searchedMenu[sender.tag].price), latitude: searchedMenu[sender.tag].latitude, longitude: searchedMenu[sender.tag].longitude))
            
        } else {
            let productoVM = self.menuListVM.articleAtIndex(sender.tag)
            let paths = String(productoVM.productosMenu[sender.tag].image)
            self.selectVC(item: itemTableViewModel(name: productoVM.productosMenu[sender.tag].name, desc: productoVM.productosMenu[sender.tag].desc, images: String(productoVM.productosMenu[sender.tag].image), price: String(productoVM.productosMenu[sender.tag].price), latitude: productoVM.productosMenu[sender.tag].latitude, longitude: productoVM.productosMenu[sender.tag].longitude))
        }
    }
}
extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            searching = true
            searchedMenu.removeAll()
            for item in menuListVM.productosMenu {
                if item.name.lowercased().contains(searchText.lowercased())
                {
                    searchedMenu.append(item)
                }
            }
        }else{
            searching = false
            searchedMenu.removeAll()
            searchedMenu = menuListVM.productosMenu
        }
        
        collectionView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searching = false
        searchedMenu.removeAll()
        collectionView.reloadData()
    }

}
extension HomeViewController {
    private func setupVM() {
        webServicesMenu().getArticles() { articles in
            if let articles = articles {
                self.menuListVM = MenuListViewModel(productosMenu: articles)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
    
    // MARK: - Actions
    @objc func irCarroMarket(sender: UIBarButtonItem) {
        //goToCarroMarket()
    }
    @objc func OpenMenu(sender: UIBarButtonItem) {
        //goToCarroMarket()
    }
    // MARK: - Functions
    private func startloading(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
    }
    private func stoploading(){
        self.dismiss(animated: false, completion: nil)
    }
    func selectVC(item: itemTableViewModel) {
        let storyboard = self.storyboard?.instantiateViewController(identifier: "HomeDetailsViewController") as! HomeDetailsViewController
        storyboard.nombreString = item.name
        storyboard.imageString = String(item.images)
        storyboard.decripString = item.desc
        storyboard.precio = "$" + String(item.price)
        storyboard.latitud = item.latitude
        storyboard.lontitud = item.longitude
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
}

