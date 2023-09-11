global class MonthlyCleanup implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        List<User> users = [select id, name, lastlogindate from user where isactive = true and lastlogindate < last_n_days:31];

        List<User> noLogUsers = new List<User>();

        for(User u: users)
            {
                u.IsActive = false;
                noLogUsers.add(u);
            }
 
        update noLogUsers;
    }
}