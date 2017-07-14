public class RoomSelector extends fflib_SObjectSelector implements IRoomSelector {
    
    public static IRoomSelector newInstance()
	{
		return (IRoomSelector) Application.Selector.newInstance(Room__c.SObjectType);
	}
    
    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField> {
            Room__c.Id,
                Room__c.Name,
                Room__c.Guest__c,
                Room__c.Occupied__c
                };
                    }
    
    public Schema.SObjectType getSObjectType()
    {
        return Room__c.sObjectType;
    }
    
    
    public List<Room__c>  selectById(Set<Id> roomsIdSet) {
        return (List<Room__c>) selectSObjectsById(roomsIdSet);
    }
}