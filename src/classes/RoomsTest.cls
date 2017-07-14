@IsTest
private class RoomsTest {
  
    @IsTest
    private static void testRoomInsertMethodWithoutDML() { 
        Id testRoomId = fflib_IDGenerator.generate(Room__c.SObjectType);
        Id testGuestId = fflib_IDGenerator.generate(Contact.SObjectType);
        Room__c room = new Room__c(
                Id = testRoomId,
                Name = 'Test Room Book',
                Guest__c = testGuestId,
                Occupied__c = null);
		fflib_SObjectDomain.Test.Database.onInsert(new Room__c[] { room } );		
		fflib_SObjectDomain.triggerHandler(Rooms.class);
        // trigger update room occupied status
		System.assertEquals(room.Occupied__c, true); 		
    }
    
    @isTest
    private static void testRoomValidateMethodOnUpdate() { 
        Id testRoomId = fflib_IDGenerator.generate(Room__c.SObjectType);
        Id testGuestId = fflib_IDGenerator.generate(Contact.SObjectType);
        
        Room__c oldRoom = new Room__c(
                	Id = testRoomId,
            		Name = 'Test Room Book',
                	Guest__c = testGuestId);
		Room__c newRoom = new Room__c(
                	Id = testRoomId,
            		Guest__c = null);
        
        fflib_SObjectDomain.Test.Database.onUpdate(new Room__c[] { newRoom }, new Map<Id, SObject> { newRoom.Id => oldRoom } );		
       	fflib_SObjectDomain.triggerHandler(Rooms.class);
        // trigger update room occupied status
		System.assertEquals(newRoom.Occupied__c, false); 			
    }
    
}