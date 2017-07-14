@IsTest
private class RoomServiceTest {
    
    @isTest
    private static void testCheckInExceptionCase() {
        // Create mocks
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IRoomSelector selectorMock = new Mocks.RoomSelector(mocks);
        // Given
        mocks.startStubbing();
        Id roomId = fflib_IDGenerator.generate(Room__c.SObjectType);
        List<Room__c> testRoomsList = new List<Room__c> {
            new Room__c(
                Id = roomId,
                Name = 'Test Opportunity',
                Guest__c = fflib_IDGenerator.generate(Contact.SObjectType),
                Occupied__c  = true)};
        Set<Id> testRoomsSet = new Map<Id, Room__c>(testRoomsList).keySet();
       	mocks.when(selectorMock.sObjectType()).thenReturn(Room__c.SObjectType);
	   	mocks.when(selectorMock.selectById(testRoomsSet)).thenReturn(testRoomsList);
        mocks.stopStubbing();
        Application.Selector.setMock(selectorMock);
        try {
           RoomService.checkIn(roomId, fflib_IDGenerator.generate(Contact.SObjectType));
           System.assert(false);
        } catch (Exception e) {
            System.assertEquals('Room is already Occupied.', e.getMessage());
        }
    }
   
    @isTest
    private static void testCheckInRoomBooked() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
		fflib_ISObjectUnitOfWork uowMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks);
		IRoom domainMock = new Mocks.Rooms(mocks);
		IRoomSelector selectorMock = new Mocks.RoomSelector(mocks);
       	Id roomId = fflib_IDGenerator.generate(Room__c.SObjectType);
        Id contactId = fflib_IDGenerator.generate(Contact.SObjectType);
        
        mocks.startStubbing();
		List<Room__c> testRoomsList = new List<Room__c> { 
			new Room__c(
				Id = roomId,
				Name = 'Test Room' ) };
        
       Set<Id> testRoomSet = new Map<Id, Room__c>(testRoomsList).keySet();
        mocks.when(domainMock.sObjectType()).thenReturn(Room__c.SObjectType);
		mocks.when(selectorMock.sObjectType()).thenReturn(Room__c.SObjectType);
		mocks.when(selectorMock.selectById(testRoomSet)).thenReturn(testRoomsList);
		mocks.stopStubbing();
        
        Application.UnitOfWork.setMock(uowMock);
		Application.Domain.setMock(domainMock);
		Application.Selector.setMock(selectorMock);
                    
        // booked a room here
        RoomService.checkIn(roomId, contactId);             
        // Then
		((IRoomSelector) 
			mocks.verify(selectorMock)).selectById(testRoomSet);
		((IRoom) 
			mocks.verify(domainMock)).checkIn(roomId, contactId, uowMock);
        
        ((fflib_ISObjectUnitOfWork)
       		 mocks.verify(uowMock, 0)).registerDirty(fflib_Match.sObjectWith(
            new Map<SObjectField, Object>{
                Room__c.Id => testRoomsList.get(0).Id,
                Room__c.Name => testRoomsList.get(0).Id,
                Room__c.Guest__c => contactId,
                Room__c.Occupied__c => true } ));
		((fflib_ISObjectUnitOfWork) 
			mocks.verify(uowMock, 1)).commitWork(); 
    } 
    
    
    @isTest
    private static void testCheckOutRoomGuestMismatchError() {
         // Create mocks
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IRoomSelector selectorMock = new Mocks.RoomSelector(mocks);
        // Given
        mocks.startStubbing();
        Id roomId = fflib_IDGenerator.generate(Room__c.SObjectType);
        List<Room__c> testRoomsList = new List<Room__c> {
            new Room__c(
                Id = roomId,
                Name = 'Test Opportunity',
                Guest__c = fflib_IDGenerator.generate(Contact.SObjectType),
                Occupied__c  = true)};
        Set<Id> testRoomsSet = new Map<Id, Room__c>(testRoomsList).keySet();
       	mocks.when(selectorMock.sObjectType()).thenReturn(Room__c.SObjectType);
	   	mocks.when(selectorMock.selectById(testRoomsSet)).thenReturn(testRoomsList);
        mocks.stopStubbing();
        Application.Selector.setMock(selectorMock);
        try {
           RoomService.checkOut(roomId, fflib_IDGenerator.generate(Contact.SObjectType));
           System.assert(false);
        } catch (Exception e) {
            System.assertEquals('Either room or invited guests are invalid. Validate guest list again before vacating the room.', e.getMessage());
        }
    }
    
    @isTest
    private static void testCheckOutRoomBooked() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
		fflib_ISObjectUnitOfWork uowMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks);
		IRoom domainMock = new Mocks.Rooms(mocks);
		IRoomSelector selectorMock = new Mocks.RoomSelector(mocks);
       	Id roomId = fflib_IDGenerator.generate(Room__c.SObjectType);
        Id contactId = fflib_IDGenerator.generate(Contact.SObjectType);
        
        mocks.startStubbing();
		List<Room__c> testRoomsList = new List<Room__c> { 
			new Room__c(
				Id = roomId,
                Guest__c = contactId,
				Name = 'Test Room',
            	Occupied__c = true) };
        
       Set<Id> testRoomSet = new Map<Id, Room__c>(testRoomsList).keySet();
        mocks.when(domainMock.sObjectType()).thenReturn(Room__c.SObjectType);
		mocks.when(selectorMock.sObjectType()).thenReturn(Room__c.SObjectType);
		mocks.when(selectorMock.selectById(testRoomSet)).thenReturn(testRoomsList);
		mocks.stopStubbing();
        
        Application.UnitOfWork.setMock(uowMock);
		Application.Domain.setMock(domainMock);
		Application.Selector.setMock(selectorMock);
                    
        // booked a room here
        RoomService.checkOut(roomId, contactId);             
        // Then
		((IRoomSelector) 
			mocks.verify(selectorMock)).selectById(testRoomSet);
		((IRoom) 
			mocks.verify(domainMock)).checkOut(roomId, contactId, uowMock);
        
        ((fflib_ISObjectUnitOfWork)
       		 mocks.verify(uowMock, 0)).registerDirty(fflib_Match.sObjectWith(
            new Map<SObjectField, Object>{
                Room__c.Id => testRoomsList.get(0).Id,
                Room__c.Name => testRoomsList.get(0).Id,
                Room__c.Guest__c => contactId,
                Room__c.Occupied__c => false } ));
		((fflib_ISObjectUnitOfWork) 
			mocks.verify(uowMock, 1)).commitWork(); 
    } 
    
    @isTest
    private static void testCheckInLoyaltyReward() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
		fflib_ISObjectUnitOfWork uowMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks);
		IRoom domainMock = new Mocks.Rooms(mocks);
		IRoomSelector selectorMock = new Mocks.RoomSelector(mocks);
        ILoyaltyProgramService serviceMock = new Mocks.LoyaltyProgramService(mocks);
       	Id roomId = fflib_IDGenerator.generate(Room__c.SObjectType);
        Id contactId = fflib_IDGenerator.generate(Contact.SObjectType);
        
        mocks.startStubbing();
		List<Room__c> testRoomsList = new List<Room__c> { 
			new Room__c(
				Id = roomId,
				Name = 'Test Room') };
        
       	Set<Id> testRoomSet = new Map<Id, Room__c>(testRoomsList).keySet();
        mocks.when(domainMock.sObjectType()).thenReturn(Room__c.SObjectType);
		mocks.when(selectorMock.sObjectType()).thenReturn(Room__c.SObjectType);
		mocks.when(selectorMock.selectById(testRoomSet)).thenReturn(testRoomsList);
        mocks.when(serviceMock.isThisContactPartOfLoyaltyProgram(contactId)).thenReturn(false); 
		mocks.stopStubbing();
        
        Application.UnitOfWork.setMock(uowMock);
		Application.Domain.setMock(domainMock);
		Application.Selector.setMock(selectorMock);
        Application.Service.setMock(ILoyaltyProgramService.class,  serviceMock);

        // booked a room here
        RoomService.checkIn(roomId, contactId);             
        // Then
		((IRoomSelector) 
			mocks.verify(selectorMock)).selectById(testRoomSet);
        
		((IRoom) 
			mocks.verify(domainMock)).checkIn(roomId, contactId, uowMock);
        
        ((ILoyaltyProgramService)
         	mocks.verify(serviceMock, 1)).isThisContactPartOfLoyaltyProgram(contactId);
        
        ((ILoyaltyProgramService)
         	mocks.verify(serviceMock, fflib_ApexMocks.NEVER)).registerCheckInForContact(contactId);

        ((fflib_ISObjectUnitOfWork)
       		 mocks.verify(uowMock, 0)).registerDirty(fflib_Match.sObjectWith(
            new Map<SObjectField, Object>{
                Room__c.Id => testRoomsList.get(0).Id,
                Room__c.Name => testRoomsList.get(0).Id,
                Room__c.Guest__c => contactId,
                Room__c.Occupied__c => true } ));
          
        ((fflib_ISObjectUnitOfWork) 
			mocks.verify(uowMock, 1)).commitWork(); 
    } 
    
}