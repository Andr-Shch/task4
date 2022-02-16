
global class butchInSched implements Schedulable {
    global void execute(SchedulableContext sc) {
        checkProcessed b = new checkProcessed(); 
        Database.executeBatch(b);
    }
}
