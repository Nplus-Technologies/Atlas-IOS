//
//  SearchView.swift
//  ATLAS
//
//  Created by spextrum on 10/03/20.
//  Copyright © 2020 spextrum. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    var stackView = UIStackView()
    var searchTextField = UITextField()
    var searchResultAddressLbl = UILabel()
    var searchResultLatLongLbl = UILabel()
    var tableView = UITableView()
    
    var layoutDict = [String: AnyObject]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setup(Base baseView: UIView) {
        
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["stackView"] = stackView
        baseView.addSubview(stackView)
        
        searchTextField.addBorder(edges: .all , thickness: 1.5)
        searchTextField.addIcon(UIImage(named: ""))
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .none
        searchTextField.placeholder = "Search"
        searchTextField.font = UIFont.init(name: SearchHelper.appFontName, size: 20)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["searchTextField"] = searchTextField
        stackView.addArrangedSubview(searchTextField)
        
        searchResultAddressLbl.numberOfLines = 0
        searchResultAddressLbl.lineBreakMode = .byWordWrapping
        searchResultAddressLbl.translatesAutoresizingMaskIntoConstraints = false
        searchResultAddressLbl.textColor = .lightGray
        layoutDict["searchResultAddressLbl"] = searchResultAddressLbl
        stackView.addArrangedSubview(searchResultAddressLbl)
        
        searchResultLatLongLbl.numberOfLines = 0
        searchResultLatLongLbl.lineBreakMode = .byWordWrapping
        searchResultLatLongLbl.translatesAutoresizingMaskIntoConstraints = false
        searchResultLatLongLbl.textColor = .lightGray
        layoutDict["searchResultLatLongLbl"] = searchResultLatLongLbl
        stackView.addArrangedSubview(searchResultLatLongLbl)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["tableView"] = tableView
        baseView.addSubview(tableView)
        
        
        stackView.topAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[stackView]-10-[tableView]", options: [], metrics: [:], views: layoutDict))
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[stackView]-25-|", options: [], metrics: [:], views: layoutDict))
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: [:], views: layoutDict))
        
        searchTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
}

// TableView Cell
class SearchListTableViewCell: UITableViewCell {
    
    var layoutDic = [String:AnyObject]()
    var placenameLbl = UILabel()
    var placeImv = UIImageView()
    var placeaddLbl = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpViews() {
        selectionStyle = .none
        
        placenameLbl.font = UIFont.init(name: SearchHelper.appFontName, size: 22)
        placenameLbl.translatesAutoresizingMaskIntoConstraints = false
        layoutDic["placenameLbl"] = placenameLbl
        addSubview(placenameLbl)
        
        placeImv.contentMode = .scaleAspectFit
        placeImv.translatesAutoresizingMaskIntoConstraints = false
        layoutDic["placeImv"] = placeImv
        addSubview(placeImv)
        
        placeaddLbl.font = UIFont.init(name: SearchHelper.appFontName, size: 18)
        placeaddLbl.translatesAutoresizingMaskIntoConstraints = false
        placeaddLbl.numberOfLines = 0
        placeaddLbl.lineBreakMode = .byWordWrapping
        layoutDic["placeaddLbl"] = placeaddLbl
        addSubview(placeaddLbl)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[placeImv(20)]-(15)-[placenameLbl]-(20)-|", options: [], metrics: nil, views: layoutDic))
        placeImv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        placeImv.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(8)-[placenameLbl(21)]-(3)-[placeaddLbl(>=15)]-(5)-|", options: [.alignAllLeading,.alignAllTrailing], metrics: nil, views: layoutDic))
    }
}

// Set of Extensions

// Adding Border
extension UIView {
    func addBorder(edges: UIRectEdge, colour: UIColor = UIColor.black, thickness: CGFloat = 1, leftPadding: CGFloat = 0, rightPadding: CGFloat = 0, topPadding: CGFloat = 0, bottomPadding: CGFloat = 0) -> Void {
        func border() -> UIView {
            let border = UIView()
            border.backgroundColor = colour
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",options: [],metrics: ["thickness": thickness],views: ["top": top]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(leftPadding)-[top]-(rightPadding)-|",options: [],metrics: ["leftPadding": leftPadding,"rightPadding":rightPadding],views: ["top": top]))
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",options: [],metrics: ["thickness": thickness],views: ["left": left]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(topPadding)-[left]-(bottomPadding)-|",options: [],metrics: ["topPadding": topPadding, "bottomPadding": bottomPadding],views: ["left": left]))
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",options: [],metrics: ["thickness": thickness],views: ["right": right]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(topPadding)-[right]-(bottomPadding)-|",options: [],metrics: ["topPadding": topPadding, "bottomPadding": bottomPadding],views: ["right": right]))
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",options: [],metrics: ["thickness": thickness],views: ["bottom": bottom]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(leftPadding)-[bottom]-(rightPadding)-|",options: [],metrics: ["leftPadding": leftPadding,"rightPadding":rightPadding],views: ["bottom": bottom]))
        }
    }
}

// Font
extension UIFont {
    class func appFont(ofSize:CGFloat) -> UIFont {
        return UIFont(name: SearchHelper.appFontName, size: ofSize) ?? UIFont.systemFont(ofSize:ofSize)

    }
}

// TextField leftside set image or space 
extension UITextField {
    
    func addIcon(_ image: UIImage?) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imgView = UIImageView()
        imgView.image = image
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        view.addSubview(imgView)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(4)-[imgView(20)]-(4)-|", options: [], metrics: nil, views: ["imgView":imgView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[imgView(width)]-(10)-|", options: [], metrics: ["width":image == nil ? 0 : 5], views: ["imgView":imgView]))
        
        leftViewMode = .always
        leftView = view
    }
    
}
