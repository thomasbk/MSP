//
//  DBHandler.h
//  MSP
//
//  Created by Pro Retina on 8/23/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DBHandler : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (void) saveInfo: (NSDictionary*)data;
+ (void) saveDates: (NSDictionary*)data;
+ (void) saveDelegaciones: (NSDictionary*)data;
+ (void) saveSolicitudes: (NSDictionary*)data;
+ (void) saveConsejos: (NSDictionary*)data;
+ (NSString*) getFechaForID: (NSString*)myId;
+ (NSArray *) getCategoriesReportar;
+ (NSArray *) getCategoriesSolicitudes;
+ (NSArray *) getCategoriesQuejas;
+ (NSArray *) getCategoriesConsejos;
+ (NSArray *) getCategoriesInformacion;
+ (NSArray *) getGeneros;
+ (NSArray *) getDiscriminaciones;
+ (NSArray *) getDelegaciones;
+ (NSArray *) getSolicitudesDetalle;
+ (NSArray *) getConsejosDetalle;

+ (NSArray*) getDelegacionesForIDs: (NSArray*)myId;

+ (void) saveReportePorEnviar: (NSDictionary*)data imageData:(NSData*)imageData type:(NSString*)type reporteID:(int)reporteID;
+ (NSArray *) getReportesPorEnviar;
+ (void) deleteReportePorEnviar:(int)reporte;

@end
