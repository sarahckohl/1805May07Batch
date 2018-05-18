package com.ex.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.ex.pojos.Book;
import com.ex.util.ConnectionFactory;

public class BookDao implements Dao<Book, Integer> {

	public List<Book> getAll() {
		List<Book> books = new ArrayList<Book>();
		try(Connection conn = ConnectionFactory.getInstance().getConnection();){
			String query = "select * from book";

			Statement statement = conn.createStatement();
			ResultSet rs = statement.executeQuery(query);
			
			while(rs.next()) {// book_id, isbn, title, price, genre
				Book temp = new Book();
				temp.setId(rs.getInt(1));
				temp.setIsbn(rs.getString(2));
				temp.setTitle(rs.getString(3));
				temp.setPrice(rs.getDouble(4));
				temp.setGenreId(rs.getInt(5));
				books.add(temp);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return books;
	}

	public Book findOne(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	public Book save(Book obj) {
		// TODO Auto-generated method stub
		return null;
	}

	public Book update(Book obj) {
		// TODO Auto-generated method stub
		return null;
	}

}
