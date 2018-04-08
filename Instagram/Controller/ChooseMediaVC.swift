//
//  ChooseMediaVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 3/4/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import AVKit

class ChooseMediaVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePickerController = UIImagePickerController();
    var selectedImage: UIImage?
    var selectedVideo: NSURL?
    var videoSelected: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Do any additional setup after loading the view.
        imagePickerController.delegate = self;
        imagePickerController.sourceType = .photoLibrary;
        imagePickerController.mediaTypes = ["public.image", "public.movie"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let mediaType = info[UIImagePickerControllerMediaType] as? String {
            if mediaType == "public.image" {
                print("Image selected");
                guard let theImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
                    fatalError("Expected a dictionary containing an image, but was provided the following: \(info)");
                }
                selectedImage = theImage;
                videoSelected = false;
            } else if mediaType == "public.movie" {
                print("Video selected");
                guard let theVideo = info[UIImagePickerControllerMediaURL] as? NSURL else {
                    fatalError("Expected a dictionary containing a url, but was provided the following: \(info)");
                }
                selectedVideo = theVideo;
                selectedImage = videoSnapshot(videoUrl: theVideo);
                videoSelected = true;
            }
        }
        dismiss(animated: true, completion: nil);
        self.performSegue(withIdentifier: "finishPickingSegue", sender: nil);
    }
    
    @IBAction func goToLibrary(_ sender: UIButton) {
        present(imagePickerController, animated: true, completion: nil);
    }
    
    func videoSnapshot(videoUrl: NSURL) -> UIImage? {
        let asset = AVURLAsset(url: videoUrl as URL);
        let generator = AVAssetImageGenerator(asset: asset);
        generator.appliesPreferredTrackTransform = true;
        let timeStamp = CMTime(seconds: 1, preferredTimescale: 60);
        do {
            let imageRef = try generator.copyCGImage(at: timeStamp, actualTime: nil);
            return UIImage(cgImage: imageRef)
        } catch let error as NSError {
            print("Image generation failed \(error)");
            return nil;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        switch segue.identifier ?? "" {
        case "finishPickingSegue":
            guard let confirmPostVC = segue.destination as? ConfirmPostVC else {
                fatalError("Unexpected destination \(segue.destination)");
            }
            
            confirmPostVC.image = selectedImage;
            if videoSelected == true {
                confirmPostVC.video = selectedVideo;
            } else {
                let url = NSURL(string: "urlstring");
                confirmPostVC.video = url;
            }
            
        default:
            fatalError("Unexpected segue identifier \(String(describing: segue.identifier))");
        }
    }
    
}







