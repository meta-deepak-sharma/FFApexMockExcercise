@IsTest
private class TestRoomSelector {

    @isTest
    private static void testSelectRoomById() {
        // insert contact
        Contact cnt = new Contact();
        cnt.LastName = 'Test Contact';
        insert cnt;
        // insert Room for selection
        Room__c room = new Room__c();
        room.Name = 'Test Room';
		room.Guest__c = cnt.Id;
        room.Occupied__c = true;
		insert room;
        
        List<Room__c> rooms = 
			new RoomSelector().selectById(new Set<Id> { room.Id });
        System.assertEquals('Test Room', rooms[0].Name);		
	 	System.assertEquals(true, rooms[0].Occupied__c);		
		System.assertEquals(cnt.Id, rooms[0].Guest__c);		
     
    }
    
}