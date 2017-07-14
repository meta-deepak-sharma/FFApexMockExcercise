public interface IRoom extends fflib_ISObjectDomain {
    void roomOccupiedStatus();
    void roomOccupiedStatus(Map<Id,SObject> existingRecords);
    void checkIn(Id roomId, Id contactId, fflib_ISObjectUnitOfWork uow);
    void checkOut(Id roomId, Id contactId, fflib_ISObjectUnitOfWork uow);
}