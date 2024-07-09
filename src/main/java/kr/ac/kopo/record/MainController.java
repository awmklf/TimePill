package kr.ac.kopo.record;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.kopo.record.service.RecordService;
import kr.ac.kopo.record.service.RecordVO;
import kr.ac.kopo.schedule.service.ScheTimeService;
import kr.ac.kopo.schedule.service.ScheTimeVO;
import kr.ac.kopo.schedule.service.ScheduleService;
import kr.ac.kopo.user.UserVO;

@Controller
public class MainController{
		
	@Autowired
	private RecordService recordService;

		
	@GetMapping("/main")
	public String alarmList(RecordVO vo, Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		UserVO uvo = (UserVO) session.getAttribute("loginUser");
		String userId = uvo.getUserId();
				
		//vo로 받아온 파라미터 takeDate
		String takeDate = vo.getTakeDate();

		List<RecordVO> alarmList = recordService.selectAlarmList(takeDate, userId);
		
		model.addAttribute("alarmList", alarmList);

		return "common/main";
	}
	
	@PostMapping("/addlog.do")
	public String addLog(ScheTimeVO vo, Model model, HttpSession session) {
		
		//세션객체에 저장된 로그인 정보에서 id를 받아옴
		UserVO uvo = (UserVO) session.getAttribute("loginUser");
		String userId = uvo.getUserId();
		
		//ScheTimeVO를 통해 timeId 받아옴
		String timeId = vo.getTimeId();
		
		//디버깅로그
		System.out.println(timeId);
		
		//timeId, userId를 매개변수로 addTakeLog 실행
		int num = recordService.addTakeLog(timeId, userId);
		
		//디버깅로그
		System.out.println(num + "개의 takeLog 추가");
		
		
		return "redirect:/main";
		
	}

}