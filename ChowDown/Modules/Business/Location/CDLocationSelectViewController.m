//
//  CDLocationSelectViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/9.
//

#import "CDLocationSelectViewController.h"
#import "CDNavigationBar.h"
#import <Masonry/Masonry.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <BlocksKit/UIGestureRecognizer+BlocksKit.h>
#import <BlocksKit/UIControl+BlocksKit.h>

@interface CDLocationSelectViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CDNavigationBar *navigationView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, assign) MKCoordinateRegion currentRegion;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) UITextField *currentAddressField;
@property (nonatomic, strong) CDLocationModel *selectedLocation;
@end

@implementation CDLocationSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
    [self checkLocatoinAuthorization];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)setupViews {
    [self setupMapView];
    [self setupNavigationView];
    [self setupConfirmButton];
    [self setupCurrentAddressField];
}

- (void)setupNavigationView {
    if (self.navigationView) {
        return;
    }
    self.navigationView = [[CDNavigationBar alloc] initWithTitle:nil];
    self.navigationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.top.left.mas_equalTo(0);
    }];
}

- (void)setupConfirmButton {
    if (self.confirmButton) {
        return;
    }
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
    self.confirmButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.confirmButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    WEAK_REF(self);
    [self.confirmButton bk_addEventHandler:^(id sender) {
        STRONG_REF(self);
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(self.navigationView.backButton);
        make.right.mas_offset(-20);
    }];
}

- (void)setupMapView {
    if (self.mapView) {
        return;
    }
    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    
    WEAK_REF(self);
    UITapGestureRecognizer *tapGesture = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        STRONG_REF(self);
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        [self selectMapCoordinate:coordinate];
    }];
    [self.mapView addGestureRecognizer:tapGesture];
}

- (void)setupCurrentAddressField {
    if (self.currentAddressField) {
        return;
    }
    self.currentAddressField = [[UITextField alloc] init];
    self.currentAddressField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    self.currentAddressField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.currentAddressField];
    
    [self.currentAddressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(25);
        make.right.mas_offset(-25);
        make.bottom.mas_offset(-([CDCommonUtils safeAreaInsets].bottom + 20));
        make.height.mas_equalTo(48);
    }];
}

- (void)selectMapCoordinate:(CLLocationCoordinate2D)coordinate {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] initWithCoordinate:coordinate];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:annotation];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    WEAK_REF(self);
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        STRONG_REF(self);
        if (!error) {
            CLPlacemark *placemark = placemarks.firstObject;
            CDLocationModel *model = [[CDLocationModel alloc] init];
            model.placemark = placemark;
            model.coordinate = placemark.location.coordinate;
            self.selectedLocation = model;
            self.currentAddressField.text = placemark.areasOfInterest.firstObject;
        }
    }];
}

#pragma mark - location

- (void)checkLocatoinAuthorization {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.delegate = self;
    if (manager.authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [manager requestWhenInUseAuthorization];
    } else if (manager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || manager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self updateCurrentLocationFromManager:manager];
    }
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    if (manager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        manager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self updateCurrentLocationFromManager:manager];
    }
}

- (void)updateCurrentLocationFromManager:(CLLocationManager *)manager {
    self.currentRegion = MKCoordinateRegionMake(manager.location.coordinate, MKCoordinateSpanMake(0.1, 0.1));
    self.mapView.region = self.currentRegion;
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

@end
