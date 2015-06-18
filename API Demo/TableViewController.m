//
//  TableViewController.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/4.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *arrayOfSections;

@property (nonatomic, strong) NSMutableDictionary *dictionaryOfNumbers;

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
    
    /**
     
     移动cell和section
     
     */
    self.arrayOfSections = [[NSMutableArray alloc] init];
    NSMutableArray *section1 = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    NSMutableArray *section2 = [[NSMutableArray alloc] initWithObjects:@"4",@"5",@"6", nil];
    NSMutableArray *section3 = [[NSMutableArray alloc] initWithObjects:@"7",@"8",@"9", nil];
    [self.arrayOfSections addObject:section1];
    [self.arrayOfSections addObject:section2];
    [self.arrayOfSections addObject:section3];
    
    /**
     
     删除cell和section
     
     */
    self.dictionaryOfNumbers = [[NSMutableDictionary alloc] init];
    NSMutableArray *arrayOfEvenNumbers = [[NSMutableArray alloc] initWithObjects:
                                          [NSNumber numberWithUnsignedInteger:0],
                                          [NSNumber numberWithUnsignedInteger:2],
                                          [NSNumber numberWithUnsignedInteger:4],
                                          [NSNumber numberWithUnsignedInteger:6],
                                          nil];
    NSMutableArray *arrayOfOddNumbers = [[NSMutableArray alloc] initWithObjects:
                                         [NSNumber numberWithUnsignedInteger:1],
                                         [NSNumber numberWithUnsignedInteger:3],
                                         [NSNumber numberWithUnsignedInteger:5],
                                         [NSNumber numberWithUnsignedInteger:7],
                                         nil];
    [self.dictionaryOfNumbers setObject:arrayOfEvenNumbers
                                 forKey:SectionEvenNumbers];
    [self.dictionaryOfNumbers setObject:arrayOfOddNumbers
                                 forKey:SectionOddNumbers];
}

static NSString *SectionOddNumbers = @"Odd Numbers";
static NSString *SectionEvenNumbers = @"Even Numbers";

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  把单元格从section1移到section3
 */
- (void)moveSection1ToSection3 {
    
    NSMutableArray *section1 = [self.arrayOfSections objectAtIndex:0];
    [self.arrayOfSections removeObject:section1];
    [self.arrayOfSections addObject:section1];
    
    [self.tableView moveSection:0 toSection:2];
}

/**
 *  把section1中的单元格1移到到单元格2的位置
 */
- (void)moveCell1InSection1ToCell2InSection1 {
    
    NSMutableArray *section1 = [self.arrayOfSections objectAtIndex:0];
    NSString *cell1InSection1 = [section1 objectAtIndex:0];
    [section1 removeObject:cell1InSection1];
    [section1 insertObject:cell1InSection1 atIndex:1];
    
    NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    
    [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

/**
 *  把section1的单元格2移动到section2的单元格1的位置
 */
- (void)moveCell2InSection1ToCell1InSection2 {
    
    NSMutableArray *section1 = [self.arrayOfSections objectAtIndex:0];
    NSMutableArray *section2 = [self.arrayOfSections objectAtIndex:1];
    
    NSString *cell2InSection1 = [section1 objectAtIndex:1];
    [section1 removeObject:cell2InSection1];
    
    [section2 insertObject:cell2InSection1 atIndex:0];
    
    NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

/**
 *  删除section
 */
- (void)deleteOddNumbersSection:(id)paramSender {
    
    /* First remove the section from our data source */
    NSString *key = SectionOddNumbers;
    NSInteger indexForKey = [[self.dictionaryOfNumbers allKeys] indexOfObject:key];
    if (indexForKey == NSNotFound) {
        
        NSLog(@"Could not find the section in the data source.");
        return;
    }
    [self.dictionaryOfNumbers removeObjectForKey:key];
    
    /* Then delete the section from the table view */
    NSIndexSet *sectionToDelete = [NSIndexSet indexSetWithIndex:indexForKey];
    [self.tableView deleteSections:sectionToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
    
    /* Finally, remove the button from the navigation bar
     as it is not useful any longer */
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

/**
 *  删除cell
 */
- (void)deleteNumbersGreaterThan2:(id)paramSender {
    
    NSMutableArray *arrayOfIndexPathsToDelete = [[NSMutableArray alloc] init];
    NSMutableArray *arrayOfNumberObjectsToDelete = [[NSMutableArray alloc] init];
    
    /* Step 1: gather the objects we have to delete from our data source and their index paths */
    __block NSUInteger keyIndex = 0;
    [self.dictionaryOfNumbers enumerateKeysAndObjectsUsingBlock:
     ^(NSString *key, NSMutableArray *object, BOOL *stop) {
         
         [object enumerateObjectsUsingBlock:
          ^(NSNumber *number, NSUInteger numberIndex, BOOL *stop) {
              
              if ([number unsignedIntegerValue] > 2){
                  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:numberIndex
                                                              inSection:keyIndex];
                  [arrayOfIndexPathsToDelete addObject:indexPath];
                  [arrayOfNumberObjectsToDelete addObject:number];
              }
              
          }];
         
         keyIndex++;
     }];
    
    /* Step 2: delete the objects from the data source */
    if ([arrayOfNumberObjectsToDelete count] > 0){
        
        NSMutableArray *arrayOfOddNumbers = [self.dictionaryOfNumbers
                                             objectForKey:SectionOddNumbers];
        NSMutableArray *arrayOfEvenNumbers = [self.dictionaryOfNumbers
                                              objectForKey:SectionEvenNumbers];
        [arrayOfNumberObjectsToDelete enumerateObjectsUsingBlock:
         ^(NSNumber *numberToDelete, NSUInteger idx, BOOL *stop) {
             
             if ([arrayOfOddNumbers indexOfObject:numberToDelete] != NSNotFound){
                 [arrayOfOddNumbers removeObject:numberToDelete];
             }
             if ([arrayOfEvenNumbers indexOfObject:numberToDelete] != NSNotFound){
                 [arrayOfEvenNumbers removeObject:numberToDelete];
             }
         }];
    }
    
    /* Step 3: delete the cells that correspond to the objects */
    NSArray *arrayOfPaths = [[NSArray alloc]
                             initWithArray:arrayOfIndexPathsToDelete];
    [self.tableView deleteRowsAtIndexPaths:arrayOfPaths
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    
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
    
    /**
     *  缩进等级和缩进宽度相乘
     */
    cell.indentationLevel = indexPath.row;
    cell.indentationWidth = 10.0f;
    
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

/**
 *  页眉内容
 *
 *  @param tableView 表格
 *  @param section   节
 *
 *  @return 页眉内容
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 
    NSString *result = nil;
    
    if ([tableView isEqual:self.tableView] && section == 0){
        
        result = @"Section 1 Header";
    }
    
    return result;
}

/**
 *  页脚内容
 *
 *  @param tableView 表格
 *  @param section   节
 *
 *  @return 页脚内容
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    NSString *result = nil;
    
    if ([tableView isEqual:self.tableView] && section == 0){
        
        result = @"Section 1 Footer";
    }
    
    return result;
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
