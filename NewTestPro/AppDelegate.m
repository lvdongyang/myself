//
//  AppDelegate.m
//  NewTestPro
//
//  Created by 吕东阳 on 2018/10/8.
//  Copyright © 2018 吕东阳. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Student+CoreDataProperties.h"


#define adndfafafadfalfj @"sasa"
#define adnlfj           @"sadasfasa"
#define adnlfddsdsdsj    @"sasdsafsadfdfsafea"
#define fj               @"asa"


@interface AppDelegate ()

@property (nonatomic, readwrite, strong) NSManagedObjectModel         *managedObjectModel;

@property (nonatomic, readwrite, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, readwrite, strong) NSManagedObjectContext       *context;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self insertStrdents];
    
   
    [self fetchStudent];
    
    [self maopaopaixu];
  
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
//     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)maopaopaixu{
    //相邻元素之间比较，找出最大值活最小值，放在末位
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@12,@4,@24,@13,@65,@1,@0,@100,nil];
    int a = 0;
    for (int i = 0; i < arr.count - 1; i ++) {
        for (int j = 0; j < arr.count - 1 - i; j++) {
            a++;
            if ([arr[j] intValue] < [arr[j +1] intValue]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"a___%d",a);
}
-(void)xuanzepaixu{
    //拿第一位元素和其他所有元素相比，找出最大值活最小值，放在首位
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@12,@4,@24,@13,@65,@1,@0,@100,nil];
    int a = 0;

    for (int i = 0; i < arr.count - 1; i ++) {
        for (int j = i+1; j < arr.count ; j++) {
            a++;

            if ([arr[i] intValue] < [arr[j] intValue]) {
                [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    NSLog(@"a___%d",a);

}
#pragma mark - coreData
//查询数据or更改数据or删除数据
- (void)fetchStudent{
    //创建查询请求
    NSFetchRequest *fetchRequest     = [[NSFetchRequest alloc] init];

    //实体描述
    NSEntityDescription *entity      = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.context];

    //set实体描述
    [fetchRequest setEntity:entity];

    //模糊查询条件
    NSPredicate *name                = [NSPredicate predicateWithFormat:@"age > %d", 100];
    fetchRequest.predicate           = name;

    //排序条件
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"studentId" ascending:NO];
    //set查询条件
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    //执行查询请求，并返回查询结果
    NSError *error                   = nil;
    NSArray *fetchedObjects          = [self.context executeFetchRequest:fetchRequest error:&error];
    
    //输出查询结果
    for (Student *person in fetchedObjects ) {
        if (person.age == 555) {
            //删除符合条件的学生
            [self.context deleteObject:person];
        }
        else{
            NSLog(@"person.name___%@",person.name);
            NSLog(@"person.age___%d",person.age);
            NSLog(@"person.studentId___%d",person.studentId);
            //更改数据
//            person.age = 555;
        }
    }
    //保存
    [self.context save:nil];
}
//插入数据
- (void)insertStrdents{
    //实体描述
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.context];
    for (int i = 0;  i < 100;  i++) {
        //生成实体类1
        Student *student1     = [[Student alloc] initWithEntity:entity insertIntoManagedObjectContext:self.context];
        //属性赋值
        student1.name         = [NSString stringWithFormat:@"xiao_%d",i];
        student1.studentId    = 31200 + i;
        student1.age          = 20 +i;
        student1.studentClass = 312;
    }
    

    
    //存储
    NSError *error;
    [self.context save:&error];
    
    if (error) {
        NSLog(@"error___%@",error.description);
    }
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        // url 为CoreDataDemo.xcdatamodeld，注意扩展名为 momd，而不是 xcdatamodeld 类型
        NSURL *modelURL     = [[NSBundle mainBundle] URLForResource:@"NewTestPro" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
    }
    return _managedObjectModel;
    
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        // 创建 coordinator 需要传入 managedObjectModel
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        // 指定本地的 sqlite 数据库文件
        NSURL *sqliteURL            = [[self documentDirectoryURL] URLByAppendingPathComponent:@"NewTestPro.sqlite"];
        NSError *error;
        // 为 persistentStoreCoordinator 指定本地存储的类型，这里指定的是 SQLite
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteURL options:nil error:&error];
        if (error) {
            NSLog(@"falied to create persistentStoreCoordinator %@", error.localizedDescription);

        }

    }
    return _persistentStoreCoordinator;

}
- (NSManagedObjectContext *)context {
    if (!_context) {
        // 指定 context 的并发类型： NSMainQueueConcurrencyType 或 NSPrivateQueueConcurrencyType
        _context                            = [[NSManagedObjectContext alloc ] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = self.persistentStoreCoordinator;

    }
    return _context;

}
    

// 用来获取 document 目录
- (nullable NSURL *)documentDirectoryURL {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSLog(@"documentPath___%@",[paths firstObject]);
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;

}

- (void)adcdadsasdfasfdsfdfewfeferfref:(NSString *)abc
     qweffrferferfreferfqrfqfdftyhyhrg:(NSString *)qwe
       zxcrfqrfregrthytjhljgldjglwjgrg:(NSString *)zxc{
    
}


@end
