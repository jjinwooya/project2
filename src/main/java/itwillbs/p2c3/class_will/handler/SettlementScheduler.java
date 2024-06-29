package itwillbs.p2c3.class_will.handler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

//import com.example.demo.service.SettlementService;

@Component
public class SettlementScheduler {

    @Autowired
//    private SettlementService settlementService;

    // 매월 1일 자정에 정산 작업을 수행하도록 스케줄링
    @Scheduled(cron = "0 0 0 1 * ?")
    public void scheduleMonthlySettlement() {
//        settlementService.performMonthlySettlement();
    }
}