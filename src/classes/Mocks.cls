@isTest
public class Mocks {
    
    public class RoomSelector extends fflib_SObjectMocks.SObjectSelector implements IRoomSelector
    {
        private fflib_ApexMocks mocks;
        
        public RoomSelector(fflib_ApexMocks mocks)
        {
            super(mocks);
            this.mocks = mocks;
        }
        
        public List<Room__c> selectById(Set<ID> idSet)
        {
            return (List<Room__c>) mocks.mockNonVoidMethod(this, 'selectById', new List<Type> {System.Type.forName('Set<Id>')}, new List<Object> {idSet});
        }
        
    }
    
    
    public class Rooms extends fflib_SObjectMocks.SObjectDomain implements IRoom
    {
        private fflib_ApexMocks mocks;
        
        public Rooms(fflib_ApexMocks mocks)
        {
            super(mocks);
            this.mocks = mocks;
        }

        public void roomOccupiedStatus()
        {
            mocks.mockVoidMethod(this, 'roomOccupiedStatus',  new List<Type>(), new List<Object>());
        }
        
        public void roomOccupiedStatus(Map<Id,SObject> existingRecords)
        {
            mocks.mockVoidMethod(this, 'roomOccupiedStatus',  new List<Type> { System.type.forName('Map<Id,SObject>')}, new List<Object> {existingRecords});
        }
        
        public void checkIn(Id roomId, Id contactId, fflib_ISObjectUnitOfWork uow)
        {
            mocks.mockVoidMethod(this, 'checkIn',  new List<Type>{Id.class, Id.class, fflib_ISObjectUnitOfWork.class}, new List<Object> {roomId, contactId, uow});
        }
        
        public void checkOut(Id roomId, Id contactId, fflib_ISObjectUnitOfWork uow)
        {
            mocks.mockVoidMethod(this, 'checkOut',  new List<Type>{Id.class, Id.class, fflib_ISObjectUnitOfWork.class}, new List<Object> {roomId, contactId, uow});
        }
    }
    
    
    
    public class RoomService implements IRoomService
    {
        private fflib_ApexMocks mocks;
        
        public RoomService(fflib_ApexMocks mocks)
        {
            this.mocks = mocks;
        }
        
        public void checkIn(Id roomId, Id contactId) {
            mocks.mockVoidMethod(this, 'checkIn', new List<Type> {Id.class, Id.class}, new List<Object> {roomId, contactId});
        }
        
        public void checkout (Id roomId, Id contactId) {
            mocks.mockVoidMethod(this, 'checkout', new List<Type>{Id.class, Id.class}, new List<Object> {roomId, contactId});
        }
        
        public Set<id> checkIn(Set<Id> guestsId) {
            return (Set<id>) mocks.mockNonVoidMethod(this, 'checkIn', new List<Type>{System.Type.forName('Set<Id>')}, new List<Object> {guestsId});
        }
    }
    
    public class LoyaltyProgramService implements ILoyaltyProgramService
    {
        private fflib_ApexMocks mocks;
        
        public LoyaltyProgramService(fflib_ApexMocks mocks)
        {
            this.mocks = mocks;
        }
        
        public Boolean isThisContactPartOfLoyaltyProgram(Id contactId ) {
            return (Boolean) mocks.mockNonVoidMethod(this, 'isThisContactPartOfLoyaltyProgram', new List<Type> {Id.class}, new List<Object>{contactId});
        }
        public void registerCheckInForContact( Id contactId ){
            mocks.mockVoidMethod(this, 'registerCheckInForContact', new List<Type> {Id.class}, new List<Object>{contactId});
        }
    }
    
}