//
//  MovieCastCircleLayout.swift
//  ImdbApp
//
//  Created by Tom on 04/02/2022.
//

import UIKit

final class MovieCastCircleLayout: UICollectionViewLayout {
    let cols = 10
    let rows = 10
        
    let interimSpace: CGFloat = 0.0
    let itemSize: CGFloat = 103
    
    var cellCount: Int {
        return cols * rows
    }
    
    var cViewSize: CGSize {
        return self.collectionView!.frame.size
    }
    
    var center: CGPoint {
        return CGPoint(x: cViewSize.width / 2.0, y: cViewSize.height / 2.0)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize   {
        return CGSize(width: itemSize * CGFloat(cols+1) + cViewSize.width * 0.5,
                      height: itemSize * CGFloat(rows) + cViewSize.height * 0.5)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for i in 0 ..< cellCount {
            let indexPath = IndexPath(item: i, section: 0)
            let itemAttributes = layoutAttributesForItem(at: indexPath)
            attributes.append(itemAttributes!)
        }

        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
         
        let oIndex = indexPath.item % cols
        let vIndex = (indexPath.item - oIndex) / cols
         
        var x = CGFloat(oIndex) * itemSize + center.x
        var y = CGFloat(vIndex) * itemSize + center.y
         
        if vIndex % 2 != 0 {
            x += itemSize / 2.0
        }
         
        attributes.center = CGPoint(x: x, y: y)
         
        let offset = self.collectionView!.contentOffset
        x -= center.x + CGFloat(offset.x)
        y -= center.y + CGFloat(offset.y)
        let dist = CGFloat(sqrtf(Float(x*x + y*y)))
         
        let exp = dist < 20 ? 0.0 : (dist - 20)/80.0;
        let scale = pow(0.5, exp);
        
        let scaleTr = CGAffineTransform(scaleX: scale, y: scale)
        let translaeTr = CGAffineTransform(translationX: (scale-1)*x / 2.5, y: (scale-1)*y / 2.5)
        
        attributes.transform = scaleTr.concatenating(translaeTr)
        attributes.size = CGSize(width: self.itemSize, height: self.itemSize)
         
        return attributes
    }
}
