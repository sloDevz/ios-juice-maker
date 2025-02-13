//
//  EditStockVC.swift
//  JuiceMaker
//
//  Created by DONGWOOK SEO on 2023/01/06.
//

import UIKit

class EditStockVC: UIViewController {
    
    @IBOutlet var fruitStockLabels: [UILabel]!
    @IBOutlet var Steppers: [UIStepper]!
    @IBOutlet weak var editStockViewTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
    }
    
    private func setSteppersValues() {
        Steppers.forEach{
            guard let stepper = $0 as? FruitStockManagable,
                  let fruitStock = FruitStore.shared.fruits[stepper.fruitName]?.stock else { return }
            
            let changeStockIntToDouble = Double(fruitStock)
            
            $0.value = changeStockIntToDouble
        }
    }
    
    private func setConfigure() {
        editStockViewTitleLabel.text = "재고 추가"
        setFruitLabels()
        setSteppersValues()
    }
    
    private func setFruitLabels() {
        for fruitStockLabel in fruitStockLabels {
            guard let label = fruitStockLabel as? FruitStockManagable,
                  let fruitStock = FruitStore.shared.fruits[label.fruitName]?.stock else { return }
            
            let changeStockIntToString = String(fruitStock)
            
            fruitStockLabel.text = changeStockIntToString
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        for changedFruitStock in fruitStockLabels {
            guard let fruitStock = changedFruitStock as? FruitStockManagable,
                  let fruitStockLabel = changedFruitStock.text,
                  let changedFruitStock = Int(fruitStockLabel) else { return }
            
            FruitStore.shared.fruits[fruitStock.fruitName]?.stock = changedFruitStock
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        guard let tappedStepper = sender as? FruitStockManagable else { return }
        
        fruitStockLabels.forEach { label in
            guard let pairedLabel = label as? FruitStockManagable else { return }
            
            if pairedLabel.fruitName == tappedStepper.fruitName {
                label.text = String(Int(sender.value))
            }
        }
    }
}
