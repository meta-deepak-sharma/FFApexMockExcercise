public class RoomServiceImpl implements IRoomService {
    
    private static final String ROOM_OCCUPIED_MESSAGE = 'Room is already Occupied.';
    private static final String INVALID_GUEST_OR_ROOM = 'Either room or invited guests are invalid. Validate guest list again before vacating the room.';
    
    public void checkIn(Id roomId, Id guestId) {
        // Create unit of work to capture work and commit it under one transaction
        fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        List<Room__c> roomsList = RoomSelector.newInstance().selectById(new Set<Id>{roomId});
        if (roomsList.get(0).Occupied__c) {
            throw new RoomException(ROOM_OCCUPIED_MESSAGE);
        }
        
        IRoom domain = Rooms.newInstance(roomsList);
        domain.checkIn(roomId, guestId, uow);
        // Commit any room changes
        registerGuestWithLoyaltyService(guestId);
        uow.commitWork();	
    }
    
    public void checkOut(Id roomId, Id guestId) {
        // Create unit of work to capture work and commit it under one transaction
        fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        List<Room__c> roomsList = RoomSelector.newInstance().selectById(new Set<Id>{roomId});
        if (roomsList.get(0).Guest__c != guestId) {
            throw new RoomException(INVALID_GUEST_OR_ROOM);
        }
        IRoom domain = Rooms.newInstance(roomsList);
        domain.checkOut(roomId, guestId, uow);
        uow.commitWork();
    }
    
    
    public void registerGuestWithLoyaltyService(Id guestId) {
        if (LoyaltyProgramService.isThisContactPartOfLoyaltyProgram(guestId)) {
          	 LoyaltyProgramService.registerCheckInForContact(guestId);
        }
    }
    
    
}