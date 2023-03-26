//
//  HomeCollectionViewCell.swift
//  BurgerStoresTest
//
//  Created by Jose David Bustos H on 26-03-23.
//

import UIKit
struct HomeTableViewModel {
    let name: String
    let title: String
    let images: String
    let precio: String
    init(name: String, title: String, images: String, precio: String) {
        self.name = name
        self.title = title
        self.images = images
        self.precio = precio
    }
}
class HomeCollectionViewCell: UICollectionViewCell {
    lazy var lblName: UILabel = {
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
        image.layer.cornerRadius = 20.0
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var btnDetails: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = .systemGreen
        button.setTitle("Ver Detalle", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
            super.init(frame: frame)
        configLabels()
        setupUIUX()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(_ model: HomeTableViewModel) {
        if let imageURL = URL(string:model.images) {
            DispatchQueue.global().async { [self] in
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        imgMenu.image =  image
                    }
                }
            }
        }
        lblName.text = model.name
        lblPrice.text = "$" + model.precio
    }
    func configLabels(){
        lblName.font = UIFont.boldSystemFont(ofSize: 20.0)
        lblName.textColor = UIColor.black
        lblName.numberOfLines = 0
        lblPrice.font = UIFont.boldSystemFont(ofSize: 25.0)
        lblPrice.textColor = .systemGreen
        lblPrice.numberOfLines = 0
    }
    func setupUIUX(){
        self.backgroundColor = .white
        addSubview(lblName)
        addSubview(lblPrice)
        addSubview(imgMenu)
        addSubview(btnDetails)
        
        imgMenu.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imgMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        imgMenu.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        imgMenu.heightAnchor.constraint(equalToConstant: 130).isActive = true
        imgMenu.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        lblName.topAnchor.constraint(equalTo: imgMenu.bottomAnchor, constant: 10).isActive = true
        lblName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        lblName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        lblName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        lblPrice.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 10).isActive = true
        lblPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        lblPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        lblPrice.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblPrice.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        btnDetails.topAnchor.constraint(equalTo: lblPrice.bottomAnchor, constant: 10).isActive = true
        btnDetails.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        btnDetails.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        btnDetails.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnDetails.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
}
