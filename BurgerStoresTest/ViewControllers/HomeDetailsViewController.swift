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
