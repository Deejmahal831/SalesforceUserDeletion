global class MonthlyCleanup implements Schedulable {
    global void execute(SchedulableContext sc) {
        List<User> usersToDeactivate = [
            SELECT Id FROM User 
            WHERE IsActive = true AND LastLoginDate < LAST_N_DAYS:31
        ];

        for (User user : usersToDeactivate) {
            user.IsActive = false;
        }

        if (!usersToDeactivate.isEmpty()) {
            update usersToDeactivate;
        }
    }
}
