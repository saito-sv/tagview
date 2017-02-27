//
//  TagPresenterView.swift
//  YouPlus
//
//  Created by Marlon Monroy on 2/17/17.
//  Copyright © 2017 You Plus. All rights reserved.
//

import UIKit

class TagPresenterView: UICollectionView {

   
    var fakeData = FakeDataSource()
    var layout = TagPresenterCollectionLayout()
    let tagManager = TagPresenterDelegate()


    override func awakeFromNib() {
        setup()
    }
    
   func setup() {
    print("setup Called")

    // tagManager.dataSource = fakeData.tagsOneToThreeStars()
    layout.scrollDirection = .vertical
    delegate = tagManager
    dataSource = tagManager
    tagManager.didAddtag = didAddNewTagFromTextField
    self.collectionViewLayout = layout
    
    }
    
    func didAddNewTagFromTextField(tag:Tag) {
        //self.reloadData()
        self.insertItems(at: [IndexPath(item:0, section:0)])
    }
    
    func selectNewRating(dataSource:[Tag]) {
        tagManager.dataSource.removeAll(keepingCapacity: true)
        tagManager.dataSource = dataSource
        tagManager.diselecAlltags()
        
        self.reloadData()
    }
    
}

class TagPresenterDelegate:NSObject, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    // dataSource
    var dataSource = [Tag]()
    var tagsSelected = [Tag]()
    
    
    // current tags
    var lastSelectedTag = Tag()
    var lastDiselectedtag = Tag()
    // callbacks
    var didSelectTag:((Tag)->())?
    var didAddtag:((Tag)->())?
    var didHighlightTag:((Tag)->())?
    var didUnhighlightTag:((Tag)->())?
    var didRemoveAlltags:(()->())?
    var userDidEnterInvalidTag:((Tag)->())?
    var tagSelectedAtIndex:((Tag, IndexPath)->())?
    var numberOfselectedtags:(([Tag])->())?
    
    func containsTag(tag:Tag) -> Bool {
        for (index, item) in tagsSelected.enumerated(){
            if tag.titleLabel?.text == item.titleLabel?.text {
                tagsSelected.remove(at: index)
                return true
            }
        }
        
        return false
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = dataSource[indexPath.row]
       let size = tag.intrinsicContentSize
        return size
    }
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TagViewCell
        cell.feedTag = dataSource[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let currentTag = dataSource[indexPath.row]
        
        if containsTag(tag: currentTag) {
            currentTag.setDiselectedState()
            self.numberOfselectedtags?(tagsSelected)
           
        }else {
            currentTag.setSelectedState()
            addSelectedTag(tag: currentTag)
            self.lastSelectedTag = currentTag
            self.didHighlightTag?(currentTag)
            self.numberOfselectedtags?(tagsSelected)
           
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
         let currentTag = dataSource[indexPath.row]
        self.lastDiselectedtag = currentTag
        self.didUnhighlightTag?(currentTag)
        
    }
    
    func addTag(tag:Tag) {
        if validateTag(tag) {
           dataSource.insert(tag, at: 0)
           tagsSelected.append(tag)
            self.didAddtag?(tag)
            tag.setSelectedState()
            self.numberOfselectedtags?(tagsSelected)
        }
        
    }
    
    func addSelectedTag(tag:Tag) {
        tagsSelected.append(tag)
    }
    
    func diselecAlltags() {
        if dataSource.count > 0 {
            dataSource.forEach({ (tag) in
                tag.setDiselectedState()
               
            })
            tagsSelected.forEach({ (tag) in
                tag.setDiselectedState()
                 self.tagsSelected.removeAll()
            })
            
            self.didRemoveAlltags?()
            self.numberOfselectedtags?(tagsSelected)
        }
    }
    
    func validateTag(_ tag:Tag) -> Bool {
        for tagItem in dataSource {
            if tag.titleLabel!.text!.caseInsensitiveCompare((tagItem.titleLabel!.text)!) == ComparisonResult.orderedSame {
                self.userDidEnterInvalidTag?(tag)
                return false
            }
        }
        
        return true
    }
    
    

}




class FakeDataSource: NSObject {
    
    func tagsFourToFiveStars() -> [Tag] {
        let topic = Tag()
        topic.setTitle("Topic", for: .normal)
        let facts = Tag()
        facts.setTitle("Facts", for: .normal)
        let layout = Tag()
        layout.setTitle("Layout", for: .normal)
        let images = Tag()
        images.setTitle("Images", for: .normal)
        let authorSource = Tag()
        authorSource.setTitle("Author Source", for: .normal)
        
       
        return [topic,facts,layout,images,authorSource]
    }
    
    
    func tagsOneToThreeStars() -> [Tag] {
        let topic = Tag()
        topic.setTitle("Topic", for: .normal)
        let tone = Tag()
        tone.setTitle("Tone", for: .normal)
        let images = Tag()
        images.setTitle("Images", for: .normal)
        
        
        return [topic,images,tone]
    }
    
    
    
    func tagsYourOpinion() -> [Tag] {
        
        let controversial = Tag()
        let misleading = Tag()
        let confusing = Tag()
        let irrelevant = Tag()
        let informative = Tag()
        let fresnPerspective = Tag()
        
        controversial.setTitle("Controversial", for: .normal)
        misleading.setTitle("Misleading", for: .normal)
        confusing.setTitle("Confusing", for: .normal)
        irrelevant.setTitle("Irrelevant", for: .normal)
        informative.setTitle("Informative", for: .normal)
        fresnPerspective.setTitle("Fresh Perspective", for: .normal)
        
        
        return [controversial, misleading,confusing,irrelevant,informative,fresnPerspective]
    }
    
    func tagsWhatElseWouldYouLike() -> [Tag] {
        
        let fashion = Tag()
        let sport = Tag()
        let news = Tag()
        let fitness = Tag()
        let shoppingIdeas = Tag()
        let cooking = Tag()
        let exclusiveDeals = Tag()
        let localOffers = Tag()
        let products = Tag()
        
        fashion.setTitle("Fashion", for: .normal)
        sport.setTitle("Sports", for: .normal)
        news.setTitle("News", for: .normal)
        fitness.setTitle("Fitness", for: .normal)
        shoppingIdeas.setTitle("Shopping Ideas", for: .normal)
        cooking.setTitle("Cooking", for: .normal)
        exclusiveDeals.setTitle("Exclusive Ideas", for: .normal)
        localOffers.setTitle("Local Offers", for: .normal)
        products.setTitle("Products", for: .normal)
        
        
        return [fashion,sport,news,fitness,shoppingIdeas,cooking,exclusiveDeals,localOffers,products]
    }
    
}
