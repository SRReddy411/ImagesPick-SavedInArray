//
//  ViewController.m
//  ImagePickedAndSaveInArray
//
//  Created by volive solutions on 15/09/18.
//  Copyright © 2018 volive solutions. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"

@interface ViewController (){
     UIImagePickerController *imgPicker;
    NSMutableArray *imagesArray;
    UIImage *imagePick;
}
@property (strong, nonatomic) IBOutlet UIButton *imageBtn;
@property (strong, nonatomic) IBOutlet UICollectionView *imageScrollCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    imagesArray = [[NSMutableArray alloc]init];
    self.imageScrollCollectionView.dataSource = self;
}

//MARK:- IMAGE BTN ACTION
- (IBAction)imageBtnAction:(id)sender {
    
    [self imageGalary];
}
-(void)imageGalary
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:nil
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* Camera = [UIAlertAction
                             actionWithTitle:@"Camera"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 NSLog(@"takePhoto");
                                 
                                 UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                 picker.delegate = self;
                                 picker.allowsEditing = YES;
                                 picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                 
                                 [self presentViewController:picker animated:YES completion:NULL];
                                 
                             }];
    
    UIAlertAction* Galary = [UIAlertAction
                             actionWithTitle:@"Gallery"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                 picker.delegate = self;
                                 picker.allowsEditing = YES;
                                 picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                 
                                 [self presentViewController:picker animated:YES completion:nil];
                                 
                             }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:Camera];
    [alert addAction:Galary];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
      [_imageBtn setBackgroundImage:chosenImage forState:UIControlStateNormal];
     [imagesArray addObject:chosenImage];
   
  NSLog(@"images array %@",imagesArray);
   // NSLog(@"images array %@",tempImageArray);
 
    //[_imageBtn setImage:chosenImage forState:UIControlStateNormal];
    [self.imageScrollCollectionView reloadData];
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
      ImageCollectionViewCell * cell = [self.imageScrollCollectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    cell.imageSView.image = [imagesArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imagesArray.count;
}


@end
