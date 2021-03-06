package com.exam.BoardAction;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.exam.user.UserTO;
@Repository
public class BoardActionDAO {
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	public int comment(String writer_seq, String comment, String board_seq){
		
		//System.out.println(user_seq);
		String comment_sql = "insert into comment values (0, ?, ?, ?, now())";
		int flag = 0;
		flag = jdbcTemplate.update(comment_sql, board_seq, writer_seq, comment);
		//System.out.println(flag + "개의 records가 추가 되었습니다.");
		return flag;
	}
	
	public int comment_modify(String comment,String comment_seq) {
		String sql = "update comment set content = ? where seq=?";
		int flag = jdbcTemplate.update(sql, comment, comment_seq);
		//System.out.println("comment 중, comment_seq :"+ comment_seq+"의 comment가 수정 되었습니다." + flag);
		return flag;
	}
	
	public int comment_delete(String comment_seq) {
		String sql = "delete from comment where seq=?";
		int flag = jdbcTemplate.update(sql, comment_seq);
		//System.out.println("comment 중, comment_seq :"+ comment_seq+"의 comment가 삭제 되었습니다." + flag);
		return flag;
	}
	
	public int likey(String writer_seq, String board_seq) {
		String comment_sql = "insert into likey values (0, ?, ?, now())";
		int flag_like = 0;
		flag_like = jdbcTemplate.update(comment_sql, board_seq, writer_seq);
		//System.out.println(flag + "개의 records가 추가 되었습니다.");
		return flag_like;
	}
	
	public int unlikey(String writer_seq, String board_seq){
		String comment_sql = "delete from likey where bseq = ? and useq = ?";
		int flag_like = 0;
		flag_like = jdbcTemplate.update(comment_sql, board_seq, writer_seq);
		//System.out.println(flag_like + "개의 records가 삭제 되었습니다.");
		return flag_like;
	}
	
	public int likey_count (String seq) {
		String sql = "select count(*) from likey where bseq =?";
		int count = jdbcTemplate.queryForObject(sql, new Object[] {seq} , Integer.class);
		//System.out.println(count);
		return count;
	}
}
