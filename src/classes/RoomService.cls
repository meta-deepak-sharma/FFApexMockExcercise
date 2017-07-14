global with sharing class RoomService {

    public static void checkIn(Id roomId, Id contactId) {
     	 service().checkIn(roomId, contactId);
    }
    
    public static void checkOut(Id roomId, Id contactId) {
        service().checkOut(roomId, contactId);
    }
    

    private static IRoomService service()
	{
		return (IRoomService) Application.Service.newInstance(IRoomService.class);
	}
    
}