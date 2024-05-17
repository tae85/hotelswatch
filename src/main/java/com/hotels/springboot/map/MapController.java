package com.hotels.springboot.map;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hotels.springboot.hotel.HotelDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MapController {
	
	@Autowired
	ISearchRadius sr;
	
	public static final String apiKey = "AIzaSyA5-DB9e6-Lsqr4KB8zDoW5lxRmSffl4u8";
	
	//삭제
	@GetMapping("/hotelMap.do")
	@ResponseBody
	public Map<String, String> hotelMap(Model model, HttpServletRequest req, 
			@RequestParam("searchWord") String searchWord) {
		model.addAttribute("apiKey", apiKey);
		Map<String, String> ret = GeoCoding.getGeoDataByAddress(searchWord);
		int distance = (req.getParameter("distance") == null) ?
				100 : Integer.parseInt(req.getParameter("distance"));
		double latTxt;
		double lngTxt;
		Map<String, String> test = new HashMap<>();
		try {
			if(searchWord == null) {
				latTxt = (req.getParameter("latTxt") == null) ?
						37.55998 : Double.parseDouble(req.getParameter("latTxt"));
				lngTxt = (req.getParameter("lngTxt") == null) ?
						126.9858295 : Double.parseDouble(req.getParameter("lngTxt"));
			}
			else {
				latTxt = Double.parseDouble(ret.get("lat"));
				lngTxt = Double.parseDouble(ret.get("lng"));
			}
			int numberPerPage = 50;
			int resultCount = sr.searchCount(distance, latTxt, lngTxt);
			model.addAttribute("resultCount", " / 검색결과 : " + resultCount + "건");	//필요 없을 듯
			model.addAttribute("selectNum", Math.ceil(resultCount/numberPerPage));
			int pageNum = (req.getParameter("pageNum")==null) ?
					1 : Integer.parseInt(req.getParameter("pageNum"));
			int start = ((pageNum - 1) * numberPerPage) + 1;
			int end = pageNum * numberPerPage;
			
			ArrayList<HotelDTO> searchLists = null;
			if(distance != 0) {
				searchLists = sr.searchRadius(distance, latTxt, lngTxt, start, end, searchWord);
				System.out.println("searchLists: " + searchLists);
			}
			
			test.put("latTxt", Double.toString(latTxt));
			test.put("lngTxt", Double.toString(lngTxt));
			test.put("searchWord", searchWord);
		}
		catch(Exception e) {
			e.printStackTrace();
			return test;
		}
		
		return test;
	}
}



















