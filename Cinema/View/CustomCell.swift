//
//  CustomCell.swift
//  Cinema
//
//  Created by Азат Киракосян on 09.01.2021.
//

import UIKit
 
final class CustomCell: UICollectionViewCell {
    
    private var myImageView = UIImageView()
    private let titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        titleLabel.font = titleLabel.font.withSize(35)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5)
        ])
        
        createImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   private func createImageView() {
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.contentMode = .scaleToFill
        myImageView.clipsToBounds = true
        myImageView.layer.cornerRadius = (frame.height * 0.72) / 2
        myImageView.layer.masksToBounds = true
        contentView.addSubview(myImageView)
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 85),
            myImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            myImageView.widthAnchor.constraint(equalToConstant: 280),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func setupWithModel(model: CityModel) {
        if let url = model.image {
            getImageDataFrom(url: url)
        }
        
        titleLabel.text = model.title
        
       
    }
    

    private func getImageDataFrom(url: URL) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.myImageView.image = image
                }
            }
        }.resume()
    }
}





