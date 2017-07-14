public class Application {
    // Configure and create the UnitOfWorkFactory for this Application
    public static final fflib_Application.UnitOfWorkFactory unitOfWork = 
        new fflib_Application.UnitOfWorkFactory(
            new List<sObjectType> { 
                	Contact.sObjectType,
                    Room__c.sObjectType 
                    });
    
     // Configure and create the ServiceFactory for this Application
    public static final fflib_Application.ServiceFactory Service = 
        new fflib_Application.ServiceFactory( 
            new Map<Type, Type> { IRoomService.class => RoomServiceImpl.class,
                ILoyaltyProgramService.class => LoyaltyProgramServiceImpl.class});
    
    // Configure and create the selectorFactory for this Application
    public static final fflib_Application.SelectorFactory Selector =
        new fflib_Application.SelectorFactory(
            new Map<SObjectType, Type> {
                Room__c.SObjectType => RoomSelector.class
                    });
    

   
    
    // Configure and create the DomainFactory for this Application
    public static final fflib_Application.DomainFactory Domain = 
        new fflib_Application.DomainFactory(
            Application.Selector,
            new Map<SObjectType, type> {
                Room__c.SobjectType => Rooms.Constructor.class
                    });
    
}