package com.hotels.springboot.post;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import utils.MyFunctions;
import utils.PagingUtil;

@Controller
public class PostController {
	@Autowired
	PostService postService;
	
	@Value("#{myprops['my.pageSize']}")
	private String myPageSize;
	@Value("#{myprops['my.blockPage']}")
	private String myBlockPage;
	
	@RequestMapping("/postLists.do")
	public String postList(Model model, HttpServletRequest req,
			@RequestParam("route") String route, ParameterDTO parameterDTO) {
		int totalCount = 0;
		int pageSize = Integer.parseInt(myPageSize);
		int blockPage = Integer.parseInt(myBlockPage);
		int pageNum = (req.getParameter("pageNum") == null
				|| req.getParameter("pageNum").equals(""))
				? 1 : Integer.parseInt(req.getParameter("pageNum"));
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		parameterDTO.setStart(start);
		parameterDTO.setEnd(end);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("pageSize", pageSize);
		maps.put("pageNum", pageNum);
		model.addAttribute("maps", maps);
		
		String destination ="";
		if(route.equals("event")) {
			parameterDTO.setType("e");
			totalCount = postService.getTotalCount("e");
			ArrayList<PostDTO> eventLists = postService.postList(parameterDTO);
			model.addAttribute("eventLists", eventLists);
			destination = "eventList";
		}
		else {
			parameterDTO.setType("n");
			totalCount = postService.getTotalCount("n");
			ArrayList<PostDTO> noticeLists = postService.postList(parameterDTO);
			model.addAttribute("noticeLists", noticeLists);
			destination = "noticeList";
		}
		maps.put("totalCount", totalCount);
		String pagingImg = PagingUtil.pagingImg(totalCount, pageSize, 
				blockPage, pageNum, req.getContextPath() + "/postLists.do?route=" + route +"&");
		model.addAttribute("pagingImg", pagingImg);
		
		return "post/" + destination;
	}
	
	@GetMapping("/postWrite.do")
	public String postWrite() {
		return "post/postWrite";
	}
	@PostMapping("/postWriteProcess.do")
	public String postWriteProcess(HttpServletRequest req, Model model, MultipartHttpServletRequest msr,
			/*@Validated*/ PostDTO postDTO) {
		String route = "home";
		try {
			String uploadDir = ResourceUtils.getFile("classpath:static/uploads/")
					.toPath().toString();
			System.out.println("물리적경로:" + uploadDir);
			
			Map<String, String> saveFileMaps = new HashMap<>();
			
			String dbOthumb = "";
			String dbSthumb = "";
			String dbOfile = "";
			String dbSfile = "";
			Collection<Part> parts = req.getParts();
			int i = 0;
			for(Part part : parts) {
				if(!part.getName().equals("fileList"))
					continue;
				
				String partHeader = part.getHeader("content-disposition");
				String[] phArr = partHeader.split("filename=");
				String originalFileName = phArr[1].trim().replace("\"", "");
				if(!originalFileName.isEmpty()) {
					part.write(uploadDir + File.separator+originalFileName);
				}
				String savedFileName = MyFunctions.renameFile(uploadDir, originalFileName);
				saveFileMaps.put(originalFileName, savedFileName);
				if(i == 0) {
					dbOfile += originalFileName;
					dbSfile += savedFileName;
					i++;
				}
				else {
					dbOthumb += originalFileName;
					dbSthumb += savedFileName;
					i = 0;
				}
			}
			postDTO.setOthumb(dbOthumb);
			postDTO.setSthumb(dbSthumb);
			postDTO.setOfile(dbOfile);
			postDTO.setSfile(dbSfile);
			model.addAttribute("saveFileMaps", saveFileMaps);
			
			if(postDTO.getType().equals("n")) {
				route = "notice";
			}
			else {
				route = "event";
			}
			postService.postWrite(postDTO);
		} 
		catch (Exception e) {
			System.out.println("업로드 실패");
		}
		
		return "redirect:/postLists.do?route="+ route;
	}
	
	@RequestMapping("/postView.do")
	public String postView(Model model, PostDTO postDTO) {
		postDTO = postService.postView(postDTO);
//		postService.updateVisitcount(postDTO);
		
		postDTO.setContent(postDTO.getContent().replace("\r\n", "<br/>"));
		model.addAttribute("postDTO", postDTO);
		return "post/postView";
	}
	
	@GetMapping("/postEdit.do")
	public String postEditGet(Model model, PostDTO postDTO) {
		postDTO = postService.postView(postDTO);
		model.addAttribute("postDTO", postDTO);
		return "post/postEdit";
	}
	//수정2 : 입력한 내용으로 수정 처리
	@PostMapping("/postEdit.do")
	public String postEditPost(PostDTO postDTO) {
		if(postDTO.getOfile()==null) {
			postDTO.setOfile("");
			postDTO.setSfile("");
		}
		int result = postService.postEdit(postDTO);
		//수정 처리가 완료된 후 내용보기 페이지로 이동한다.
		return "redirect:postView.do?post_idx=" + postDTO.getPost_idx() 
			+ "&type=" + postDTO.getType();
	}
	
	//삭제
	@PostMapping("/postDelete.do")
	public String postDelete(HttpServletRequest req) {
		String type = req.getParameter("type");
		String route;
		int result = postService.postDelete(req.getParameter("post_idx"));
		if (type.equals("n")) {
			route = "notice";
		}
		else {
			route = "event";
		}
		return "redirect:postLists.do?route=" + route;
	}
}























