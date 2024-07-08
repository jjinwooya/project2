package itwillbs.p2c3.class_will.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import itwillbs.p2c3.class_will.service.AdminService;

@Configuration
@EnableScheduling
public class DailyVisitScheduler {
	
	@Autowired
	private AdminService adminService;
	
	@Scheduled(cron = "0 0 0 * * ?")
    public void deleteTableData() {
    	adminService.deleteVisitLogs();
    }
}
