//
//  ViewController.swift
//  NavBarAnimation(Snacks)
//
//  Created by WendaLi on 2020-05-16.
//  Copyright © 2020 WendaLi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var navBarView: UIView!
    @IBOutlet var navBarHight: NSLayoutConstraint!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var snakList: UITableView!
    
    private var optionsStackView: UIStackView!
    
    let snackTitle: UILabel = {
        let title = UILabel()
        title.text = "SNACKS"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let image1:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "oreos")
        image.accessibilityIdentifier = "oreos"
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let image2:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pizza_pockets")
        image.accessibilityIdentifier = "pizza_pockets"
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let image3:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pop_tarts")
        image.accessibilityIdentifier = "pop_tarts"
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let image4:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "popsicle")
        image.accessibilityIdentifier = "popsicle"
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let image5:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ramen")
        image.accessibilityIdentifier = "ramen"
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private var snacks: [String] = []
    private var navBarOpenOrNot = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navBarView.addSubview(snackTitle)
        setupLayout()
        snakList.dataSource = self
        snakList.delegate = self
    }
    private func setupLayout() {
        let singleTapGesture1 = UITapGestureRecognizer(target: self, action: #selector(addSnack))
        image1.addGestureRecognizer(singleTapGesture1)
        let singleTapGesture2 = UITapGestureRecognizer(target: self, action: #selector(addSnack))
        image2.addGestureRecognizer(singleTapGesture2)
        let singleTapGesture3 = UITapGestureRecognizer(target: self, action: #selector(addSnack))
        image3.addGestureRecognizer(singleTapGesture3)
        let singleTapGesture4 = UITapGestureRecognizer(target: self, action: #selector(addSnack))
        image4.addGestureRecognizer(singleTapGesture4)
        let singleTapGesture5 = UITapGestureRecognizer(target: self, action: #selector(addSnack))
        image5.addGestureRecognizer(singleTapGesture5)
        
        snackTitle.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor).isActive = true
        snackTitle.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor, constant: 20).isActive = true
        
        optionsStackView = UIStackView(arrangedSubviews: [image1, image2, image3, image4, image5])
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        optionsStackView.axis = .horizontal
        optionsStackView.alignment = .center
        optionsStackView.distribution = .fillEqually
        optionsStackView.isHidden = true
        
        view.addSubview(optionsStackView)
        NSLayoutConstraint.activate([
            optionsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            optionsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            optionsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            optionsStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        if !navBarOpenOrNot {
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: {
                self.navBarHight.constant = 200
                self.snackTitle.centerYAnchor.constraint(equalTo: self.navBarView.centerYAnchor, constant: -40).isActive = true
            }, completion: { (true) in
                self.optionsStackView.isHidden = false
                })
            UIView.animate(withDuration: 1.0) {
                let rotationTransform = CGAffineTransform(rotationAngle: .pi/4 )
                self.addButton.transform = rotationTransform
            }
            navBarOpenOrNot = true
        }else {
            UIView.animate(withDuration: 1.0, animations: {
                self.optionsStackView.isHidden = true
                self.navBarHight.constant = 88
                self.snackTitle.centerYAnchor.constraint(equalTo: self.navBarView.centerYAnchor, constant: 20).isActive = true
                self.addButton.transform = CGAffineTransform.identity
            })
            navBarOpenOrNot = false
        }
    }
    
    @objc func addSnack(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        if imageView.accessibilityIdentifier == "oreos" {
            snacks.append("Oreos")
        }else if imageView.accessibilityIdentifier == "pizza_pockets" {
            snacks.append("Pizza Pockets")
        }else if imageView.accessibilityIdentifier == "pop_tarts" {
            snacks.append("Pop Tarts")
        }else if imageView.accessibilityIdentifier == "popsicle" {
            snacks.append("Popsicle")
        }else if imageView.accessibilityIdentifier == "ramen" {
            snacks.append("Ramen")
        }
        snakList.insertRows(at: [IndexPath(row: snacks.count - 1, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "snackCell", for: indexPath)
        cell.textLabel?.text = snacks[indexPath.row]
        return cell
    }
}

