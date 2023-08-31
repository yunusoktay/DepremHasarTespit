//
//  InfoViewController.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 19.06.2023.
//

import UIKit
import PhotosUI

class InfoViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var localityTextField: UITextField!
    @IBOutlet var administrativeAreaTextField: UITextField!
    @IBOutlet var subLocalityTextField: UITextField!
    
    @IBOutlet var addressTextView: UITextView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!

    var selectedImages: [UIImage] = []
    var subLocality: String?
    var locality: String?
    var administrativeArea: String?
    var address: String?
    
    let viewModel = InfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.applyCornerRadius(radius: 12)
        self.navigationItem.setHidesBackButton(true, animated: false)
        configureCollectionView()
        localityTextField.text = administrativeArea
        subLocalityTextField.text = subLocality
        administrativeAreaTextField.text = locality
        addressTextView.text = address
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "InfoCollectionViewCell", bundle: Bundle(for: InfoCollectionViewCell.self)), forCellWithReuseIdentifier: "InfoCollectionViewCell")
    }

    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        guard !results.isEmpty else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                if let error = error {
                    print("Hata yüklenirken: \(error.localizedDescription)")
                    return
                }
                
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.selectedImages.append(image)
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImages.append(image)
            collectionView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveTappedButton(_ sender: Any) {
        guard let title = titleTextField.text, let address = addressTextView.text, let locality = localityTextField.text, let subLocality = subLocalityTextField.text, let administrativeArea = administrativeAreaTextField.text else {
            return
        }
        
        viewModel.saveUserData(title: title, address: address, locality: locality, subLocality: subLocality, administrativeArea: administrativeArea, images: selectedImages) { success in
            if success {
                self.navigationController?.popViewController(animated: true)
            } else {
                print("dont saved user data")
            }
        }
    }
    
    
    @IBAction func libraryButton(_ sender: Any) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 10
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
}

extension InfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectedImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let select = selectedImages[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCell", for: indexPath)as! InfoCollectionViewCell
        cell.imageView.image = select
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
       }
}
