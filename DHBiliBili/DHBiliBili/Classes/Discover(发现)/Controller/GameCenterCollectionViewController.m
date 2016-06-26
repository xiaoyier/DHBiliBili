//
//  GameCenterCollectionViewController.m
//  BiliBiliDemo
//
//  Created by XDH on 16/4/23.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "GameCenterCollectionViewController.h"
#import "UIImageView+WebCache.h"
#import "GameCenterCellItem.h"
#import "GameCenterCollectionViewCell.h"
#import "WebViewController.h"

#define KScreenW = [UIScreen mai
@interface GameCenterCollectionViewController ()
@property (strong , nonatomic) NSMutableArray *itemsArray;

@end

@implementation GameCenterCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(NSMutableArray *)itemsArray {
    if (_itemsArray == nil) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}


-(instancetype)init {
    // 流水布局:用于控件创建
    UICollectionViewFlowLayout *layout = ({
        
        layout = [[UICollectionViewFlowLayout alloc] init];
        
        // 设置cell尺寸
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, 260);
        
        // 行间距
        layout.minimumLineSpacing = 20;
        
        // 设置滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout;
        
    });
    return [super initWithCollectionViewLayout:layout];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //重新显示导航条
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GameCenterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    //读取plist文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"game.plist" ofType:nil];
    
    NSDictionary *gameDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //取出字典数组
    NSArray *dictArr = gameDict[@"items"];
    
    //字典转模型
    for (NSDictionary *dict in dictArr) {
        GameCenterCellItem *item = [GameCenterCellItem gameItemWithDict:dict];
        [self.itemsArray addObject:item];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    //    //清空内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    //清空操作
    [[SDWebImageManager sharedManager] cancelAll];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GameCenterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 取出模型
    GameCenterCellItem *item = self.itemsArray[indexPath.item];
    
    cell.titleL.text = item.title;
    cell.summaryL.text = item.summary;
    NSURL *coverUrl = [NSURL URLWithString:item.cover];
    [cell.coverImageV sd_setImageWithURL:coverUrl placeholderImage:[UIImage imageNamed:@"videopic_default@2x"]];
    return cell;
}



#pragma mark <UICollectionViewDelegate>
//跳转控制器
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击控制器");
    //取出cell对应的模型,设置webView控制器的标题
    GameCenterCellItem *item =  self.itemsArray[indexPath.item];
    //创建webView控制器
    WebViewController *VC = [[WebViewController alloc] init];
    VC.title = item.download_link;
    [self.navigationController pushViewController:VC animated:YES];
   
}


@end
