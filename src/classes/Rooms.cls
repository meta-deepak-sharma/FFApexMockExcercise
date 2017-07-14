public with sharing class Rooms extends fflib_SObjectDomain implements IRoom {
    
    
    private static final String ROOM_OCCUPIED_MESSAGE = 'Room is already Occupied.';
    private static final String INVALID_GUEST_OR_ROOM = 'Either room or invited guests are invalid. Validate guest list again before vacating the room.';
    
    
    public static IRoom newInstance(List<Room__c> sObjectList)
    {
        return (IRoom) Application.Domain.newInstance(sObjectList);
    }
    
    
    public Rooms(List<Room__c> records) {
        super(records);
    } 
    
    public override void onBeforeInsert() {
        roomOccupiedStatus();		
    }
    
    public override void onBeforeUpdate(Map<Id,SObject> existingRecords) {
        roomOccupiedStatus(existingRecords);
    } 
    
    public void roomOccupiedStatus() {
        for (Room__c record : (List<Room__c>)records) {
            // marked room as booked or not as per guest
            if (record.Guest__c <> null) {
                record.Occupied__c = true;
            } else {
                record.Occupied__c = false;
            }
        }
    }
    
    public void roomOccupiedStatus(Map<Id,SObject> existingRecords) {
        for (Room__c record : (List<Room__c>)records) {
            Room__c existingRoom = (Room__c) existingRecords.get(record.Id);
            // marked room as booked or not as per guest
            if (existingRoom.Guest__c <> null) {
                existingRoom.Occupied__c = true;
            } else {
                existingRoom.Occupied__c = false;
            }
        }
    }
    
    // checkIn method of domain with unit of work
    public void checkIn(Id roomId, Id contactId, fflib_ISObjectUnitOfWork uow) {
        // Opportunity lines to apply discount to
        Map<Id, Room__c> rooms = new map<Id,Room__c>((List<Room__c>) Records);
        Room__c room = rooms.get(roomId);
        if (room.Occupied__c == null || !room.Occupied__c) {
            room.Guest__c = contactId;
        }
        uow.registerDirty(room);
    }
    
    // checkout method of domain with unit of work
    public void checkOut(Id roomId, Id contactId, fflib_ISObjectUnitOfWork uow) {
        // Opportunity lines to apply discount to
        Map<Id, Room__c> rooms = new map<Id,Room__c>((List<Room__c>) Records);
        Room__c room = rooms.get(roomId);
        if (room.Occupied__c != null && room.Occupied__c) {
            room.Guest__c = null;
        }
        uow.registerDirty(room);
    }
    
    
    public class Constructor implements fflib_SObjectDomain.IConstructable
    {
        public fflib_SObjectDomain construct(List<SObject> sObjectList)
        {
            return new Rooms(sObjectList);
        }
    }	
    
}