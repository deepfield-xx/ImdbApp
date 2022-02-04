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
    let itemSize: CGFloat = 80
    
    var cellCount: Int {
        return cols * rows
    }
    
    var cViewSize: CGSize {
        return self.collectionView!.frame.size
    }
    
    var center: CGPoint {
        return CGPoint(x: cViewSize.width / 2.0, y: cViewSize.height / 2.0)
    }
    
    var a: CGFloat {
        return 2.5 * cViewSize.width
    }
    
    var b: CGFloat {
        return 2.5 * cViewSize.height
    }
    
    let c: CGFloat = 20
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize   {
        return CGSize(width: itemSize * CGFloat(cols+1) + cViewSize.width * 0.5,
                      height: itemSize * CGFloat(rows+1) + cViewSize.height * 0.5)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        var itemDistance = [Int: Float]()
        for i in 0 ..< cellCount {
            let indexPath = IndexPath(item: i, section: 0)
            let itemAttributes = layoutAttributesForItem(at: indexPath)!
            attributes.append(itemAttributes)
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
         
        x = -x*x/(a*a)
        y = -y*y/(b*b)
        var z = c * (x+y) + 1
        z = z < 0.0 ? 0.0 : z
//        z = z / (0.9 + dist/250)
         
        attributes.transform = CGAffineTransform(scaleX: z, y: z)
        attributes.size = CGSize(width: self.itemSize, height: self.itemSize)
         
        return attributes
    }
}
