//
//  ViewController + extentions.swift
//  Cinema
//
//  Created by Азат Киракосян on 11.01.2021.
//

import UIKit


// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filteredStudents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.setupWithModel(model: filteredStudents[indexPath.row])
       // cell.backgroundColor = .blue
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController : UICollectionViewDelegate { }


// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 32
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let frameSize = collectionView.frame.size
         return CGSize(width: frameSize.width - 32, height: UIScreen.main.bounds.width - 32.0)
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

         return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
     }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.alpha = 0
//        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {cell.alpha = 1})
//      }
    }








