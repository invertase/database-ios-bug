//
//  ViewController.m
//  database-bug
//
//  Created by Russell Wheatley on 28/12/2023.
//

#import "ViewController.h"
@import Firebase;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}
- (IBAction)writedata:(id)sender {
  // Reference to the Firebase Database
  FIRDatabaseReference *ref = [[FIRDatabase database] reference];

  // Data to be written
  NSDictionary *data = @{
      @"organizations": @[
          @{
              @"city": @"Lyon",
              @"country": @"France",
              @"data": @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h"],
              @"foo": @"bar",
              @"id": @0,
              @"name": @"my organization"
          }
      ]
  };

  // Write data to Firebase
  [ref setValue:data withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
      if (error) {
          NSLog(@"Data could not be saved: %@", error.localizedDescription);
      } else {
          NSLog(@"Data saved successfully.");
      }
  }];
}

- (IBAction)observe:(id)sender {
  // Reference to the Firebase Database
    FIRDatabaseReference *ref = [[[FIRDatabase database] reference] child:@"organizations/0"];

    // Observe for data changes
    [ref observeEventType:FIRDataEventTypeValue andPreviousSiblingKeyWithBlock:^(FIRDataSnapshot * _Nonnull snapshot, NSString * _Nullable prevKey) {
        if (snapshot.value != [NSNull null]) {  // Check if the snapshot is not null
            NSLog(@"Data: %@", snapshot.value);  // Log the data
        }
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);  // Log any errors
    }];
}

- (IBAction)getdata:(id)sender {
  // Reference to the Firebase Database at the specific path
     FIRDatabaseReference *ref = [[[FIRDatabase database] reference] child:@"organizations/0/data"];

     // Perform a get request to retrieve the data
     [ref getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nullable snapshot) {
         if (error) {
             NSLog(@"Error getting data: %@", error.localizedDescription);
         } else if (snapshot.exists) {
             NSLog(@"Received data: %@", snapshot.value);
         } else {
             NSLog(@"No data available");
         }
     }];
}

@end
