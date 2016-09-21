//
//  XHSetPicViewController.m
//  XingHui
//
//  Created by wangpei on 15/8/8.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSetPicViewController.h"
#import "GKImagePicker.h"
@interface XHSetPicViewController ()<UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GKImagePickerDelegate,UIPopoverControllerDelegate>
{
    UIImageView *imageview;
 
}
@property (nonatomic, strong) GKImagePicker *imagePicker;
@property (nonatomic, strong) UIPopoverController *popoverController;
@end

@implementation XHSetPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)selectPicMode:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionSheet.tag=1;
    [actionSheet showInView:self.navigationController.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;
{
    if (actionSheet.tag==1) {
        if (buttonIndex == 0) {
            [self newPhoto];
        }
        else if (buttonIndex == 1) {
            [self existingPhoto];
        }
    }
    else
    {
        [self selectSheet:actionSheet index:buttonIndex];
        //[_sheetdelegate selectSheet:actionSheet index:buttonIndex];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
-(void)newPhoto {
    
//    self.imagePicker = [[GKImagePicker alloc] init];
//    self.imagePicker.cropSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH);
//    self.imagePicker.delegate = self;
//    self.imagePicker.resizeableCropArea = YES;
//    self.imagePicker.imagePickerController.sourceType =UIImagePickerControllerSourceTypeCamera;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
////        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self.imagePicker.imagePickerController];
////        [self.popoverController presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        
//    } else {
//        
//        [self presentViewController:self.imagePicker.imagePickerController animated:YES completion:nil];
//        
//    }

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        UIImagePickerController *imgpicker = [[UIImagePickerController alloc] init];
        imgpicker.delegate = self;
        imgpicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imgpicker.allowsEditing = YES;
        [self presentViewController:imgpicker animated:YES completion:nil];
    }
    else
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        UIPopoverController *popoverController=[[UIPopoverController alloc] initWithContentViewController:imagePickerController];
        popoverController.delegate=self;
        [popoverController presentPopoverFromRect:CGRectMake(0, 0, 100, 100) inView:[UIView new] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}
# pragma mark -
# pragma mark GKImagePicker Delegate Methods

- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image{
    
    
    [self didfinishSetImg:[self imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)]];
 
    [self hideImagePicker];
}

- (void)hideImagePicker{
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        
        [self.popoverController dismissPopoverAnimated:YES];
        
    } else {
        
        [self.imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
        
    }
}

# pragma mark -
# pragma mark UIImagePickerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    //self.imgView.image = image;
    
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        
        [self.popoverController dismissPopoverAnimated:YES];
        
    } else {
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
}

-(void)existingPhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imgpicker = [[UIImagePickerController alloc] init];
        imgpicker.delegate = self;
        imgpicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imgpicker.allowsEditing = YES;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"search_bg@3x.png"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
        [imgpicker.navigationBar  setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, [UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
        [self presentViewController:imgpicker animated:YES
                         completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    UIImage* picture = nil;
    
    if ([mediaType isEqualToString:@"public.image"]) {
        picture = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!picture)
            picture = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        if ([info objectForKey:@"UIImagePickerControllerReferenceURL"] == nil) {
            
          //  UIImageWriteToSavedPhotosAlbum (picture, nil, nil , nil);
        }
    }
 
 
    [self didfinishSetImg:[self imageWithImageSimple:picture scaledToSize:CGSizeMake(300, 300)]];
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//修发图片大小
- (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    newSize.height = image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
        ((UIImagePickerController *)navigationController).sourceType ==     UIImagePickerControllerSourceTypePhotoLibrary) {
       // [viewController.navigationItem setHidesBackButton:YES];
        
        [viewController.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    }
}

@end
