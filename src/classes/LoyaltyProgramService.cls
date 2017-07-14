global with sharing class LoyaltyProgramService  {
    
    private static ILoyaltyProgramService service()
	{
		return (ILoyaltyProgramService) Application.Service.newInstance(ILoyaltyProgramService.class);
	}
    
    
    public static Boolean isThisContactPartOfLoyaltyProgram(Id contactId ) {
        return service().isThisContactPartOfLoyaltyProgram(contactId);
    }
    
    public static void registerCheckInForContact( Id contactId ){
        service().registerCheckInForContact(contactId);
    }
    
}