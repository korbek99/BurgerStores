//
//  HomeDetailsViewController.swift
//  BurgerStoresTest
//
//  Created by Jose David Bustos H on 26-03-23.
//

import UIKit

class HomeDetailsViewController: UIViewController {
    
    var nombreString:String?
    var decripString:String?
    var imageString:String?
    var precio:String?
    var latitud:String?
    var lontitud:String?
    
    lazy var lblName: UILabel = {
        let label: UILabel = .init()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var lbldescrip: UILabel = {
        let label: UILabel = .init()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var lblPrice: UILabel = {
        let label: UILabel = .init()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var imgMenu: UIImageView = {
        let image: UIImageView = .init()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 15.0
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var btnAddToCart: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = .white
        button.setTitle("Agregar a Carro", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var btnMap: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = .white
        button.setTitle("Ver Mapa", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var viewHeader: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var viewBody: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var viewFooter: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.addArrangedSubview(viewHeader)
        stackView.addArrangedSubview(viewBody)
        stackView.addArrangedSubview(viewFooter)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollview: UIScrollView = .init()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configLabels()
        setupHeader()
        setupBody()
        setupFooter()
        setupUX()
        setUpButtonFavorites()
    }
    private func setUpButtonFavorites() {
        let buttonIcon = UIImage(named: "ico-cart")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: buttonIcon,
            style: .plain,
            target: self,
            action: #selector(addToFavorites(sender:))
        )
    }
    func configLabels(){
        lblName.text = nombreString
        lblName.font = UIFont.boldSystemFont(ofSize: 35.0)
        lblName.textColor = UIColor.black
        lblName.numberOfLines = 0
        
        lbldescrip.text = decripString
        lbldescrip.font = UIFont.systemFont(ofSize: 20.0)
        lbldescrip.textColor = UIColor.gray
        lbldescrip.numberOfLines = 0
        
        lblPrice.text = precio
        lblPrice.font = UIFont.boldSystemFont(ofSize: 25.0)
        lblPrice.textColor = .systemGreen
        lblPrice.numberOfLines = 0
        
        if let imageURL = URL(string: imageString!) {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    imgMenu.image =  image
                }
        }
    }
    func setupHeader(){
        self.viewHeader.backgroundColor = .white
        viewHeader.heightAnchor.constraint(equalToConstant: 300).isActive = true
        viewHeader.addSubview(lblName)
        viewHeader.addSubview(lbldescrip)
       // viewHeader.addSubview(btnMap)
        viewHeader.addSubview(lblPrice)

        lblName.topAnchor.constraint(equalTo: viewHeader.topAnchor, constant: 120).isActive = true
        lblName.leadingAnchor.constraint(equalTo: viewHeader.leadingAnchor, constant: 15).isActive = true
        lblName.trailingAnchor.constraint(equalTo: viewHeader.trailingAnchor, constant: -15).isActive = true
        lblName.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        
        lbldescrip.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 10).isActive = true
        lbldescrip.leadingAnchor.constraint(equalTo: viewHeader.leadingAnchor, constant: 15).isActive = true
        lbldescrip.trailingAnchor.constraint(equalTo: viewHeader.trailingAnchor, constant: -15).isActive = true

        lbldescrip.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lblPrice.topAnchor.constraint(equalTo: lbldescrip.bottomAnchor, constant: 15).isActive = true
        lblPrice.leadingAnchor.constraint(equalTo: viewHeader.leadingAnchor, constant: 15).isActive = true
        lblPrice.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lblPrice.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
//        btnVerMapas.topAnchor.constraint(equalTo: lblTitleDetail.bottomAnchor, constant: 20).isActive = true
//        btnVerMapas.trailingAnchor.constraint(equalTo: viewHeader.trailingAnchor, constant: -15).isActive = true
//        btnVerMapas.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        btnVerMapas.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupBody(){
        self.viewBody.backgroundColor = .white
        viewBody.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        viewBody.addSubview(imgMenu)
        
        imgMenu.topAnchor.constraint(equalTo: viewBody.topAnchor, constant: 5).isActive = true
        imgMenu.leadingAnchor.constraint(equalTo: viewBody.leadingAnchor, constant: 5).isActive = true
        imgMenu.trailingAnchor.constraint(equalTo: viewBody.trailingAnchor, constant: -5).isActive = true
        imgMenu.bottomAnchor.constraint(equalTo: viewBody.bottomAnchor, constant: 5).isActive = true
        imgMenu.heightAnchor.constraint(equalToConstant: 400).isActive = true
        imgMenu.widthAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func setupFooter(){
        self.viewFooter.backgroundColor = .white
        viewFooter.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupUX(){
        view.addSubview(scrollView)
        view.addSubview(stackView)
        let safeAreaInset = UIApplication.shared.windows.first?.safeAreaInsets

    scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    scrollView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -(safeAreaInset?.top ?? 0.0)).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -(safeAreaInset?.top ?? 0.0)).isActive = true
        
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
extension HomeDetailsViewController {
    // MARK: - Actions
    
    
    @objc func addToFavorites(sender: UIButton) {
       // goToMapaView()
    }
    @objc func irMapaMarket(sender: UIButton) {
        goToMapaView()
    }
    @objc func irWebviewMarket(sender: UIButton) {
        goToWebView()
    }
    
    func goToMapaView(){
        
    }
    func goToWebView(){
        
    }

}
