public interface IRoomService {
	void checkIn(Id roomId, Id guestId);
    void checkOut(Id roomId, Id guestId);
}