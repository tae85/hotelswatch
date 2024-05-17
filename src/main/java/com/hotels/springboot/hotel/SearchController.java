package com.hotels.springboot.hotel;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hotels.springboot.jdbc.MemberDTO;
import com.hotels.springboot.map.GeoCoding;
import com.hotels.springboot.map.ISearchRadius;
import com.hotels.springboot.map.MapController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import utils.PagingUtil;

@Controller
public class SearchController {
	@Autowired
	SearchService searchService;
	@Autowired
	ISearchRadius sr;
	
	@Value("#{myprops['my.pageSize']}")
	private String myPageSize;
	@Value("#{myprops['my.blockPage']}")
	private String myBlockPage;
	
	//검색페이지 이동
	@GetMapping("/hotelList.do")
	public String hotelList(Model model, HttpServletRequest req, SearchDTO searchDTO) {
		HttpSession session = req.getSession();
		DateTimeFormatter fm = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d1 = null, d2 = null;
		
		String checkindate = searchDTO.getCheckin();
		String checkoutdate = searchDTO.getCheckout();
		try {
			d1 = sdf.parse(checkindate);
			d2 = sdf.parse(checkoutdate);
		} 
		catch(ParseException e) {
			e.printStackTrace();
		}
		
		long diff = d2.getTime() - d1.getTime();
		long min = (diff / (24*60*60*1000L));
		
		if(searchDTO.getRoom_cnt() == "") {
			searchDTO.setRoom_cnt("1");
		}
		
		session.setAttribute("min", min);
		session.setAttribute("checkin", searchDTO.getCheckin());
		session.setAttribute("checkout", searchDTO.getCheckout());
		session.setAttribute("room_cnt", searchDTO.getRoom_cnt());
		String searchWord = searchDTO.getSearchWord();
		Map<String, String> ret = GeoCoding.getGeoDataByAddress(searchWord);
		int distance = 100;
		double latTxt;
		double lngTxt;
		try {
			if(searchWord == null) {
				latTxt = 37.55998;
				lngTxt = 126.9858295;
			}
			else {
				latTxt = Double.parseDouble(ret.get("lat"));
				lngTxt = Double.parseDouble(ret.get("lng"));
			}
			int numberPerPage = 20;
			int resultCount = sr.searchCount(distance, latTxt, lngTxt);
			//model.addAttribute("resultCount", " / 검색결과 : " + resultCount + "건");
			//model.addAttribute("selectNum", Math.ceil(resultCount/numberPerPage));
			int pageNum = 1;
			int start = ((pageNum - 1) * numberPerPage) + 1;
			int end = pageNum * numberPerPage;
			
			ArrayList<HotelDTO> searchLists = null;
			if(distance != 0) {
				searchLists = sr.searchRadius(distance, latTxt, lngTxt, start, end, searchWord);
			}
			model.addAttribute("apiKey", MapController.apiKey);
			model.addAttribute("latTxt", latTxt);
			model.addAttribute("lngTxt", lngTxt);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchLists", searchLists);
		}
		catch(Exception e) {
			e.printStackTrace();
			return "hotel/search";
		}
		
		return "hotel/search";
	}
	
	//검색페이지 이동 후 호텔 리스트 출력(ajax)
	@GetMapping("/searchHotel.do")
	@ResponseBody
	public List<HotelDTO> searchHotel(Model model, HttpServletRequest req,
			SearchDTO searchDTO) {
		Map<String, String> ret = GeoCoding.getGeoDataByAddress(searchDTO.getSearchWord());
		searchDTO.setHt_lat(Double.parseDouble(ret.get("lat")));
		searchDTO.setHt_lng(Double.parseDouble(ret.get("lng")));
		ArrayList<HotelDTO> hotelLists = searchService.hotelList(searchDTO);
		model.addAttribute("lists", hotelLists);
		return hotelLists;
	}
	
	@RequestMapping("/totalHotel.do")
	@ResponseBody
	public int totalHotel(Model model, HttpServletRequest req,
			SearchDTO searchDTO) {
		int total = searchService.totalHotel(searchDTO);
		return total;
	}
	
	//검색어 저장
	@RequestMapping("/updateKeyword.do")
	@ResponseBody
	public void updateKeyword(@RequestParam("search_keyword") String search_keyword,
			@RequestParam("idx") String idx) {
		searchService.updateKeyword(search_keyword, idx);
	}
	
	//상세보기 - 호텔 정보
	@RequestMapping("/viewHotel.do")
	public String viewHotel(Model model, HttpServletRequest req, HotelDTO hotelDTO,
			 @RequestParam("hotel_idx") int hotel_idx, @RequestParam("index") int index) {
		HttpSession session = req.getSession();
		HotelDTO ht = searchService.viewHotel(hotel_idx);
		Double grade;
		if(searchService.hotelGrade(hotel_idx) != null) {
			grade = Math.round(searchService.hotelGrade(hotel_idx) * 10) / 10.0 ;
		}
		else {
			grade = 0.0;
		}
		
		String hotel_idx_rest = Integer.toString(hotel_idx);
		session.setAttribute("hotel_idx_rest", hotel_idx_rest);
		model.addAttribute("no", hotel_idx);
		model.addAttribute("ht", ht);
		model.addAttribute("grade", grade);
		model.addAttribute("index", index);
		return "hotel/view";
	}
	
	//상세보기 - 객실 정보(ajax)
	@RequestMapping("/viewRoom.do")
	@ResponseBody
	public List<HotelDTO> viewRoom(Model model, HttpServletRequest req,
			HotelDTO hotelDTO, @RequestParam("hotel_idx") int hotel_idx) {
//		String myPageSize = "10";
//		String myBlockPage = "5";
		//게시물 레코드를 DTO에 저장한 후 반환한다.
		model.addAttribute("apiKey", MapController.apiKey);
		
		hotelDTO.setHotel_idx(hotel_idx);
		ArrayList<HotelDTO> roomLists = searchService.viewRoom(hotelDTO);
		model.addAttribute("lists", roomLists);
		return roomLists;
	}
	
	@RequestMapping("/room.do")
	public String room(Model model, @RequestParam("hotel_idx") int hotel_idx) {
		HotelDTO ht = searchService.viewHotel(hotel_idx);
		ArrayList<HotelDTO> roomLists = searchService.selectHotel(hotel_idx);
		Double grade;
		if(searchService.hotelGrade(hotel_idx) != null) {
			grade = Math.round(searchService.hotelGrade(hotel_idx) * 10) / 10.0 ;
		}
		else {
			grade = 0.0;
		}
		
		model.addAttribute("ht", ht);
		model.addAttribute("roomLists", roomLists);
		model.addAttribute("no", hotel_idx);
		model.addAttribute("grade", grade);
		return "hotel/room";
	}
	
	@RequestMapping("/order.do")
	public String order(Model model, @RequestParam("hotel_idx") int hotel_idx, HttpSession session) {
		
//	    if (session == null || session.getAttribute("member") == null) {
//	        // 세션 없거나 세션에 member 객체가 없다면 로그인페이지 띄움.
//	        return "redirect:/login";  // 
//	    }
		
		HotelDTO ht = searchService.viewHotel(hotel_idx);
		HotelDTO room = searchService.selectRoom(hotel_idx);
		Double grade;
		if(searchService.hotelGrade(hotel_idx) != null) {
			grade = Math.round(searchService.hotelGrade(hotel_idx) * 10) / 10.0;
		}
		else {
			grade = 0.0;
		}
		
		model.addAttribute("ht", ht);
		model.addAttribute("room", room);
		model.addAttribute("no", hotel_idx);
		model.addAttribute("grade", grade);
		return "pay/order";
	}
}
