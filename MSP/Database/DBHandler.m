//
//  DBHandler.m
//  MSP
//
//  Created by Pro Retina on 8/23/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "DBHandler.h"

@implementation DBHandler


+ (void) saveInfo: (NSDictionary*)data {
    
    [self deleteData];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    //NSManagedObject *object;
    NSString *tableName;
    
    NSArray *formArray = data[@"FORM"];
    
    for (NSDictionary *element in formArray ) {
        NSString *val = @"";
        NSArray *values = [element allKeys];
        
        if ([values count] != 0)
            val = [values objectAtIndex:0];
        
        if ([val isEqualToString:@"INC"]) {
            tableName = @"Incidente";
        }
        else if ([val isEqualToString:@"SOLI"]) {
            tableName = @"Solicitud";
        }
        else if ([val isEqualToString:@"QUEJ"]) {
            tableName = @"Queja";
        }
        else if ([val isEqualToString:@"CON"]) {
            tableName = @"Consejo";
        }
        else if ([val isEqualToString:@"INF"]) {
            tableName = @"Informacion";
        }
        else if ([val isEqualToString:@"GEN"]) {
            tableName = @"Genero";
        }
        else if ([val isEqualToString:@"DISC"]) {
            tableName = @"Discriminacion";
        }
        
        if([val isEqualToString:@"INC"]  || [val isEqualToString:@"SOLI"] || [val isEqualToString:@"QUEJ"] || [val isEqualToString:@"CON"] || [val isEqualToString:@"INF"]) {
        
            NSArray *rowsArray = element[val];
            
            for (NSDictionary *dict in rowsArray)  {
                
                NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:tableName
                                                       inManagedObjectContext:context];
            
                [object setValue:dict[@"DES"] forKey:@"descripcion"];
                [object setValue:dict[@"IMG"] forKey:@"imagen"];
                [object setValue:dict[@"COD"] forKey:@"codigo"];
                [object setValue:dict[@"ID"] forKey:@"id"];
                [object setValue:dict[@"ANON"] forKey:@"anonimo"];
                [object setValue:dict[@"NOM"] forKey:@"nombre"];
            
            }
        }
        else if([val isEqualToString:@"GEN"] || [val isEqualToString:@"DISC"]) {
            
            NSArray *rowsArray = element[val];
            
            for (NSDictionary *dict in rowsArray)  {
                
                NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:context];
                
                [object setValue:dict[@"DES"] forKey:@"descripcion"];
                [object setValue:dict[@"COD"] forKey:@"codigo"];
                [object setValue:dict[@"ID"] forKey:@"id"];
                [object setValue:dict[@"ANON"] forKey:@"anonimo"];
                [object setValue:dict[@"NOM"] forKey:@"nombre"];
                
            }
        }
        
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
    
}

+ (void) deleteData
{
    NSArray *tablesArray = [NSArray arrayWithObjects:@"Incidente",@"Solicitud",@"Queja",@"Consejo",@"Informacion",@"Genero",@"Discriminacion", nil];
    NSLog(@"Delete all Data");
    
    
    //AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    for(int i = 0;i<tablesArray.count;i++) {
        [self deleteTable:tablesArray[i]];
    }
    
}

+ (void) deleteTable:(NSString*)table
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:table];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [context deleteObject:object];
    }
    
    error = nil;
    [context save:&error];
    
}



+ (void) saveDates: (NSDictionary*)data {
    
    [self deleteTable:@"FechaActualizacion"];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    //NSManagedObject *object;
    NSString *tableName = @"FechaActualizacion";
    
    NSArray *fechasArray = data[@"FECHAS"];
    
    for (NSDictionary *element in fechasArray ) {
        
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:context];
                
        [object setValue:element[@"DES"] forKey:@"fecha"];
        [object setValue:element[@"COD"] forKey:@"seccion"];
        [object setValue:element[@"ID"] forKey:@"id"];
        
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
    
}





+ (void) saveDelegaciones: (NSDictionary*)data {
    
    [self deleteTable:@"Delegacion"];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    NSString *tableName = @"Delegacion";
    NSArray *fechasArray = data[@"DEL"];
    
    for (NSDictionary *element in fechasArray ) {
        
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:context];
        
        
        
        [object setValue:element[@"COD"] forKey:@"codigo"];
        [object setValue:element[@"DES"] forKey:@"descripcion"];
        
        if (element[@"IMG"] && [element[@"IMG"] isKindOfClass:[NSString class]] ) {
            [object setValue:element[@"IMG"] forKey:@"imagen"];
        }
        [object setValue:element[@"LAT"] forKey:@"latitud"];
        [object setValue:element[@"LONG"] forKey:@"longitud"];
        [object setValue:element[@"NOM"] forKey:@"nombre"];
        
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
    
}


+ (void) saveSolicitudes: (NSDictionary*)data {
    
    [self saveConsejosSolicitud:data table:@"SolicitudDetalle"];
}


+ (void) saveConsejos: (NSDictionary*)data {
    [self saveConsejosSolicitud:data table:@"ConsejoDetalle"];
}



+ (void) saveConsejosSolicitud: (NSDictionary*)data table:(NSString*)tableName {
    [self deleteTable:tableName];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    NSArray *detalles = data[@"DETALLE"];
    
    for (NSDictionary *element in detalles ) {
        
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:context];
        
        [object setValue:element[@"TIP"] forKey:@"tipo"];
        
        NSArray *info = [element objectForKey:@"INFO"];
        NSString *text = @"";
        
        for (NSDictionary *infoDict in info) {
            
            NSString *titulo = infoDict[@"TIT"];
            NSString *descripcion = infoDict[@"DESC"];
            
            text = [NSString stringWithFormat:@"%@%@\n\n%@\n\n\n",text,titulo,descripcion];
        }
        
        [object setValue:text forKey:@"descripcion"];
        
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
}




+ (void) saveReportePorEnviar: (NSDictionary*)data imageData:(NSData*)imageData type:(NSString*)type reporteID:(int)reporteID {
    //[self deleteTable:@"ReportePorEnviar"];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"ReportePorEnviar" inManagedObjectContext:context];
        
    [object setValue:type forKey:@"tipo"];
    NSData *dictionaryData = [NSKeyedArchiver archivedDataWithRootObject:data];
    [object setValue:dictionaryData forKey:@"data"];
    [object setValue:[NSNumber numberWithInt:reporteID] forKey:@"id"];
    [object setValue:imageData forKey:@"imagen"];
    
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
}


+ (void) deleteReportePorEnviar:(int)reporte
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ReportePorEnviar"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id == %d",reporte]];
    //[fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [context deleteObject:object];
    }
    
    error = nil;
    [context save:&error];
    
}


+ (NSArray*) getDelegacionesForIDs: (NSArray*)myIds {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Delegacion" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSString *predic = @"";
    for (NSDictionary *dic in myIds) {
        predic = [NSString stringWithFormat:@"%@codigo == %@ or ",predic, dic[@"CD"]];
    }
    predic = [predic substringToIndex:[predic length] - 4];
    
    [request setPredicate:[NSPredicate predicateWithFormat:predic]];
    
    NSError *errorFetch = nil;
    NSArray *array = [context executeFetchRequest:request error:&errorFetch];
    
    return array;
    
    
}


+ (NSString*) getFechaForID: (NSString*)myId {
    
    NSString *result = @"";
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FechaActualizacion" inManagedObjectContext:context];
    
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"id == %@",myId]];
    
    NSError *errorFetch = nil;
    NSArray *array = [context executeFetchRequest:request error:&errorFetch];
    
    if(array && [array count] > 0) {
        result = [array[0] valueForKeyPath:@"fecha"];
    }
    
    return result;
    
}




+ (NSArray *) getCategoriesReportar {
    
    return [self getTableData:@"Incidente"];
    
}

+ (NSArray *) getCategoriesSolicitudes {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Solicitud" inManagedObjectContext:context];
    
    // sorts alphabetically by name
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"id"
                                                                     ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    [request setEntity:entity];
    
    NSError *errorFetch = nil;
    NSArray *array = [context executeFetchRequest:request error:&errorFetch];
    
    return array;
}

+ (NSArray *) getCategoriesQuejas {
    
    return [self getTableData:@"Queja"];
}

+ (NSArray *) getCategoriesConsejos {
    
    return [self getTableData:@"Consejo"];
    
}

+ (NSArray *) getSolicitudesDetalle {
    
    return [self getTableData:@"SolicitudDetalle"];
}

+ (NSArray *) getConsejosDetalle {
    
    return [self getTableData:@"ConsejoDetalle"];
}

+ (NSArray *) getCategoriesInformacion {
    
    return [self getTableData:@"Informacion"];
    
}

+ (NSArray *) getGeneros {
    
    return [self getTableData:@"Genero"];
}

+ (NSArray *) getDiscriminaciones {
    
    return [self getTableData:@"Discriminacion"];
    
}

+ (NSArray *) getDelegaciones {
    
    return [self getTableData:@"Delegacion"];
    
}

+ (NSArray *) getReportesPorEnviar {
    
    return [self getTableData:@"ReportePorEnviar"];
    
}


+ (NSArray *) getTableData:(NSString*)tableName {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:context];
    [request setEntity:entity];
    
    if (![tableName isEqualToString:@"Delegacion"] && ![tableName isEqualToString:@"SolicitudDetalle"] && ![tableName isEqualToString:@"ConsejoDetalle"]) {
        // sorts alphabetically by name
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"id"
                                                                         ascending:YES];
        [request setSortDescriptors:@[sortDescriptor]];
    }
    else if ([tableName isEqualToString:@"Delegacion"]) {
        // sorts alphabetically by name
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"nombre"
                                                                         ascending:YES];
        [request setSortDescriptors:@[sortDescriptor]];
    }
    
    NSError *errorFetch = nil;
    NSArray *array = [context executeFetchRequest:request error:&errorFetch];
    
    return array;
}


@end
