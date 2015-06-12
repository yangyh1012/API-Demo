//
//  TableViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/4.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /**
     处理UITableView顶部留白、空白的问题
     
     在代码中加入
     self.automaticallyAdjustsScrollViewInsets = NO;
     或者
     将View Controller属性中的adjust scroll view insets 去掉勾选。
     
     */
    
    /**
     *  去掉分割线
     */
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    /**
     *  添加背景图片
     */
    [[self tableView] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_sand.png"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*说明：设置表格节数
 
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

/*说明：设置表格每节行数
 
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

/*说明：设置每个单元格
 
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    /*说明：设置Cell的唯一标示符
     
     */
    static NSString *CellIdentifier = @"CellIdentifier";
    
    /*说明：创建Cell
     
     */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    /*说明：如果Cell不存在就创建
     
     UITableViewCellStyleDefault。该格式提供了一个简单的左对齐的文本标签textLabel和一个可选的图像imageView。如果显示图像，那么图像将在最左边。
     UITableViewCellStyleSubtitle。该格式与前一种相比，增加了对detailTextLabel的支持，该标签将会显示在textLabel标签的下面，字体相对较小。
     UITableViewCellStyleValue1。该格式居左显示textLabel，居右显示detailTextLabel，且字体较小。
     UITableViewCellStyleValue2。该格式居左现实一个小型蓝色主标签textLabel，在其右边显示一个小型黑色副标题详细标签detailTextLabel。
     
     */
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    /*说明：上面的几句话可以换成下面两句，不过
     它只能应用于iOS故事板中，并且在故事板中设计表视图单元格后，
     指定表视图单元格为动态的，Identifier属性设置为CellIdentifier。
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    */
    
    
    
    return cell;
}

/*说明：表头的重用
 
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *headerReuseIdentifier =@"TableViewSectionHeaderViewIdentifier";
    
    UITableViewHeaderFooterView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    
    if (!sectionHeaderView) {
        
        sectionHeaderView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerReuseIdentifier];
    }
    
    return sectionHeaderView;
}

#pragma mark - Table view delegate

/**
 *  点击详细按钮时触发的事件
 *
 *  @param tableView 表格
 *  @param indexPath 索引
 */
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    /**
     *  手动触发prepareForSegue方法
     */
    [self performSegueWithIdentifier:@"EditPlayer" sender:indexPath];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
