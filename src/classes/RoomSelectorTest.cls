@isTest
private class RoomSelectorTest {

    @isTest
    public static void selectByIdTest() {
        
        // Given
        fflib_ISObjectUnitOfWOrk uow = Application.UnitOfWork.newInstance();
        Room__c room = new Room__c();
        Contact con = new Contact();
        con.LastName = 'Test Contact';
		room.Name = 'Room 1';
        uow.registerNew(con);
        uow.registerNew(room, Room__c.Guest__c, con); 
		// When
        uow.commitWork();
        
        List<Room__c> rooms = RoomSelector.newInstance().selectById(new Set<Id>{room.Id});
        // Assert
        System.assertEquals(1, rooms.size());
		System.assertEquals('Room 1', rooms[0].Name);		
		System.assertEquals(true, rooms[0].Occupied__c);		
		System.assertEquals(con.Id, rooms[0].Guest__c);		
    }
}