//
//  RootViewController.m
//  abc
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 CainiaoLiu. All rights reserved.
//

#import "RootViewController.h"
#import "GDataXMLNode.h"
#import "MapViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self prepareData];
   
    
    
}

-(void)prepareData{
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * plistPaht = [path stringByAppendingString:@"city.plist"];
    NSString * locpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * locplistPaht = [locpath stringByAppendingString:@"loc.plist"];
    self.myArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPaht];
    self.att = [[NSMutableArray alloc]initWithContentsOfFile:locplistPaht];
    if ([self.myArray count] > 10) {
        NSLog(@"有数据");
        return ;
    }
    
    NSLog(@"没有数据，需要网络请求");

    NSString * str = @"http://www.meituan.com/api/v1/divisions";
    NSURL * url = [NSURL URLWithString:str];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSData * data =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    GDataXMLElement * root = [doc  rootElement];
    GDataXMLElement * child = [[root children]objectAtIndex:0];

    NSInteger count = [[child children] count];

    self.myArray = [NSMutableArray array];
    self.att = [NSMutableArray array];
    for (int i = 0 ; i < count; i++) {
        GDataXMLElement * ele = [[child children]objectAtIndex:i];
        GDataXMLElement * childele = [[ele children]objectAtIndex:1];
        [self.myArray addObject:[childele stringValue]];
        
        
        
        GDataXMLElement * str = [[ele children]objectAtIndex:2];
//        GDataXMLElement * str1 = [[str children]objectAtIndex:3];
        
//        NSLog( @"%@",[str1 stringValue]);

        NSMutableArray * arr = [NSMutableArray array];
        [arr addObject:[[[str children]objectAtIndex:2] stringValue]];
        [arr addObject:[[[str children]objectAtIndex:3] stringValue]];

            [self.att addObject:arr];
        


    }
   
 
    [self.myArray writeToFile:plistPaht atomically:YES];

    [self.att writeToFile:locplistPaht atomically:YES];


    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.myArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.myArray[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MapViewController * mapV = [[MapViewController alloc]init];
    mapV.city = self.myArray[indexPath.row];
    mapV.att = self.att[indexPath.row];
    [self.navigationController pushViewController:mapV animated:YES];
    





}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
