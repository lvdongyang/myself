//
//  Student+CoreDataProperties.m
//  NewTestPro
//
//  Created by 吕东阳 on 2018/10/24.
//  Copyright © 2018 吕东阳. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic age;
@dynamic name;
@dynamic studentId;
@dynamic studentClass;

@end
