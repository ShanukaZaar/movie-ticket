package com.movieticket.servlet;

import com.movieticket.dao.MovieDAO;
import com.movieticket.model.Movie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

// update

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {

    private MovieDAO movieDAO = new MovieDAO();

    // Handles GET requests (show lists, forms, details)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                    listMovies(request, response);
                    break;
                case "new":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteMovie(request, response);
                    break;
                case "detail":
                    showDetail(request, response);
                    break;
                default:
                    listMovies(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // Handles POST requests (form submissions)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                addMovie(request, response);
            } else if ("update".equals(action)) {
                updateMovie(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listMovies(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String keyword = request.getParameter("search");
        List<Movie> movies;

        if (keyword != null && !keyword.isEmpty()) {
            movies = movieDAO.searchMovies(keyword);
        } else {
            movies = movieDAO.getAllMovies();
        }

        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/views/movie-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.getRequestDispatcher("/views/movie-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Movie movie = movieDAO.getMovieById(id);
        request.setAttribute("movie", movie);
        request.getRequestDispatcher("/views/movie-form.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Movie movie = movieDAO.getMovieById(id);
        request.setAttribute("movie", movie);
        request.getRequestDispatcher("/views/movie-detail.jsp").forward(request, response);
    }

    private void addMovie(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Movie movie = extractMovieFromRequest(request);
        movieDAO.addMovie(movie);
        response.sendRedirect("movies?action=list");
    }

    private void updateMovie(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Movie movie = extractMovieFromRequest(request);
        movie.setId(Integer.parseInt(request.getParameter("id")));
        movieDAO.updateMovie(movie);
        response.sendRedirect("movies?action=list");
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        movieDAO.deleteMovie(id);
        response.sendRedirect("movies?action=list");
    }

    // Reads form fields from the HTTP request and builds a Movie object
    private Movie extractMovieFromRequest(HttpServletRequest request) {
        Movie movie = new Movie();
        movie.setTitle(request.getParameter("title"));
        movie.setGenre(request.getParameter("genre"));
        movie.setDuration(Integer.parseInt(request.getParameter("duration")));
        movie.setLanguage(request.getParameter("language"));
        movie.setReleaseDate(Date.valueOf(request.getParameter("releaseDate")));
        movie.setDescription(request.getParameter("description"));
        movie.setPosterUrl(request.getParameter("posterUrl"));
        movie.setStatus(request.getParameter("status"));
        return movie;
    }
}