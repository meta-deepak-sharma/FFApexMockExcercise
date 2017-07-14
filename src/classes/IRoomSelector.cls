public interface IRoomSelector extends fflib_ISObjectSelector {
	List<Room__c> selectById(Set<Id> roomsId);
}