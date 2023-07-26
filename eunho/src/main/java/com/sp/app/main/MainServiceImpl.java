package com.sp.app.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;

@Service("main.mainService")
public class MainServiceImpl implements MainService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager filemanager;
	
	@Override
	public void addCategory(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("main.addCategory", map);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<MainDomain> categoryList(Long memberNum) {
		List<MainDomain> list = null;
		
		try {
			list = dao.selectList("main.categoryList", memberNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void deleteCategory(Long categoryNum) throws Exception {
		try {
			dao.updateData("main.deleteCategory", categoryNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public MainDomain categoryInfo(Long categoryNum) {
		MainDomain dto = null;
		
		try {
			dto = dao.selectOne("main.categoryInfo", categoryNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public MainDomain startCategory(Long memberNum) {
		MainDomain dto = null;
		
		try {
			dto = dao.selectOne("main.startCategory", memberNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void writeArticle(MainDomain dto, String pathname) throws Exception {
		try {
			dao.insertData("main.writeArticle", dto);
			
			if(dto.getSelectFile()!=null) {
				String article_img_name = filemanager.doFileUpload(dto.getSelectFile(), pathname);
				
				if(article_img_name != null) {
					dto.setArticle_img_name(article_img_name);
				}
				
				Long articleNum = dao.selectOne("main.articleNum");
				
				dto.setArticleNum(articleNum);
				
				dao.insertData("main.articleImg", dto);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void updateArticle(MainDomain dto, String pathname) throws Exception {
		try {
			dao.updateData("main.updateArticle", dto);
			if(! dto.getSelectFile().getOriginalFilename().equals("")) {
				System.out.println(dto.getSelectFile() + " 널인가" + dto.getArticleNum());
				String article_img_name = filemanager.doFileUpload(dto.getSelectFile(), pathname);
				
				if(article_img_name != null) {
					dto.setArticle_img_name(article_img_name);
				}
				
				dao.deleteData("main.deleteImage", dto);
				dao.insertData("main.articleImg", dto);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteArticle(Long articleNum) throws Exception {
		try {
			dao.deleteData("main.deleteImage2", articleNum);
			dao.deleteData("main.deleteArticle", articleNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<MainDomain> articleList(Long categoryNum) {
		List<MainDomain> list = null;
		
		try {
			list = dao.selectList("main.articleList", categoryNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public MainDomain article(Map<String, Object> map) {
		MainDomain dto = null;
		
		try {
			dto = dao.selectOne("main.readArticle", map);
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Long lastCategory(Long memberNum) {
		Long categoryNum = 0L;
		
		try {
			categoryNum = dao.selectOne("main.lastCategory", memberNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(categoryNum + "최신");
		
		return categoryNum;
	}

	@Override
	public boolean insertLike(Map<String, Object> map) throws Exception {
		boolean state = false;
		
		try {
			boolean isLike = isLike(map);
			
			if(! isLike) {
				dao.updateData("main.canclePoint", map);
				state = true;
			} else {
				dao.updateData("main.point", map);
				state = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return state;
	}

	@Override
	public boolean isLike(Map<String, Object> map) {
		Boolean like = false;
		int point = 0;
		
		try {
			point = dao.selectOne("main.isLike", map);
			
			if(point == 1) {
				like = false;
			} else {
				like = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return like;
	}


}
