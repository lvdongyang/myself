//
//  Student+CoreDataProperties.h
//  NewTestPro
//
//  Created by 吕东阳 on 2018/10/24.
//  Copyright © 2018 吕东阳. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t studentId;
@property (nonatomic) int16_t studentClass;

@end

NS_ASSUME_NONNULL_END
